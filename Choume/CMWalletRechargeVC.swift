//
//  CMWalletRecharge.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/15.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit
import SVProgressHUD
import RNLoadingButton_Swift

class CMWalletRechargeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var labelYuE: UILabel!
    @IBOutlet weak var toPayBtn: CMLoadingButton!
    @IBOutlet weak var rechargerTableVIew: UITableView!
    private var moneyCell: CMWalletRechargeMoneyCell!
    let kAppURLScheme = "choume"
    private var rechargeAmount = 0
    
    //tableView
    
    /// 0:支付宝 1:微信
    private var selectedPayWayCellIndex:Int = -1
    
    /**
     * 微信支付渠道
     */
    private let CHANNEL_WECHAT = "wx";
    /**
     * 支付宝支付渠道
     */
    private let CHANNEL_ALIPAY = "alipay";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //toPayBtn.layer.cornerRadius = 5.0
        rechargerTableVIew.dataSource = self
        rechargerTableVIew.delegate = self
        rechargerTableVIew.registerNib(UINib(nibName: "CMWalletRechargeMoneyCell", bundle: nil), forCellReuseIdentifier: "cmWalletRechargeMoneyCell")
        
        labelYuE.text = Tool.fenToyuan((CMContext.currentUser?.user?.wallet?.amount)!)
        toPayBtn.addTarget(self, action: Selector("toPay:"), forControlEvents: .TouchUpInside)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("payFinish:"), name: kRechargePayFinish, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kRechargePayFinish, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "充值"
    }
    
    
    @IBAction private func toPay(sender: UIButton) {
//        toPayBtn.showLoading()
//        return
        if moneyCell.moneyTextField.text == nil || moneyCell.moneyTextField.text == "" {
            self.cmAlert("", msg: "请输入金额")
            return
        }
        
        let amount = moneyCell.moneyTextField.text?.integerValue
        if amount == nil || amount < 1 {
            self.cmAlert("", msg: "输入的金额有误\n 必须是大于0的整数")
            return
        }
        
        rechargeAmount = amount! * 100
        
        guard selectedPayWayCellIndex != -1 else {
            self.cmAlert("", msg: "请选择支付方式")
            return
        }
        
        var channel = CHANNEL_ALIPAY
        if selectedPayWayCellIndex == 1 {
            channel = CHANNEL_WECHAT
        }
        
        
        SVProgressHUD.showProgress(-1, status: "等待支付...", maskType: .Black)
        //从服务器端拿 charge 对象
        APIClient.sharedInstance.prepareUserWalletRecharge(CMContext.sharedInstance.getToken()!, amount: rechargeAmount, appId: APPID, success: { (result) in
            if result.respStatus() == .OK {
                let history = result["history"].toUserWalletHistory()
                APIClient.sharedInstance.pingppCharge(CMContext.sharedInstance.getToken()!, appId: APPID, orderId: (history?.orderId)!, channel: channel, subject: (history?.subject)!, body: (history?.subject)!, amount: (history?.amount)!, success: { (result) in
                    if result.respStatus() == .OK {
                        // 渠道为百度钱包或者渠道为支付宝但未安装支付宝钱包
                        Pingpp.createPayment(result["charge"].string, viewController: nil, appURLScheme: self.kAppURLScheme, withCompletion: { (pingppResult, pingppError) in
                        
                            switch pingppResult {
                            case "success":
                                let amount = Tool.fenToyuan(self.rechargeAmount)+"元"
                                SVProgressHUD.showSuccessWithStatus("支付成功\n成功充值 " + amount, maskType: .Black)
                                CMContext.currentUser?.user?.wallet?.amount += self.rechargeAmount
                                self.navigationController?.popViewControllerAnimated(true)
                                break
                            case "cancel":
                                SVProgressHUD.showSuccessWithStatus("取消支付", maskType: .Black)
                                break
                            case "fail":
                                SVProgressHUD.showSuccessWithStatus("支付失败\n"+pingppError.getMsg(), maskType: .Black)
                                break
                            default: break
                            }
                        })
                    }else {
                        SVProgressHUD.dismiss()
                        self.cmAlert("系统错误", msg: result.respMsg())
                    }
                    
                    }, failure: { (error) in
                        SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
                })
            }else {
                SVProgressHUD.dismiss()
                self.cmAlert("系统错误", msg: result.respMsg())
            }
            
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
        }
        
    }
    
    // AppDelegate notification
    @IBAction private func payFinish(notify: NSNotification) {
        switch notify.userInfo!["result"] as! String {
        case "success":
            let amount = Tool.fenToyuan(rechargeAmount)+"元"
            SVProgressHUD.showSuccessWithStatus("支付成功\n成功充值 " + amount, maskType: .Black)
            CMContext.currentUser?.user?.wallet?.amount += self.rechargeAmount
            self.navigationController?.popViewControllerAnimated(true)
            break
        case "cancel":
            SVProgressHUD.showSuccessWithStatus("取消支付", maskType: .Black)
            break
        case "fail":
            let e = notify.userInfo!["error"] as! PingppError
            SVProgressHUD.showSuccessWithStatus("支付失败\n"+e.getMsg(), maskType: .Black)
            break
        default: break
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "付款方式"
        }
        return ""
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.whiteColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("cmWalletRechargeMoneyCell") as! CMWalletRechargeMoneyCell
            moneyCell = cell as! CMWalletRechargeMoneyCell
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            cell = UITableViewCell()
            cell.textLabel?.text = "支付宝"
            cell.detailTextLabel?.text = "支付宝"
            //cell.accessoryType = .Checkmark
            cell.tintColor = theme.CMNavBGColor
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            cell.textLabel?.text = "微信"
            cell.tintColor = theme.CMNavBGColor
            //cell.detailTextLabel?.text = "支付宝"
            //cell.accessoryType = .DisclosureIndicator
        }
        
        cell.textLabel?.font = UIFont(name: "", size: 12)
        cell.textLabel?.textColor = UIColor(hex: "#333333")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        }
        return 0.1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            if selectedPayWayCellIndex != -1{
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedPayWayCellIndex, inSection: 1))?.accessoryType = .None
            }
            selectedPayWayCellIndex = indexPath.row
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        }
    }

}
