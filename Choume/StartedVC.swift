import UIKit

class StartedVC: BaseViewController {
    //project categories: started,involed,stared
    var type: ProjectCategory?
    var tapGuesture: UITapGestureRecognizer?
    let MainStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        
        
//        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        let attr: NSMutableDictionary! = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        UINavigationBar.appearance().titleTextAttributes = attr as? [String: AnyObject]
//        manuallyConfigureTopBar(self, title: "ddd")
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 280
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectCell) as! CMProjectCell
        //cell.textLabel?.text = "haha"
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.projectNameLabel.text = "project name"
        cell.projectNameLabel.userInteractionEnabled = true
        cell.projectNameLabel.addGestureRecognizer(tapGuesture!)
        cell.actionButton.setImage(UIImage(named: "Icon-Setting"), forState: UIControlState.Normal)
        cell.actionButton.setTitle("", forState: .Normal)
        cell.actionButton.addTarget(self, action: "tapActionButton:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.projectSubNameLabel.text = "project sub name"
        cell.projectImage.image = UIImage(named: "gallery1")
        
        if type == .Started {
            cell.actionButton.setImage(UIImage(named: "Icon-Setting"), forState: UIControlState.Normal)
            cell.actionButton.setTitle("", forState: .Normal)
        }
        if type == .Involved {
        }
        if type == .Stared {
            cell.actionButton.setImage(UIImage(named: "Icon-Star"), forState: UIControlState.Normal)
            cell.actionButton.setTitle("", forState: .Normal)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var previewVC = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.projectPreviewVC) as! ProjectPreviewViewController
        previewVC.projectNameStr = "project " + String(indexPath.section)
        self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func configureTableView() {
        //手势
        tapGuesture = UITapGestureRecognizer(target: self, action: "tapProjectNameLabel:")
        //注册xib
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectCell)
        
        if type == .Started {
            self.navigationItem.title = "我的发起"
        }
        if type == .Involved {
            self.navigationItem.title = "我的参与"
            self.navigationItem.rightBarButtonItem?.title=""
        }
        if type == .Stared {
            self.navigationItem.title = "我的收藏"
            self.navigationItem.rightBarButtonItem?.title=""
        }
    }
    
    func tapActionButton(sender:UIButton){
        print(sender)
    }
    
    
    func setType(type: ProjectCategory){
        self.type = type
    }
    
    func sendRequest(page: Int) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StartedVC {
    // MARK: - refresh
    func refreshData(){
        
        self.sendRequest(page)
        //         be sure to stop refreshing while there is an error with network or something else
        let refreshInSeconds = 1.3
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(refreshInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
            self.page = 1
            self.gearRefreshControl.endRefreshing()
        }
        
    }
    
    // MARK: - pull up to load more
    func pullUpToLoadmore(){
        self.tableView.addFooterWithCallback({
            print("pulling up")
            self.page += 1
            print(self.page)
            
            self.sendRequest(self.page)
            let delayInSeconds: Double = 1.0
            let delta = Int64(Double(NSEC_PER_SEC) * delayInSeconds)
            let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delta)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                //                self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                
            })
        })
    }
}