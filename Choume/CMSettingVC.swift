//
//  CMSettingVC.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/17.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import UIKit

class CMSettingVC: UIViewController {

    @IBOutlet weak var setttingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setttingTableView.delegate = self
        setttingTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
    }
    
}

extension CMSettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCellWithIdentifier("settingHelpCell")!
        case 1: cell = tableView.dequeueReusableCellWithIdentifier("settingAboutCell")!
        default: cell = UITableViewCell(); break
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
