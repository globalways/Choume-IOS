//
//  CMProjectRewardSupportTypeVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/21.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

protocol CMProjectRewardSupportTypeVCDelegate {
    func supportTypeAndCount(type: CfProjectSupportType, count: UInt64)
}

class CMProjectRewardSupportTypeVC: UITableViewController {
    
    var delegate: CMProjectRewardSupportTypeVCDelegate?
    @IBOutlet weak var numTextField: UITextField!
    private var seletedIndex: Int?
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "回报类型"
        //通过这个方式启用right button
        self.editButtonItem().title = "保存"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        if let count = numTextField.text?.uint64Value {
            delegate?.supportTypeAndCount(CfProjectSupportType(rawValue: seletedIndex!+1)!, count: count)
        }
       
       self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if let index = seletedIndex {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                cell?.accessoryType = .None
            }
            seletedIndex = indexPath.row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell?.tintColor = theme.CMNavBGColor
        }
    }
}
