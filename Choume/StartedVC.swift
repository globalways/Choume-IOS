import UIKit

class StartedVC: BaseViewController {
    //project categories: started,involed,stared
    var type: ProjectCategory?
    var navigationItemTitle: String?
    var tapGuesture: UITapGestureRecognizer?
    var testData = Array<CfProject>()
    let MainStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        refreshData()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.CMWhite]
        self.navigationController?.navigationBar.translucent = false
        
        //hide right bar button item
        //self.navigationItem.rightBarButtonItem?.enabled = false
        //self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "toNewProject:"
        
        // hide button by wyp
        cornerActionButton?.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.projectNameLabel.text = testData[indexPath.section].title
        cell.projectNameLabel.userInteractionEnabled = true
        //cell.projectNameLabel.addGestureRecognizer(tapGuesture!)
        cell.actionButton.setImage(UIImage(named: "Icon-Setting"), forState: UIControlState.Normal)
        cell.actionButton.setTitle("", forState: .Normal)
        cell.actionButton.addTarget(self, action: "tapActionButton:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.projectSubNameLabel.text = testData[indexPath.section].desc
        cell.projectImage.image = UIImage(named: "img"+String(indexPath.section)+".jpg")
        
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
        let previewVC = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.projectPreviewVC) as! ProjectPreviewViewController
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CMProjectCell
        previewVC.entity = testData[indexPath.section]
        previewVC.projectImage = cell.projectImage.image
        self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return testData.count
  
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func configureTableView() {
        //手势
        //tapGuesture = UITapGestureRecognizer(target: self, action: "tapProjectNameLabel:")
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
        //从主界面查看项目列表
        if type == .Default {
            self.navigationItem.title = navigationItemTitle
            self.navigationItem.rightBarButtonItem?.title=""
        }
    }
    
    func tapActionButton(sender:UIButton){
        print(sender)
    }
    
    
    func setType(type: ProjectCategory){
        self.type = type
    }
    
    func toNewProject(sender: UIBarButtonItem) {
        let newProjectVC  = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmNewProjectVC) as! CMNewProjectVC
        self.navigationController?.pushViewController(newProjectVC, animated: true)
    }
    
    
    func sendRequest(page: Int) {

        for index in 0...3 {
            var p  = CfProject()
            
            switch index {
            case 0:
                p.title = "书房美物首篇·紫砂壶体验众筹"
                p.desc = "人需要有点通灵的精神，而通灵需要美物来实现。东方文化中的器物审美，既是实用，又可传承。比如有一间书房，不必太豪华，只需一壶茶、两卷书，便可物我齐美。"
                p.contact = "淇奥书房美物 "
            case 1:
                p.title = "极致之选—MECE真皮多功能手包"
                p.desc = "MECE的创造者是2位活跃在日本时尚界多年，且对时尚的理解有深刻见解的年轻设计师。"
                p.contact = "suanwa "
            case 2:
                p.title = "骑行台湾，不止于骑车！这只是一次跨越"
                p.desc = "朱浩，武汉大学13级本科生，现在想去台湾骑行，除了想练习英语交流，感受文化，也想拜访一些大学及其帆船队；同时为以后环游世界准备，希望实现"
                p.contact = "朱浩"
                p.fundTime = 342421322
            case 3:
                p.title = "做一件温暖的鹅绒服"
                p.desc = "我要给未曾谋面的朋友做出soul mate一样的、温暖的、高质量羽绒服，在写字楼、在公交车、在地铁、在雾霾里，努力为每一位池步的穿着者打开城市的天窗。"
                p.contact = "池步王冰 "
                p.fundTime = 342421322
            default: break
            }
            
            let m: CfProject = p
            testData.append(m)
            
        }
        
    }
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