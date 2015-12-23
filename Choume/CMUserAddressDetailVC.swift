//
//  AddressDetailVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/7.
//  Copyright © 2015年 outsouring. All rights reserved.
//
import UIKit

class AddressDetailVC: UITableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
}
