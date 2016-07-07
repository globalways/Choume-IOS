//
//  CMUserChangePwdTVC.swift
//  Choume
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMUserChangePwdTVC: UITableViewController {
    
    @IBOutlet weak var tfOrginalPwd: UITextField!
    @IBOutlet weak var tfNewPwd: UITextField!
    @IBOutlet weak var tfNewPwdRepeat: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "saveData"
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = "cancelAction"
    }
    
    /// change password
    func saveData(){
        let oldPwd = tfOrginalPwd.text
        let newPwd = tfNewPwd.text
        let newPwdRepeat = tfNewPwdRepeat.text
        
        if oldPwd == "" {
            self.noticeInfo("请输入原密码")
            return
        }
        if newPwd == "" {
            self.noticeInfo("请输入新密码")
            return
        }
        if newPwdRepeat == "" {
            self.noticeInfo("重复新密码")
            return
        }
        if newPwd != newPwdRepeat {
            self.noticeInfo("密码不匹配")
            return
        }
        
        APIClient.sharedInstance.userChangePassword(CMContext.sharedInstance.getToken(), passwordOld: (oldPwd?.MD5())!,
            passwordNew: newPwd?.MD5(), success: { (json) -> Void in
                
                print(json)
                if json.respStatus() == .OK {
                    //self.noticeTop(String)
                    //close
                    self.cancelAction()
                }else {
                    self.noticeError(json.respStatus().description())
                }
            
            }) { (error) -> Void in
                self.noticeSystemError()
                print(error)
        }
        
        
    }
    
    func cancelAction(){
        // close keyboard first
        //self.contentTextView.resignFirstResponder()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    
}
