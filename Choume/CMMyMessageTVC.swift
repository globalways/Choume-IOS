//
//  CMMyMessageTVC.swift
//  Choume
//
//  Created by wang on 16/5/2.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CMMyMessageTVC: UITableViewController {
    
    /// Data source of the tableView
    var msgs:[CfMessage] = []
    var rows:[String] = []
    
    var emptyView = CMVCEmptyView()
    
    private var spinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let loadingLabel = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
    
        self.setLoadingScreen()
        self.loadData()
        loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private methods
    
    // Load data in the tableView
    private func loadData() {
        
        // Simulate a delay of some operations as a HTTP Request
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            //self.rows = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
            self.rows = []
            self.emptyView.show(message: "jiazaiwanle22", titleOfButton: "重试")
            self.tableView.reloadData()
            self.tableView.separatorStyle = .SingleLine
            self.removeLoadingScreen()
            
            
        }
        
    }

    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRectMake(x, y, width, height)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.grayColor()
        self.loadingLabel.textAlignment = NSTextAlignment.Center
        self.loadingLabel.text = "正在加载..."
        self.loadingLabel.frame = CGRectMake(0, 0, 140, 30)
        self.loadingLabel.hidden = false
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.spinner.frame = CGRectMake(0, 0, 30, 30)
        self.spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        
        self.tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
    
    
    func loadMessages() {
        print("loadingMessages")
        let unreadCount = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
        NSLog("当前所有会话的未读消息数为：%d", unreadCount);
        let results = RCIMClient.sharedRCIMClient().getHistoryMessages(.ConversationType_SYSTEM, targetId: "88888888", objectName: "CF:message", oldestMessageId: -1, count: 10)
//        let msgs = RCIMClient.sharedRCIMClient().getHistoryMessages(.ConversationType_SYSTEM, targetId: "88888888", oldestMessageId: -1, count: 10) as! [RCMessage]
        print(results.count)
        for r in results {
//            print((r as! RCMessage).content)
            print("消息接受时间", Tool.formatTime( Int(r.receivedTime/1000) ))
            
        }
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension CMMyMessageTVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
        if emptyView.status == CMVCEmptyViewStatus.SHOWN{
            return true
        }else{
            return false
        }
    }
    
    func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        // 默认情况下上移 1/8 appHeight
        return AppHeight*3/8 - AppHeight/2
    }
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        if emptyView.status == CMVCEmptyViewStatus.SHOWN {
            return NSAttributedString(string: emptyView.msg)
        }else {
            return NSAttributedString(string: "")
        }
    }
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let attr:NSDictionary = [ NSFontAttributeName: UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: theme.CMNavBGColor ]
        if emptyView.status == CMVCEmptyViewStatus.SHOWN {
            return NSAttributedString(string: emptyView.buttonTitle, attributes: attr as! [String : AnyObject])
        }else {
            return NSAttributedString(string: "")
        }
    }
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        if emptyView.status == CMVCEmptyViewStatus.SHOWN {
            return emptyView.image
        }else {
            return UIImage(named: "")
        }
    }
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        setLoadingScreen()
        emptyView.hideAndClean()
        self.tableView.reloadEmptyDataSet()
        loadData()
    }
}
