//
//  CMProjectManagerTVC.swift
//  Choume
//
//  Created by wang on 16/5/3.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectManagerTVC: UITableViewController {
    
    var currentProject:CfProject!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        if currentProject != nil {
            self.navigationItem.title = currentProject.title!
        } else {
            self.navigationItem.title = "项目管理"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "筹钱"
            if currentProject.requiredMoneyAmount <= 0 {
                cell.detailTextLabel?.text = "暂无"
            }else {
                cell.detailTextLabel?.text = "已筹集"+Tool.fenToyuan(currentProject.alreadyMoneyAmount)+"元"
            }
            break
        case 1:
            cell.textLabel?.text = "召集小伙伴"
            if currentProject.requiredPeopleAmount <= 0 {
                cell.detailTextLabel?.text = "暂无"
            }else {
                cell.detailTextLabel?.text = "已召集"+String(currentProject.alreadyPeopleAmount)+"人"
            }
            break
        case 2:
            cell.textLabel?.text = "筹集物品"
            if currentProject.requiredGoodsAmount <= 0 {
                cell.detailTextLabel?.text = "暂无"
            }else{
                cell.detailTextLabel?.text = "已筹集["+currentProject.requiredGoodsName!+"]"+String(currentProject.requiredGoodsAmount)+"件"
            }
            break
        case 3:
            cell.textLabel?.text = "参与管理"
            cell.accessoryType = .DisclosureIndicator
            break
        case 4:
            cell.textLabel?.text = "支持方式"
            cell.accessoryType = .DisclosureIndicator
            break
        default:
            break
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 3:
            let vc = CMContext.SlidePanelSB.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmProjectManagerSupporterTVC) as! CMProjectManagerSupporterTVC
            vc.projectId = currentProject.id!
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = CMContext.SlidePanelSB.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmProjectManagerRewardTVC) as! CMProjectManagerRewardTVC
            vc.projectId = currentProject.id!
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
