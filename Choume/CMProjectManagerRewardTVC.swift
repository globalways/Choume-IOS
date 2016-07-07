//
//  CMProjectManagerRewardTVC.swift
//  Choume
//
//  Created by wang on 16/5/3.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectManagerRewardTVC: BaseViewController {
    
    private var rewards:[CfProjectReward] = []
    var projectId:Int = -1
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationItem.title = "支持方式"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectRewardCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectRewardCell)
        self.dataInitLoad()
        tableView.mj_footer.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewards.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectRewardCell, forIndexPath: indexPath) as! CMProjectRewardCell
        cell.setReward(rewards[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
 

    func loadRewards() {
        APIClient.sharedInstance.getCfProject(projectId, success: { (result) in
            if result.respStatus() == .OK {
                self.rewards = (result["project"].toCfProject()?.rewards)!
                self.tableView.reloadData()
                self.removeLoadingScreen()
            }else {
                self.loadingScreenText(result.respMsg())
            }
        }) { (error) in
            self.loadingScreenText("网络错误")
        }
    }

}

extension CMProjectManagerRewardTVC {
    override func dataInitLoad() {
        super.dataInitLoad()
        
        let timer = NSDate()
        APIClient.sharedInstance.getCfProject(projectId, success: { (result) in
            if result.respStatus() == .OK {
                self.rewards = (result["project"].toCfProject()?.rewards)!
                self.removeLoadingScreen()
                self.tableView.reloadData()
            }else {
                self.emptyViewForError(timer)
            }
        }) { (error) in
            self.emptyViewForError(timer)
        }
    }
    
    override func dataReload() {
        let timer = NSDate()
        APIClient.sharedInstance.getCfProject(projectId, success: { (result) in
            if result.respStatus() == .OK {
                self.rewards = (result["project"].toCfProject()?.rewards)!
                self.tableView.reloadData()
            }else {
                self.noticeTop("加载失败[系统错误]")
            }
        }) { (error) in
            self.noticeTop("加载失败[网络错误]")
        }
        
        Tool.uiHalfSec(timer) { 
            self.tableView.mj_header.endRefreshing()
        }
    }
}
