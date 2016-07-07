import UIKit
import SDWebImage
import DZNEmptyDataSet
import SVProgressHUD
import NYTPhotoViewer

class StartedVC: BaseViewController {
    //project categories: started,involed,stared
    var type: ProjectCategory?
    var navigationItemTitle: String?
    //首页项目列表参数
    var category: CrowdFundingCategory?
    var tag:CfProjectTag?
    var pager: CMPager = CMPager()
    
    var tapGuesture: UITapGestureRecognizer?
    var projects = Array<CfProject>()
    var invests  = Array<CfProjectInvest>()
    let MainStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        dataInitLoad()
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
    
    // MARK: - tableView methods
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 不同设备不同高度
        if (DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS) {
            return 280
        }else if (DeviceType.IS_IPHONE_6) {
           return 328
        }else if (DeviceType.IS_IPHONE_6P) {
            return 362
        }
        return 362
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
        cell.actionButton.setImage(UIImage(named: "Icon-Setting"), forState: UIControlState.Normal)
        cell.actionButton.setTitle("", forState: .Normal)
        cell.actionButton.addTarget(self, action: #selector(StartedVC.tapActionButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //section 作为button tag,后续用来判断点击了哪个项目
        cell.actionButton.tag = indexPath.section
        
        if type == .Started {
            cell.setProject(projects[indexPath.section])
            let image = UIImage(named: "Icon-Setting")
            cell.actionButton.setImage(image, forState: UIControlState.Normal)
            cell.actionButton.setTitle("", forState: .Normal)
        }
        
        if type == .Involved {
            cell.setInvests(invests[indexPath.section])
            cell.actionButton.hidden = true
        }
        
        if type == .Default{
            cell.actionButton.hidden = true
            cell.setProject(projects[indexPath.section])
        }
        
        if type == .Stared {
            //cell.actionButton.setImage(UIImage(named: "Icon-Star"), forState: UIControlState.Normal)
            cell.setProject(projects[indexPath.section])
            let img = UIImage(named: "Icon-Star-Full")
            cell.actionButton.setImage(img, forState: UIControlState.Normal)
            cell.actionButton.setTitle("", forState: .Normal)
        }
        
        cell.actionButton.tintColor = theme.CMGray666666
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previewVC = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.projectPreviewVC) as! ProjectPreviewViewController
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CMProjectCell
        
        // 如果是"我的参与",需要重新加载项目
        if type == .Involved {
           APIClient.sharedInstance.getCfProject(invests[indexPath.section].cfProjectId!, success: { (result) in
            if result.respStatus() == .OK {
                previewVC.currentProject = result["project"].toCfProject()
                previewVC.projectImage = cell.projectImage.image
                self.navigationController?.pushViewController(previewVC, animated: true)
            }else {
                SVProgressHUD.showErrorWithStatus("获取项目信息失败\n"+result.respMsg(), maskType: .Black)
            }
            }, failure: { (error) in
                SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
           })
        }else {
            previewVC.currentProject = projects[indexPath.section]
            previewVC.projectImage = cell.projectImage.image
            self.navigationController?.pushViewController(previewVC, animated: true)
        }
        // 测试UItableview
        //let detailVC = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmProjectDetailVC) as! CMProjectDetailVC
        //self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if type == .Involved {
            return invests.count
        }
        return projects.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - configure views
    
    func configureTableView() {
        //手势
        //tapGuesture = UITapGestureRecognizer(target: self, action: "tapProjectNameLabel:")
        //注册xib
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectCell)
        
        // 自适应高度有问题，禁用
//        tableView.estimatedRowHeight = 262
//        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        if type == .Started {
            let vc = CMContext.SlidePanelSB.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.cmProjectManagerTVC) as! CMProjectManagerTVC
            vc.currentProject = projects[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }else if type == .Stared {
            let clickedProject = projects[sender.tag]
            //取消收藏
            APIClient.sharedInstance.userUncollectProject(CMContext.sharedInstance.getToken()!, projectId: clickedProject.id!, success: { (result) in
                if result.codeStatus() == .OK {
                    self.projects.removeAtIndex(sender.tag)
                    self.tableView.reloadData()
                }else {
                    SVProgressHUD.showErrorWithStatus("取消收藏失败\n系统错误:"+result.msg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("取消收藏失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
        }
    }
    
    /// 设置类型：发起、参与、收藏
    func setType(type: ProjectCategory){
        self.type = type
    }
    
    /// 创建新的项目
    func toNewProject(sender: UIBarButtonItem) {
        let newProjectVC  = MainStoryBoard.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmNewProjectVC) as! CMNewProjectVC
        self.navigationController?.pushViewController(newProjectVC, animated: true)
    }
    
}

extension StartedVC {
    /// 初始化加载
    override func dataInitLoad() {
        super.dataInitLoad()
        
        if type == .Started {
            projects = (CMContext.currentUser?.fundProjects)!
            let timer = NSDate()
            if projects.count == 0 {
                self.emptyViewForNoData(timer)
            }else {
                self.removeLoadingScreen()
            }
            
            self.tableView.mj_footer.hidden = true
            self.tableView.mj_header.hidden = false
        }
        // 我的参与即投资记录
        if type == .Involved {
            invests = (CMContext.currentUser?.investProjects)!
            let timer = NSDate()
            if invests.count == 0 {
                self.emptyViewForNoData(timer)
            }else {
                self.removeLoadingScreen()
            }
            self.tableView.mj_footer.hidden = true
            self.tableView.mj_header.hidden = false
        }
        if type == .Stared {
            projects = (CMContext.currentUser?.collectedProjects)!
            let timer = NSDate()
            if projects.count == 0 {
                self.emptyViewForNoData(timer)
            }else {
                self.removeLoadingScreen()
            }
            self.tableView.mj_footer.hidden = true
            self.tableView.mj_header.hidden = false
        }
        
        //首页项目列表
        if type == .Default {
            
            APIClient.sharedInstance.findCfProject(category!, status: CfProjectStatus.PUBLISHED_CFPS, tag: tag!, page: pager.getCurrentPage(), size: pager.size, success: { (json) in
                if json.respStatus() == .OK {
                    self.projects = json["projects"].toCfProjects()
                    if self.projects.count == 0 {
                        self.emptyViewForNoData()
                    }else {
                        self.removeLoadingScreen()
                        self.tableView.reloadData()
                    }
                }else {
                    self.emptyViewForError()
                }
                
                }, failure: { (error) in
                    self.emptyViewForError()
            })
        }
    }
    
    override func dataReload() {
        switch type! {
        case .Default:
            APIClient.sharedInstance.findCfProject(category!, status: CfProjectStatus.PUBLISHED_CFPS, tag: tag!, page: pager.INIT_PAGE, size: pager.size, success: { (json) in
                if json.respStatus() == .OK {
                    self.projects = json["projects"].toCfProjects()
                    if self.projects.count == 0 {
                        self.emptyViewForNoData()
                    }else {
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.reloadData()
                    }
                }else {
                    self.noticeTop("加载错误")
                }
                
                }, failure: { (error) in
                    self.emptyViewForError()
                    print(error.localizedDescription)
                    
            })
            break
        case .Started:
            APIClient.sharedInstance.getAppUser((CMContext.currentUser?.hongId)!, success: { (result) in
                if result.respStatus() == .OK {
                    let tmpProjects = result["cfUser"].toCfUser()?.fundProjects
                    if tmpProjects?.count == 0 {
                        SVProgressHUD.showErrorWithStatus("一个项目也没有", maskType: .Black)
                    }else {
                        self.projects = tmpProjects!
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.reloadData()
                    }
                }else {
                    SVProgressHUD.showErrorWithStatus("加载失败\n"+result.respMsg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("加载失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
            break
        case .Stared:
            APIClient.sharedInstance.getAppUser((CMContext.currentUser?.hongId)!, success: { (result) in
                if result.respStatus() == .OK {
                    let tmpProjects = result["cfUser"].toCfUser()?.collectedProjects
                    if tmpProjects?.count == 0 {
                        SVProgressHUD.showErrorWithStatus("一个项目也没有", maskType: .Black)
                    }else {
                        self.projects = tmpProjects!
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.reloadData()
                    }
                }else {
                    SVProgressHUD.showErrorWithStatus("加载失败\n"+result.respMsg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("加载失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
            break
            
        case .Involved:
            APIClient.sharedInstance.getAppUser((CMContext.currentUser?.hongId)!, success: { (result) in
                if result.respStatus() == .OK {
                    let tmp = result["cfUser"].toCfUser()?.investProjects
                    if tmp?.count == 0 {
                        SVProgressHUD.showErrorWithStatus("一个项目也没有", maskType: .Black)
                    }else {
                        self.invests = tmp!
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.reloadData()
                    }
                }else {
                    SVProgressHUD.showErrorWithStatus("加载失败\n"+result.respMsg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("加载失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
            break
        default:
            //模拟加载延迟
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(0.7 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.tableView.mj_header.endRefreshing()
            }
            break
        }
    }
    
    override func dataLoadMore() {
        
        switch type! {
        case .Default:
            APIClient.sharedInstance.findCfProject(category!, status: CfProjectStatus.PUBLISHED_CFPS, tag: tag!, page: pager.getNext(), size: pager.size, success: { (json) in
                if json.respStatus() == .OK {
                    let tmpProjects = json["projects"].toCfProjects()
                    if tmpProjects.count == 0 {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        self.tableView.mj_footer.endRefreshing()
                        self.tableView.mj_footer.resetNoMoreData()
                    }else {
                        //成功加载的情况下，当前页数＋1
                        self.projects.appendContentsOf(tmpProjects)
                        self.pager.pageP1()
                        self.tableView.reloadData()
                        self.tableView.mj_footer.endRefreshing()
                    }
                }else {
                    self.emptyViewForError()
                }
                
                }, failure: { (error) in
                    self.emptyViewForError()
                    print(error)
            })
            break

        default:
            //模拟加载延迟
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(0.7 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.tableView.mj_footer.endRefreshing()
            }
            break
        }
        
        
    }
}