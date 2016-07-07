//
//  CMWalletExchangeVC.swift
//  Choume
//
//  Created by wang on 16/5/2.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import SVProgressHUD

class CMWalletExchangeVC: UIViewController {

    @IBOutlet weak var labelBanlance: UILabel!
    @IBOutlet weak var tfWant: UITextField!
    @IBOutlet weak var btnToExchange: UIButton!
    
    //余额
    private var userBanlance = (CMContext.currentUser?.user?.wallet?.amount)!
    private var cbToExchange = 0
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "兑换"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelBanlance.text = Tool.fenToyuan(userBanlance)
        btnToExchange.addTarget(self, action: "toExchange:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction private func toExchange(btn:UIButton){
        if tfWant.text?.integerValue == nil || tfWant.text?.integerValue <= 0{
            self.cmAlert("", msg: "您输入的筹币数目有误，必须是大于0的整数")
            return
        }
        if (userBanlance * 100) < tfWant.text?.integerValue {
            self.cmAlert("", msg: "余额不足")
            return
        }
        cbToExchange = (tfWant.text?.integerValue)!
        
        let msg = String(stringInterpolation: "将花费",Tool.fenToyuan(cbToExchange), "元以兑换", String(cbToExchange), "筹币")
        
        self.cmAlert("兑换", msg: msg, ok: { (okAction) in
            
            //发起兑换请求
            SVProgressHUD.showProgress(-1, status: "兑换...", maskType: .Black)
            APIClient.sharedInstance.cfUserCBExchange(CMContext.sharedInstance.getToken()!, rmb: (self.tfWant.text?.integerValue)!, password: CMContext.sharedInstance.getPwd()!, success: { (result) in
                print(result)
                //net success
                if result.respStatus() == APIStatus.OK {
                    //兑换成功
                    //self.navigationController?.popViewControllerAnimated(true)
                    self.noticeTop("兑换成功")
                    CMContext.currentUser?.coin += self.cbToExchange
                    CMContext.currentUser?.user?.wallet?.amount -= self.cbToExchange
                    SVProgressHUD.dismiss()
                    self.navigationController?.popViewControllerAnimated(true)
                }else{
                    SVProgressHUD.dismiss()
                    self.noticeError(result.respStatus().description())
                }
                
            }) { (error) in
                print(error)
                SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
            }
            }) { (cancelAction) in
                
        }
    }

}
