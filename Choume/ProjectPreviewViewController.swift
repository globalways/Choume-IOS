//
//  ProjectPreviewViewController.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/28.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit
import SVProgressHUD
import SZTextView
import NYTPhotoViewer
import SDWebImage
import ASProgressPopUpView

public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat = 35

class ProjectPreviewViewController: UIViewController, DoubleTextViewDelegate {

    var projectImage: UIImage?
    var currentProject: CfProject?
    
    /// 收藏状态图片
    private let star = UIImage(named: "Icon-Star")
    /// 未收藏状态图片
    private let star_full = UIImage(named: "Icon-Star-Full")
    
    private var bottomScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    private var commentTableView: MainTableView!
    
    // 评论输入框input toolbar 参考来源 http://www.jianshu.com/p/1f93e0fec8a5
    private var commentInputBar: UIToolbar!
    private var commentInputTextView: SZTextView!
    private var commentSendButton: UIButton!
    
    private var projectImages:[CMNYTPhoto] = []
    private var loadPhotosIsCompleted: Bool {
        get {
            if projectImages.count == currentProject?.pics.count {
                return true
            }else {
                return false
            }
        }
    }
    
    private var rewardTableView: MainTableView!
    private var investTableView: MainTableView!
    
    private var rewards: [CfProjectReward] = []
    private var comments: [CfProjectComment] = []
    private var currentNewComment: CfProjectComment?

    

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDesc: UILabel!
    @IBOutlet weak var projectMore: UILabel!
    @IBOutlet weak var projectUserAvatar: CMAvatarImageView! {
        didSet{
            projectUserAvatar.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            projectUserAvatar.image = AVATAR_PLACEHOLDER_IMAGE
        }
    }
    @IBOutlet weak var projectProgressBar: UIProgressView!
    @IBOutlet weak var labelPercent: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.rootScrollView.contentSize = CGSizeMake(AppWidth, AppHeight*2)
        configureViews()
        loadRewards()
        loadProjectComments()
        loadProjectImages()
        inputAccessoryView.hidden = true
        // 隐藏键盘
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationItem.title = "项目详情"
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationItem.title = "项目详情"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: star, style: .Plain, target: self, action: "starProject")
        configureStar()
    }
    
    private func configureViews() {
        
        projectProgressBar.progressTintColor = theme.CMNavBGColor
        let progress = Float(Tool.projectProgressDouble(currentProject!))
        projectProgressBar.progress = progress
        labelPercent.text = "达成度: " + String(progress * 100) + "%"
        
        projectName.text = currentProject?.title
        projectDesc.text = currentProject?.desc
        previewImage.image = projectImage
        Tool.loadUserAvatarToView((currentProject?.hongId)!, view: self.projectUserAvatar)
        previewImage.contentMode = .ScaleAspectFill
        previewImage.clipsToBounds = true
        
        //previewImage
        let previewImageGst = UITapGestureRecognizer(target: self, action: "previewImageTapped:")
        previewImage.userInteractionEnabled = true
        previewImage.addGestureRecognizer(previewImageGst)
        
        let moreLabelTapGusture = UITapGestureRecognizer(target: self, action: "tapMore:")
        projectMore.userInteractionEnabled = true
        projectMore.addGestureRecognizer(moreLabelTapGusture)
        
        setHorizontalViews()
        setScrollViewNav()
        setScrollView()
        setRewardTableView()
        setcommentTableView()
        setInvestTableView()
    }
    
    //处理收藏与否
    private func configureStar(){
        if CMContext.currentUser == nil {
            self.navigationItem.rightBarButtonItem?.image = star
        }else if Tool.isCollected(currentProject!) {
            self.navigationItem.rightBarButtonItem?.image = star_full
        }
    }
    
    @IBAction func previewImageTapped(sender: UITapGestureRecognizer) {
        let photoViewController = NYTPhotosViewController(photos: projectImages)
        photoViewController.delegate = self
        self.presentViewController(photoViewController, animated: true, completion: nil)
    }
    
    // 点击更多
    func tapMore(sender: UITapGestureRecognizer) {
        let vc  = CMContext.MSB.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmWebVC) as! CMWebVC
        vc.setContentOrUrl(currentProject?.intro, url: nil)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    // 收藏项目
    func starProject() {
        
        if CMContext.currentUser == nil {
            SVProgressHUD.showErrorWithStatus("登录后才能收藏哦", maskType: .Black)
            return
        }
        
        if Tool.isCollected(currentProject!){
            // 取消收藏
            APIClient.sharedInstance.userUncollectProject(CMContext.sharedInstance.getToken()!, projectId: currentProject!.id!, success: { (result) in
                if result.codeStatus() == .OK {
                    self.navigationItem.rightBarButtonItem?.image = self.star
                    CMContext.currentUser?.collectedProjects = (CMContext.currentUser?.collectedProjects.arrayRemovingObject(self.currentProject!))!
                }else {
                    SVProgressHUD.showErrorWithStatus("取消收藏失败\n系统错误:"+result.msg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("取消收藏失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
        }else {
            // 收藏
            APIClient.sharedInstance.userCollectProject(CMContext.sharedInstance.getToken()!, projectId: currentProject!.id!, success: { (result) in
                if result.codeStatus() == .OK {
                    self.navigationItem.rightBarButtonItem?.image = self.star_full
                    CMContext.currentUser?.collectedProjects.append(self.currentProject!)
                }else {
                    SVProgressHUD.showErrorWithStatus("收藏失败\n系统错误:"+result.msg(), maskType: .Black)
                }
                }, failure: { (error) in
                    SVProgressHUD.showErrorWithStatus("收藏失败\n网络错误:请检查网络连接是否正常", maskType: .Black)
            })
        }
    }
    
    func setHorizontalViews() {
        
        let fourTarget = NSBundle.mainBundle().loadNibNamed("CMFourTargetView", owner: self, options: nil)[0] as! CMFourTargetView
        fourTarget.frame = CGRectMake(0, 320, AppWidth, 50)
        fourTarget.setProject(currentProject!)
        view.addSubview(fourTarget)
        let divider2: UIView = UIView()
        divider2.frame = CGRectMake(0, 380, AppWidth, 9)
        divider2.backgroundColor = theme.CMGrayLight
        view.addSubview(divider2)
        
    }
    
    private func setScrollViewNav() {
        doubleTextView = DoubleTextView(leftText: "参与项目", rigthText: "支持者", centerText: "评   论");
        doubleTextView.frame = CGRectMake(0, 390, self.view.width, 44)
        doubleTextView.delegate = self
        view.addSubview(doubleTextView)
    }
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        bottomScrollView = UIScrollView(frame: CGRectMake(0, 434, AppWidth, AppHeight - 434))
        bottomScrollView.backgroundColor = theme.CMVCBackgroundColor
        bottomScrollView.contentSize = CGSizeMake(AppWidth * 3.0, 0)
        bottomScrollView.showsHorizontalScrollIndicator = false
        bottomScrollView.showsVerticalScrollIndicator = false
        bottomScrollView.pagingEnabled = true
        bottomScrollView.delegate = self
        bottomScrollView.clipsToBounds = true
        view.addSubview(bottomScrollView)
    }
    
    /// 支持方式列表
    private func setRewardTableView() {
        rewardTableView = MainTableView(frame: CGRectMake(0, -1, AppWidth, bottomScrollView.height), style: .Grouped, dataSource: self, delegate: self)
        rewardTableView.estimatedRowHeight = 113
        rewardTableView.rowHeight = UITableViewAutomaticDimension
        rewardTableView.sectionHeaderHeight = 0.1
        rewardTableView.sectionFooterHeight = 0.1
        rewardTableView.separatorStyle = .SingleLine
        rewardTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)
        rewardTableView.keyboardDismissMode = .Interactive
        bottomScrollView.addSubview(rewardTableView)
    }
    
    /// 项目评论列表
    private func setcommentTableView() {
        commentTableView = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, bottomScrollView.height), style: .Grouped, dataSource: self, delegate: self)
        commentTableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectCommentCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectCommentCell)
        commentTableView.estimatedRowHeight = 56
        commentTableView.rowHeight = UITableViewAutomaticDimension
        commentTableView.separatorStyle = .SingleLine
        commentTableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 40, right: 0)
        commentTableView.showsVerticalScrollIndicator = false
        bottomScrollView.addSubview(commentTableView)
    }
    
    /// 参与者列表(投资列表)
    private func setInvestTableView() {
        investTableView = MainTableView(frame: CGRectMake(2*AppWidth, -1, AppWidth, bottomScrollView.height), style: .Grouped, dataSource: self, delegate: self)
        investTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)
        investTableView.estimatedRowHeight = 67
        investTableView.rowHeight = UITableViewAutomaticDimension
        investTableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.cmProjectInvestCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.cmProjectInvestCell)
        investTableView.separatorStyle = .SingleLine
        bottomScrollView.addSubview(investTableView)
    }
    
    
    
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        bottomScrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(index), 0), animated: true)
        if index == 1 {
            UIView.animateWithDuration(0.2, animations: {
                self.inputAccessoryView.alpha = 1
                }, completion: { (finished) in
                    self.inputAccessoryView.hidden = false
            })
        }else {
            UIView.animateWithDuration(0.2, animations: {
                self.inputAccessoryView.alpha = 0
                }, completion: { (finished) in
                    self.inputAccessoryView.hidden = true
            })
        }
    }

    /// MARK: datas
    
    // 加载项目图片
    func loadProjectImages() {
        let webImageManager = SDWebImageManager.sharedManager()
        for pic in (currentProject?.pics)! {
            let url = NSURL(string: pic.url)
            webImageManager.downloadImageWithURL(url, options: SDWebImageOptions.AvoidAutoSetImage, progress: { (receivedSize, expectedSize) in
                
                
                }, completed: {(image, error, cacheType, finished, imageURL) in
                    if error == nil {
                        let p = CMNYTPhoto(image: image, imageData: nil, attributedCaptionTitle: NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()]))
                        self.projectImages.append(p)
                    }
            })
        }
        
        
    }
    
    // 加载项目回放方式
    func loadRewards() {
        APIClient.sharedInstance.getCfProject((self.currentProject?.id!)!, success: { (result) in
            print(result)
            if result.respStatus() == .OK {
                self.rewards = (result["project"].toCfProject()?.rewards)!
//                self.rewards[0].desc = "这是测试数据\n1、少吃多睡\n2、多吃多睡\n3、多吃不睡"
                self.rewardTableView.reloadData()
                self.currentProject = result["project"].toCfProject()
                self.rewardTableView.reloadData()
                // 投资者列表刷新
                self.investTableView.reloadData()
                //self.tableView.reload4Data()
                //self.removeLoadingScreen()
            }else {
                self.noticeError(result.respMsg())
            }
        }) { (error) in
            
        }
    }
    
    /// 加载项目评论
    func loadProjectComments() {
        APIClient.sharedInstance.loadCfProjectComments(currentProject!.id!, success: { (result) in
            if result.respStatus() == .OK {
                self.comments = result["comments"].toCfProjectComments()
                self.commentTableView.reloadData()
            }else {
                SVProgressHUD.showErrorWithStatus("加载评论列表失败(系统错误)",maskType: .Black)
            }
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("加载评论列表失败(网络错误)\n请检查网络连接是否正常",maskType: .Black)
        }
    }
    /// 新增项目评论
    func tapToNewComment(sender: UIButton) {
        if CMContext.currentUser == nil {
            SVProgressHUD.showErrorWithStatus("请先登录后发表评论", maskType: .Black)
            return
        }
        
        if commentInputTextView.text!.isEmpty {
            SVProgressHUD.showErrorWithStatus("没有输入内容哦", maskType: .Black)
            return
        }
        dismissKeyboard()
        APIClient.sharedInstance.newCfProjectComment(CMContext.sharedInstance.getToken()!, projectId: currentProject!.id!, repliedUserId: commentInputTextView.tag, content: commentInputTextView.text!, success: { (result) in
            print(result)
            if result.respStatus() == .OK {
                self.currentNewComment = result["comment"].toCfProjectComment()
                self.comments.append(self.currentNewComment!)
                self.commentTableView.reloadData()
                self.resumeInput()
            }else {
                SVProgressHUD.showErrorWithStatus("系统错误\n"+result.respMsg(), maskType: .Black)
            }
            
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("网络错误\n请检查网络连接是否正常", maskType: .Black)
        }
    }
    
}

/// 评论输入框相关
extension ProjectPreviewViewController: NYTPhotosViewControllerDelegate {
    func dismissKeyboard() {
        commentInputTextView.resignFirstResponder()
    }
    
    func resumeInput() {
        self.commentInputTextView.text = ""
        self.commentInputTextView.placeholder = ""
        self.commentInputTextView.tag = 0
    }
    // 评论输入框
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override var inputAccessoryView: UIView! {
        get {
            if commentInputBar == nil {
                commentInputBar = UIToolbar(frame: CGRectMake(0, 0, 0, 41-0.5))
                
                commentInputTextView = SZTextView(frame: CGRectZero)
                commentInputTextView.backgroundColor = UIColor(white: 250/255, alpha: 1)
                commentInputTextView.font = UIFont.systemFontOfSize(17)
                commentInputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor
                commentInputTextView.layer.borderWidth = 0.5
                commentInputTextView.layer.cornerRadius = 5
                commentInputTextView.scrollsToTop = false
                commentInputTextView.textContainerInset = UIEdgeInsetsMake(4, 3, 3, 3)
                commentInputBar.addSubview(commentInputTextView)
                
                commentSendButton = UIButton(type: .System)
                commentSendButton.enabled = true
                commentSendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                commentSendButton.setTitle("发送", forState: .Normal)
                commentSendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: .Disabled)
                commentSendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: .Normal)
                commentSendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                commentSendButton.addTarget(self, action: #selector(ProjectPreviewViewController.tapToNewComment), forControlEvents: UIControlEvents.TouchUpInside)
                commentInputBar.addSubview(commentSendButton)
                
                // 对组件进行Autolayout设置
                commentInputTextView.translatesAutoresizingMaskIntoConstraints = false
                commentSendButton.translatesAutoresizingMaskIntoConstraints = false
                
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentInputTextView, attribute: .Left, relatedBy: .Equal, toItem: commentInputBar, attribute: .Left, multiplier: 1, constant: 8))
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentInputTextView, attribute: .Top, relatedBy: .Equal, toItem: commentInputBar, attribute: .Top, multiplier: 1, constant: 7.5))
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentInputTextView, attribute: .Right, relatedBy: .Equal, toItem: commentSendButton, attribute: .Left, multiplier: 1, constant: -2))
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentInputTextView, attribute: .Bottom, relatedBy: .Equal, toItem: commentInputBar, attribute: .Bottom, multiplier: 1, constant: -8))
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentSendButton, attribute: .Right, relatedBy: .Equal, toItem: commentInputBar, attribute: .Right, multiplier: 1, constant: 0))
                commentInputBar.addConstraint(NSLayoutConstraint(item: commentSendButton, attribute: .Bottom, relatedBy: .Equal, toItem: commentInputBar, attribute: .Bottom, multiplier: 1, constant: -4.5))
            }
            return commentInputBar
        }
    }
    
    
    func photosViewController(photosViewController: NYTPhotosViewController, loadingViewForPhoto photo: NYTPhoto) -> UIView? {
//        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
//            let label = UILabel()
//            label.text = "Custom Loading..."
//            label.textColor = UIColor.greenColor()
//            return label
//        }
//        return nil
        let label = UILabel()
        label.text = "Custom Loading..."
        label.textColor = UIColor.greenColor()
        return label
    }
}



/// MARK: tableview cells actions

extension ProjectPreviewViewController: ProjectToInvestDelegate {
    // 支持项目
    func onRewardClicked(reward: CfProjectReward) {
        let vc = CMContext.MSB.instantiateViewControllerWithIdentifier(MainStoryboard.VCIdentifiers.cmNewInvestCV) as! CMNewInvestCV
        vc.project = self.currentProject
        vc.reward = reward
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/// MARK: UIScrollViewDelegate
extension ProjectPreviewViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === bottomScrollView {
            let index = Int(scrollView.contentOffset.x / AppWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}

/// MARK:- UITableViewDelegate和UITableViewDataSource
extension ProjectPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //注册xib
        tableView.registerNib(UINib(nibName: MainStoryboard.NibIdentifiers.joinProjectCell, bundle: nil), forCellReuseIdentifier: MainStoryboard.CellIdentifiers.joinProjectCell)
        
        switch tableView {
        case rewardTableView:
            return rewards.count
        case commentTableView:
            return comments.count
        case investTableView:
            return (currentProject?.invests.count)!
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch tableView {
        case rewardTableView:
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.joinProjectCell) as! JoinProjectCell
            cell.delegate = self
            cell.setReward(rewards[indexPath.row])
            return cell
        case investTableView:
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectInvestCell) as! CMProjectInvestCell
            cell.selectionStyle = .None
            cell.setInvest((currentProject?.invests[indexPath.row])!)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.CellIdentifiers.cmProjectCommentCell) as! CMProjectCommentCell
            cell.setComment(self.comments[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let tapedComment = comments[indexPath.row]
        if tableView == commentTableView {
            if CMContext.currentUser != nil {
                if CMContext.currentUser?.hongId != tapedComment.userId {
                    //被回复用户id存tag
                    commentInputTextView.tag = tapedComment.userId!
                    commentInputTextView.placeholder = String(stringInterpolation: "回复 ", tapedComment.userNick!)
                }else {
                    commentInputTextView.placeholder = ""
                }
            }
            
        }
    }
}
