//
//  CMProjectManagerSupporterTVC.swift
//  Choume
//
//  Created by wang on 16/5/3.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectManagerSupporterTVC: BaseViewController {
    
    private var invests:[CfProjectInvest] = []
    var projectId:Int = -1
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationItem.title = "参与管理"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectInvestCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectInvestCell)
        dataInitLoad()
        self.tableView.mj_footer.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invests.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectInvestCell, forIndexPath: indexPath) as! CMProjectInvestCell

        cell.setInvest(invests[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = CMContext.SlidePanelSB.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmProjectInvestDetailVC) as! CMProjectInvestDetailVC
        vc.invest = invests[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CMProjectManagerSupporterTVC {
    override func dataInitLoad() {
        super.dataInitLoad()
        let timer = NSDate()
        APIClient.sharedInstance.getCfProject(projectId, success: { (result) in
            if result.respStatus() == .OK {
                let tmpInvests = (result["project"].toCfProject()?.invests)!
                if tmpInvests.count < 1 {
                    self.emptyViewForNoData(timer)
                }else {
                    self.invests = tmpInvests
                    self.removeLoadingScreen()
                    self.tableView.reloadData()
                }
            }else { self.emptyViewForError(timer) }
        }) { (error) in
            self.emptyViewForError(timer)
        }
    }
    
    override func dataReload() {
        let timer = NSDate()
        APIClient.sharedInstance.getCfProject(projectId, success: { (result) in
            let s = timer.timeIntervalSinceNow
            if result.respStatus() == .OK {
                self.invests = (result["project"].toCfProject()?.invests)!
                self.tableView.reloadData()
            }else { self.noticeTop("系统错误") }
        }) { (error) in
            self.noticeTop("网络错误")
        }
        Tool.uiHalfSec(timer) { 
            self.tableView.mj_header.endRefreshing()
        }
    }
}
