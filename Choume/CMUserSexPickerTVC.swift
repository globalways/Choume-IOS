//
//  CMUserSexPickerTVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/20.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMUserSexPickerTVC: UITableViewController {

    //UserSex
    var sexs:[String] =  UserSex.descs()
    
    var selectedSex:UserSex? {
        didSet {
            if let sex = selectedSex {
                selectedSexIndex = sexs.indexOf(sex.desc())!
            }
        }
    }
    var selectedSexIndex:Int?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sexs.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSexCell", forIndexPath: indexPath)
        cell.textLabel?.text = sexs[indexPath.row]
        cell.tintColor = theme.CMNavBGColor
        if indexPath.row == selectedSexIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let index = selectedSexIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedSex = UserSex(rawValue: indexPath.row)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedSex" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    selectedSex = UserSex(rawValue: index)
                }
            }
        }
    }
}
