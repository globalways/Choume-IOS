//
//  CMProjectInvestDetailVC.swift
//  Choume
//
//  Created by wang on 16/5/16.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import SVProgressHUD

class CMProjectInvestDetailVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnPass: UIButton!
    
    var invest: CfProjectInvest!
    var userAddress: UserAddress?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectInvestCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectInvestCell)
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.userAddressCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.userAddressCell)
        
        configureView()
        
        if invest.addrId != 0 {
            loadAddr()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func configureView() {
        if invest.rewardSupportType !=  CfProjectSupportType.EQUITY_CFPST {
            btnPass.hidden = true
            btnDecline.hidden = true
        }else {
            btnDecline.addTarget(self, action: #selector(CMProjectInvestDetailVC.rejectInvest), forControlEvents: .TouchUpInside)
            btnPass.addTarget(self, action: #selector(CMProjectInvestDetailVC.passInvest), forControlEvents: .TouchUpInside)
        }
    }

}

extension CMProjectInvestDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectInvestCell) as! CMProjectInvestCell
            cell.setInvest(invest)
            cell
            return cell
        case 1:
            if invest.addrId == 0 {
                return UITableViewCell()
            }else {
                if self.userAddress == nil {
                    let cell = UITableViewCell()
                    cell.textLabel?.font = UIFont.systemFontOfSize(14)
                    cell.textLabel?.textColor = UIColor.grayColor()
                    cell.textLabel?.text = ":( 无法获取用户地址信息"
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCellWithIdentifier( MainStoryboard.CellIdentifiers.userAddressCell) as! UserAddressCell
                    cell.setAddr(self.userAddress!)
                    return cell
                }
            }
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFontOfSize(14)
            cell.textLabel?.text = invest.comment
            return cell
        case 3:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            if indexPath.row == 0 {
                cell.textLabel?.text = "份数"
                cell.detailTextLabel?.text = String(invest.rewardCount)
            }else
            if indexPath.row == 1 {
                cell.textLabel?.text = "每份需要支持"
                cell.detailTextLabel?.text = invest.rewardSupportType.desc(invest.rewardAmount)
            } else
            if indexPath.row == 2 {
                cell.textLabel?.text = "总计"
                cell.detailTextLabel?.text = Tool.generateAbbr(invest)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 0.1
        case 1:
            if invest.addrId == 0{
                return 0.01
            }else {
                return 28
            }
        default: return 28
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            if invest.addrId == 0{
                return nil
            }else {
                return "联系与地址"
            }
        case 2: return "备注信息"
        case 3: return "支持信息"
        default: return ""
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3: return 3
        default: return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 67
        case 1:
            if invest.addrId == 0{
                return 0
            }else {
                if self.userAddress == nil { return 44 }
                return 75
            }
        default: return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension CMProjectInvestDetailVC {
    func loadAddr() {
            APIClient.sharedInstance.getUserAddr(invest.addrId, success: { (json) in
                if json.respStatus() == .OK {
                    self.userAddress = json["addr"].toUserAddress()
                    self.tableView.reloadData()
                }else {
                    self.tableView.reloadData()
                }
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("获取用户地址失败\n网络错误,请检查网络连接是否正常", maskType: .Black)
                self.tableView.reloadData()
            }
        
    }
    
    func passInvest() {
        APIClient.sharedInstance.passCfProjectInvest(CMContext.sharedInstance.getToken()!, investId: (self.invest?.id)!, success: { (result) in
            if result.codeStatus() == .OK {
                self.btnPass.hidden = true
                self.btnDecline.hidden = true
                self.noticeTop("通过成功")
            }else {
                self.cmAlert("通过失败", msg: result.msg())
            }
        }) { (error) in
                SVProgressHUD.showErrorWithStatus("通过失败\n网络错误,请检查网络连接是否正常", maskType: .Black)
        }
    }
    
    func rejectInvest() {
        APIClient.sharedInstance.rejectCfProjectInvest(CMContext.sharedInstance.getToken()!, investId: (self.invest?.id)!, success: { (result) in
            if result.codeStatus() == .OK {
                self.btnPass.hidden = true
                self.btnDecline.hidden = true
                self.noticeTop("拒绝成功")
            }else {
                self.cmAlert("拒绝失败", msg: result.msg())
            }
        }) { (error) in
            SVProgressHUD.showErrorWithStatus("拒绝失败\n网络错误,请检查网络连接是否正常", maskType: .Black)
        }
    }
}
