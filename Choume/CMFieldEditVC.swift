//
//  CMFieldEditVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/20.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

protocol CMFieldEditVCDelegate {
    func fieldEditVCResponse(para: String)
}

class CMFieldEditVC: UIViewController {
    
    @IBOutlet weak var fieldsTableView: UITableView!
    private var fieldCell: CommonFieldCell!
    private var newData: String?
    var original: String = ""
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem?.title = "保存"
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "saveData"
        self.navigationItem.title = "修改昵称"
        fieldsTableView.delegate = self
        fieldsTableView.dataSource = self
    }
    
    var delegate: CMFieldEditVCDelegate?
    
    func saveData(){
        
        let cell = fieldsTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CommonFieldCell
        newData = cell.getFieldText()
        if newData == CMContext.currentUser?.user?.nick {
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        
        delegate?.fieldEditVCResponse(newData!)
        
        APIClient.sharedInstance.userChangeNick(CMContext.sharedInstance.getToken(), nick: newData!, success: { (json) -> Void in
            let code = json[APIClient.CODE].intValue
            
            if APIStatus(rawValue: code) == .OK {
                //退出
               self.navigationController?.popViewControllerAnimated(true)
            }else {
                
            }
            }, failure: { (error) -> Void in
                print(error)
                self.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
        })
        
    }
    
}

extension CMFieldEditVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fieldCell = tableView.dequeueReusableCellWithIdentifier("commonFieldCell") as! CommonFieldCell
        fieldCell.commonTextField.text = original
        return fieldCell
    }
}

class CommonFieldCell: UITableViewCell {
    
    @IBOutlet weak var commonTextField: UITextField!
    func getFieldText() -> String{
        return commonTextField.text!
    }
}
