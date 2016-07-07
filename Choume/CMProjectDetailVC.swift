//
//  CMProjectDetailVC.swift
//  Choume
//
//  Created by wang on 16/5/29.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMProjectDetailVC: UITableViewController {
    
    var stretchyHeader: GSKStretchyHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 8.2, *) {
            self.stretchyHeader =  ScalableLabelHeaderView(frame: CGRectMake(0,0, AppWidth,200))
        } else {
            // Fallback on earlier versions
        }
//        let headerView = CMProjectDetailHeaderView(frame: CGRectMake(0, 0, AppWidth, 200))
        let headerView = NSBundle.mainBundle().loadNibNamed("CMProjectDetailHeaderView", owner: self, options: nil)[0] as! CMProjectDetailHeaderView
//        headerView.backgroundColor = UIColor.redColor()
        //self.stretchyHeader.stretchDelegate = self
        headerView.stretchDelegate = self
        self.tableView.addSubview(headerView)
        
//        stretchyHeader.stretchDelegate = self
//        self.tableView.addSubview(stretchyHeader)
        
    }
}


extension CMProjectDetailVC: GSKStretchyHeaderViewStretchDelegate{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    func stretchyHeaderView(headerView: GSKStretchyHeaderView, didChangeStretchFactor stretchFactor: CGFloat) {
        NSLog("didChangeStretchFactor %f", stretchFactor)
    }
}