//
//  CMNewInvestCV.swift
//  Choume
//
//  Created by wang on 16/5/25.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import GMStepper
import SVProgressHUD

class CMNewInvestCV: UITableViewController {

    var project: CfProject?
    var reward: CfProjectReward!
    
    var selectedAddr: UserAddress?
    let stepper = GMStepper(frame: CGRectMake(AppWidth - 115, 7, 100, 30))
    let commentField = UITextField(frame: CGRectMake(15, 4, AppWidth-30, 36))
    var totalCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("newInvest"))
        self.navigationItem.title = "参与项目"
        
        

        self.tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.userAddressCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.userAddressCell)
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNewInvestDidSelectedAddr, object: nil)
    }
    
    private func configureView() {
        
        // comment commentField
        
        commentField.borderStyle = .None
        commentField.font = UIFont.systemFontOfSize(14)
        commentField.tintColor = UIColor.blackColor()
        
        
        // stepper
        stepper.minimumValue = 1
        stepper.maximumValue = 1000
        stepper.labelBackgroundColor = theme.CMWhite
        stepper.labelFont = UIFont.systemFontOfSize(14)
        stepper.labelTextColor = UIColor.grayColor()
        stepper.borderColor = theme.CMNavBGColor
        stepper.borderWidth = 1
        stepper.buttonsBackgroundColor = theme.CMWhite
        stepper.buttonsTextColor = theme.CMNavBGColor
        stepper.addTarget(self, action: #selector(CMNewInvestCV.stepperValueChanged), forControlEvents: .ValueChanged)
        
        // address selection
        if (reward!.needAddr) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didSelectedAddr:"), name: kNewInvestDidSelectedAddr, object: nil)
        }
        
    }
    
    @IBAction private func didSelectedAddr(notify: NSNotification) {
        selectedAddr = notify.userInfo!["addr"] as! UserAddress
        self.tableView.reloadData()
    }
    
    func stepperValueChanged(stepper: GMStepper) {
        totalCell?.detailTextLabel?.text = reward?.supportType?.desc((reward?.amount)! * Int(stepper.value))
    }
    
    // 创建投资
    @IBAction private func newInvest() {
        
        if reward.needAddr && selectedAddr == nil {
            self.cmAlert("", msg: "请选择地址")
            return
        }
        
        // 筹币不足
        if reward.supportType == CfProjectSupportType.MONEY_CFPST && CMContext.currentUser?.coin < (reward?.amount)! * Int(stepper.value) {
            self.cmAlert("", msg: "您筹币不足\n请到个人中心兑换")
            return
        }
        
        SVProgressHUD.showProgress(-1, maskType: .Black)
        let comment = commentField.text
        let userToken = CMContext.sharedInstance.getToken()!
        APIClient.sharedInstance.newCfProjectInvest(userToken, cfProjectId: project!.id!, cfProjectRewardId: reward.id!, count: Int(stepper.value), comment: comment, addrId: selectedAddr?.id, success: { (result) in
            if result.respStatus() == .OK {
                let resultInvest = result["invest"].toCfProjectInvest()
                // 参与项目成功后支付相应筹币
                if resultInvest?.rewardSupportType == CfProjectSupportType.MONEY_CFPST {
                    SVProgressHUD.showSuccessWithStatus("系统成功受理参与项目")
                    let cbs = (resultInvest?.rewardCount)! * (resultInvest?.rewardAmount)!
                    SVProgressHUD.showProgress(-1, status: "准备支付...", maskType: .Black)
                    APIClient.sharedInstance.cfUserCBConsume(userToken, coin: cbs, orderId: (resultInvest?.orderId)!, success: { (result) in
                        if result.respStatus() == .OK {
                            //支付成功
                            CMContext.currentUser?.coin -= cbs
                            SVProgressHUD.showSuccessWithStatus("支付完成！")
                            self.navigationController?.popViewControllerAnimated(true)
                        }else {
                            //支付失败
                            SVProgressHUD.dismiss()
                            self.cmAlert("系统错误,支付失败", msg: "本次参与项目失败,请重试")
                        }
                        }, failure: { (error) in
                            SVProgressHUD.dismiss()
                            self.cmAlert("网络错误,支付失败", msg: "本次参与项目失败,请恢复网络连接后重试")
                            SVProgressHUD.showErrorWithStatus("网络错误,支付失败\n 参与项目失败! ", maskType: .Black)
                    })
                }else if resultInvest?.rewardSupportType == CfProjectSupportType.EQUITY_CFPST{
                    SVProgressHUD.dismiss()
                    self.cmAlert("参与项目成功", msg: "请等待审核")
                    
                    Tool.afterSec(3, completion: {
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    
                }else {
                    SVProgressHUD.showSuccessWithStatus("参与项目成功!")
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }else {
                SVProgressHUD.showErrorWithStatus("参与项目失败!\n (系统错误)", maskType: .Black)
            }
            
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("参与项目失败!\n (网络错误，请检查网络连接是否正常x)", maskType: .Black)
        }
    }

}

// MARK: - Table view data source
extension CMNewInvestCV {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2: return 3
        default: return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if !(reward?.needAddr)! {
                return UITableViewCell()
            } else {
                if selectedAddr == nil {
                    let cell = UITableViewCell()
                    let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    label.center = cell.center
                    label.textAlignment = .Center
                    label.font = UIFont.systemFontOfSize(14)
                    label.textColor = UIColor.grayColor()
                    label.text = "点触以选择地址"
                    cell.addSubview(label)
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.userAddressCell) as! UserAddressCell
                    cell.setAddr(selectedAddr!)
                    return cell
                }
            }
        case 1:
            let cell = UITableViewCell()
            commentField.borderStyle = .RoundedRect
            commentField.font = UIFont.systemFontOfSize(14)
            commentField.tintColor = UIColor.blackColor()
            cell.addSubview(commentField)
            return cell
        case 2:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            if indexPath.row == 0 {
                cell.textLabel?.text = "选择份数"
                cell.detailTextLabel?.hidden = true
                cell.addSubview(stepper)
                
            }
            if indexPath.row == 1 {
                cell.textLabel?.text = "需要支持"
                cell.detailTextLabel?.text = reward?.supportType?.desc(reward!.amount)
            }
            if indexPath.row == 2 {
                cell.textLabel?.text = "总计"
                cell.detailTextLabel?.text = reward?.supportType?.desc((reward?.amount)! * Int(stepper.value))
                totalCell = cell
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if !(reward?.needAddr)! {
                return 0
            }else { return 75 }
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "联系与地址"
        case 1: return "备注信息(可选)"
        case 2: return "支持信息"
        default: return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && !(reward?.needAddr)!{
            return 0.01
        }
        return 28
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //选择地址
        if indexPath.section == 0 {
            let vc = CMContext.MSB.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmUserAddressTVC) as! CMUserAddressTVC
            vc.action = 101
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}