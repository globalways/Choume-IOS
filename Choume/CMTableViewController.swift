//
//  CMTableViewController.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/7.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMTableViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
}
