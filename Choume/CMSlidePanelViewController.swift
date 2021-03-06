import UIKit
import SwiftyJSON

protocol ToggleLeftPanelDelegate{
    func toggleLeftPanel()
    func removeFrontBlurView()
}

class SlidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CMSlidePanelNoLoginDelegate {
    
    @IBOutlet weak var userNameLabel: UILabel!{
        didSet{
            self.configureUserInfoView(userNameLabel)
        }
    }
    @IBOutlet weak var userProfileImage: CMAvatarImageView!{
        didSet{
            userProfileImage.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            userProfileImage.image = AVATAR_PLACEHOLDER_IMAGE
            self.configureLoginAndLogoutView(userProfileImage)
            
        }
    }
    var delegate: ToggleLeftPanelDelegate!
    private let cellTitleArray = ["我的发起", "我的参与", "我的收藏", "我的财富","我的消息","系统设置","登出账户"]
    private let cellTitleImage = ["Icon-Cloud","Icon-People","Icon-Star","Icon-Card","Icon-Msg","Icon-Setting","Icon-Out"]
    private var loginedViews: [UIView] = []
    private var noLoginView: CMSlidePanelNoLogin!
    
    private var blurView: UIView!
    private var themePickerView: UIView!
    private var themePickerBar: FrostedSidebar!
    @IBOutlet weak var tableView: UITableView!
    let slidePanelStoryboard = UIStoryboard(name: "IBBSSlidePanel", bundle: NSBundle.mainBundle())
    
    override func loadView() {
        super.loadView()
        
        loginedViews = view.subviews
        noLoginView = CMSlidePanelNoLogin.instanceFromNib() as! CMSlidePanelNoLogin
        noLoginView.frame = CGRectMake(0, 0, kExpandedOffSet, AppHeight)
        noLoginView.delegate = self
        
        //如果内存中没有用户数据（本地加载失败），则显示为用户没有登录
        if CMContext.currentUser == nil {
            showNoLoginView()
        }
        userNameLabel.text = "小明"
        
        //by wyp
//        self.view.backgroundColor = UIColor(patternImage: BACKGROUNDER_IMAGE!)
        self.view.backgroundColor = UIColor.whiteColor()
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.frame = self.view.frame
        blurView.alpha = BLUR_VIEW_ALPHA_OF_BG_IMAGE
//        self.view.insertSubview(blurView, atIndex: 0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.scrollEnabled = false
        
        NSNotificationCenter.defaultCenter().postNotificationName(kShouldHideCornerActionButton, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        CMContext.sharedInstance.configureCurrentUserAvatar(self.userProfileImage, label: self.userNameLabel)
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName(kShouldHideCornerActionButton, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.blurView.frame = self.view.frame

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if themePickerBar != nil {
            self.showThemePickerView()
        }
    }
    
    ///显示未登录界面
    func showNoLoginView() {
        for var i=0;i<loginedViews.count;i++ {
            loginedViews[i].hidden = true
        }
        view.addSubview(noLoginView)
    }
    
    ///隐藏未登录界面
    func hideNoLoginView() {
        noLoginView.hidden = true
        for var i=0;i<loginedViews.count;i++ {
            loginedViews[i].hidden = false
        }
    }
    
    ///未登陆界面view被点击了
    func nologinView(noLoginView: CMSlidePanelNoLogin, didTapView sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case noLoginView.LOGINTAP?:
            toLogin()
            break
        case noLoginView.HELPTAP?:
            print("help")
            break
        case noLoginView.REGISTERTAP?:
            toRegister()
            break
        default:break
        }
    }
    
    func toLogin() {
        self.delegate?.toggleLeftPanel()
        CMContext.sharedInstance.login(cancelled: {
            self.delegate?.removeFrontBlurView()
            }, completion: {
                //登录完成后显示登录后界面
                self.hideNoLoginView()
                CMContext.sharedInstance.configureCurrentUserAvatar(self.userProfileImage, label: self.userNameLabel)
                self.delegate?.removeFrontBlurView()
                //                NSNotificationCenter.defaultCenter().postNotificationName(kShouldReloadDataAfterPosting, object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName(kJustLoggedinNotification, object: nil)
        })
    }
    
    func toLogout() {
        CMContext.sharedInstance.logout(completion: {
            self.userProfileImage.image = AVATAR_PLACEHOLDER_IMAGE
            self.showNoLoginView()
        })
    }
    
    func toRegister() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("iBBSRegisterViewController") as! CMRegisterViewController
        
        //            UIView.animateWithDuration(0.75, animations: { () -> Void in
        //                UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        //                self.navigationController?.pushViewController(vc, animated: true)
        //                UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: self.navigationController!.view, cache: false)
        //            })
        self.navigationController?.pushViewController(vc, animated: true)
        self.delegate?.toggleLeftPanel()
        
        // after pushing view controller, remove the blur view
        let delayInSeconds: Double = 1
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * delayInSeconds))
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.delegate?.removeFrontBlurView()
        })
    }
    
    // MARK: - configure user info by wyp
    func configureUserInfoView(sender: UILabel) {
        let tapUser = UITapGestureRecognizer(target: self, action: "showUserInfo:")
        sender.addGestureRecognizer(tapUser)
        sender.userInteractionEnabled = true
    }
    
    func showUserInfo(sender: UITapGestureRecognizer){
        var userInfoVC: UIViewController!
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        userInfoVC = mainStoryBoard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.userInfoNav)
        self.navigationController?.showViewController(userInfoVC, sender: nil)
        //self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    @IBAction func cancelUserInfo(segue: UIStoryboardSegue) {}
    @IBAction func saveUserInfo(segue: UIStoryboardSegue) {}
    
    // MARK: - configure login and register
    func configureLoginAndLogoutView(sender: UIImageView){
        let longTapGesture = UILongPressGestureRecognizer(target: self , action: "loginOrLogout:")
        sender.addGestureRecognizer(longTapGesture)
        let tapUser = UITapGestureRecognizer(target: self, action: "showUserInfo:")
        sender.addGestureRecognizer(tapUser)
        sender.userInteractionEnabled = true
    }
    
    func loginOrLogout(gesture: UIGestureRecognizer){
        if gesture.state == .Began {
            
            if CMContext.sharedInstance.getLoginData() == nil {
                // login or register
                self.alertToChooseLoginOrRegister()
            }
            //不主动验证token by wyp
            //else
            if false {
                CMContext.sharedInstance.isTokenLegal({ (isTokenLegal) -> Void in
                    if isTokenLegal {
                        // do logout
                        CMContext.sharedInstance.logout(completion: {
                            self.userProfileImage.image = AVATAR_PLACEHOLDER_IMAGE
                        })
                    } else {
                        // login again
                        let alertVC = UIAlertController(title: TOKEN_LOST_EFFECTIVENESS, message: PLEASE_LOGIN_AGAIN, preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: BUTTON_OK, style: .Default, handler: { (_) -> Void in
                            self.delegate?.toggleLeftPanel()
                            CMContext.sharedInstance.login(cancelled: {
                                self.delegate?.removeFrontBlurView()
                                }, completion: {
                                    CMContext.sharedInstance.configureCurrentUserAvatar(self.userProfileImage, label: self.userNameLabel)
                                    self.delegate?.removeFrontBlurView()
//                                    NSNotificationCenter.defaultCenter().postNotificationName(kShouldReloadDataAfterPosting, object: nil)
                            })

                        })
                        let cancelAction = UIAlertAction(title: BUTTON_CANCEL, style: .Cancel, handler: nil)
                        alertVC.addAction(cancelAction)
                        alertVC.addAction(okAction)
                        self.presentViewController(alertVC, animated: true, completion: nil)
                        
                    }
                })
                
                
               
            }
           
        }
        
    }
    
    func alertToChooseLoginOrRegister(){
        let alertCtrl = CMAlertController(title: "", message: REGISTER_OR_LOGIN, preferredStyle: .Alert)
        let loginAction = UIAlertAction(title: BUTTON_LOGIN, style: .Default) { (_) -> Void in
            // login
            self.toLogin()
        }
        let registerAction = UIAlertAction(title: BUTTON_REGISTER, style: .Default) { (_) -> Void in
            self.toRegister()
        }
        alertCtrl.addAction(loginAction)
        alertCtrl.addAction(registerAction)
        self.presentViewController(alertCtrl, animated: true, completion: nil)
    }
    
    // MARK: - configure theme
    func showThemePickerView(){
        let imageArray = [UIImage](count: themeColorArray.count, repeatedValue: UIImage(named: "clear_color_image")!)
        
        themePickerBar = FrostedSidebar(itemImages: imageArray, colors: themeColorArray, selectedItemIndices: NSIndexSet(index: 0))
        themePickerBar.width = kExpandedOffSet
        themePickerBar.borderWidth = 10.0
        themePickerBar.itemSize = CGSizeMake(60, 60)
        themePickerBar.isSingleSelect = true
        themePickerBar.actionForIndex = [
            0: {self.changeThemeAndDismissSelf(.DefaultTheme)},
            1: {self.changeThemeAndDismissSelf(.RedTheme)},
            2: {self.changeThemeAndDismissSelf(.GreenTheme)},
            3: {self.changeThemeAndDismissSelf(.YellowTheme)},
            4: {self.changeThemeAndDismissSelf(.PurpleTheme)},
            5: {self.changeThemeAndDismissSelf(.PinkTheme)},
            6: {self.changeThemeAndDismissSelf(.BlackTheme)}]
        
        themePickerBar.showInViewController(self, animated: true)
    }
    
    func changeThemeAndDismissSelf(theme: CMThemes) {
        theme.setTheme()

        // save theme
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(theme.hashValue, forKey: kCurrentTheme)
        userDefaults.synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(kThemeDidChangeNotification, object: nil)
        
        let delayInSeconds: Double = 0.8
        let popTime = dispatch_time(DISPATCH_TIME_NOW,Int64(Double(NSEC_PER_SEC) * delayInSeconds))
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.delegate?.toggleLeftPanel()
        })
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(Double(NSEC_PER_SEC) * 1.2)), dispatch_get_main_queue()) { () -> Void in
            self.delegate?.removeFrontBlurView()
            NSNotificationCenter.defaultCenter().postNotificationName(kShouldShowCornerActionButton, object: nil)

        }
    }
    
    // MARK: - table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clearColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.imageView?.image = UIImage(named: cellTitleImage[indexPath.row])
        cell.textLabel?.text = cellTitleArray[indexPath.row]
        cell.textLabel?.textColor = UIColor(hex: "#333333")
        return cell
        
    }
    
//    disable header by wyp
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRectMake(0, 0, kExpandedOffSet, 27))
//        let recognizer = UITapGestureRecognizer(target: self, action: "showThemePickerView")
//        recognizer.numberOfTapsRequired = 1
//
//        let titleLabel = UILabel()
//        titleLabel.text = BUTTON_CHANGE_THEME
//        titleLabel.font = UIFont.systemFontOfSize(15)
//        titleLabel.sizeToFit()
//        titleLabel.textAlignment = NSTextAlignment.Center
//        titleLabel.textColor = CUSTOM_THEME_COLOR.darkerColor(0.7)
//        titleLabel.center = headerView.center
//        
//        headerView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
//        headerView.addGestureRecognizer(recognizer)
//        headerView.addSubview(titleLabel)
//        
//        return headerView
//        return nil
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    // MARK: - table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var destinationVC: UIViewController!
        switch indexPath.row {
        //0 1 2 我的发起，我的参与 我的收藏
        case 0:
            let destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.startedNav) as! ProjectListNavViewController
            destinationVC.setType(ProjectCategory.Started,title: "")
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 1:
            let destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.startedNav) as! ProjectListNavViewController
            destinationVC.setType(ProjectCategory.Involved,title: "")
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 2:
            let destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.startedNav) as! ProjectListNavViewController
            destinationVC.setType(ProjectCategory.Stared,title: "")
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 3:
            destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.walletNav)
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 4:
            destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.messageNav)
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 5:
            destinationVC = slidePanelStoryboard.instantiateViewControllerWithIdentifier(SlidePanelStoryboard.VCIdentifiers.settingNav)
            self.navigationController?.showViewController(destinationVC, sender: nil)
            return
        case 6:
            toLogout()
            return
        default:
            let canNotUseAlert = CMAlertController(title: "", message: "暂未开放！", preferredStyle:.Alert)
            canNotUseAlert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: nil))
            self.presentViewController(canNotUseAlert, animated: true, completion: nil)
            return
        }
        
        destinationVC?.title = cellTitleArray[indexPath.row]
        self.navigationController?.showViewController(destinationVC, sender: nil)
        
        //self.navigationController?.pushViewController(destinationVC, animated: false)
        
//        self.delegate?.toggleLeftPanel()
//        
//        // after pushing view controller, remove the blur view
//        let delayInSeconds: Double = 1
//        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * delayInSeconds))
//        dispatch_after(popTime, dispatch_get_main_queue(), {
//            self.delegate?.removeFrontBlurView()
//        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("testprepareFor")
    }
    @IBAction func cancelToSlidePanel(segue: UIStoryboardSegue){
        print(segue.identifier)
    }
    
}

