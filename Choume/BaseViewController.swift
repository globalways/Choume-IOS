import UIKit
import SwiftyJSON
//import GearRefreshControl
import MJRefresh
import DZNEmptyDataSet

protocol CMDataLoader {
    func dataInitLoad()
    func dataReload()
    func dataLoadMore()
}

/// 获取数据的页数记录器
class CMPager{
    var INIT_PAGE:Int{
        get{
            return 1
        }
    }
    
    private var page = 1
    
    var size:Int{
        get{
            return 10
        }
    }
    
    init() {
        page = INIT_PAGE
    }
    
    func reset(){
        page = INIT_PAGE
    }
    
    func getNext() -> Int {
        return page + 1
    }
    
    func pageP1(){
        page += 1
    }
    
    func getCurrentPage() -> Int{
        return page
    }
}


class BaseViewController: UITableViewController {
    
    public var enablePullAndPush = true
    private var emptyView = CMVCEmptyView()
    
    var cornerActionButton: UIButton!
//    var gearRefreshControl: GearRefreshControl!
    var page: Int = 1
    var postNewArticleSegue: String!
    

    var datasource: [JSON]! {
        didSet{
            //            print(datasource)
            self.tableView.reloadData()
        }
    }
    
    // init loading view
    private var spinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //automaticPullingDownToRefresh()
        //self.gearRefreshManager()
        //隐藏CornerActionButton
        //self.configureCornerActionButton()
        self.navigationController?.navigationBar.hidden = SHOULD_HIDE_NAVIGATIONBAR
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : CUSTOM_THEME_COLOR]

        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTheme", name: kThemeDidChangeNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideCornerActionButton", name: kShouldHideCornerActionButton, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "showCornerActionButton", name: kShouldShowCornerActionButton, object: nil)
        
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource   = self
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(BaseViewController.dataReload))
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(BaseViewController.dataLoadMore))
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "showCornerActionButton", name: kShouldShowCornerActionButton, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        cornerActionButton?.hidden = true
        
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: kShouldShowCornerActionButton, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cornerActionButton?.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.85)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Loading & UIActivityIndicatorView by wyp
    
    // Set the activity indicator into the main view
    func setLoadingScreen() {
        
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
    func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingLabel.hidden = true
        
    }
    
    func removeLoadingScreen(timer: NSDate) {
        Tool.uiHalfSec(timer) { 
            self.removeLoadingScreen()
        }
    }
    
    func loadingScreenText(info: String) {
        self.spinner.stopAnimating()
        self.loadingLabel.text = info
    }
    
    
    
    
    /// MARK: CornerActionButton
    
    
    func configureCornerActionButton(){
        cornerActionButton = UIButton(frame: CGRectMake(UIScreen.screenWidth() - 66, UIScreen.screenHeight() - 110, 40, 40))
        cornerActionButton?.layer.cornerRadius = 20.0
        cornerActionButton?.clipsToBounds = true
        cornerActionButton?.setImage(UIImage(named: "plus_button"), forState: .Normal)
        cornerActionButton?.addTarget(self, action: "cornerActionButtonDidTap", forControlEvents: .TouchUpInside)
        UIApplication.topMostViewController()?.view.addSubview(cornerActionButton)
    }
    
    func cornerActionButtonDidTap() {
        print("corner action button did tap")
        let alertCtrl = UIAlertController(title: "", message: "TODO...", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel , handler: nil)
        alertCtrl.addAction(cancelAction)
        UIApplication.topMostViewController()?.presentViewController(alertCtrl, animated: true, completion: nil)
    }
    
    
//    func updateTheme() {
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : CUSTOM_THEME_COLOR]
//        self.cornerActionButton?.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.85)
//        
//        /**
//           I tried to set `gearTintColor` to `gearRefreshControl`, but the color of all of gears didn't change.
//           Because other gears' color is computed automatically according to main gear.
//            
//        I removed `gearRefreshControl`, then set it again.
//        */
////        self.gearRefreshControl.gearTintColor = CUSTOM_THEME_COLOR.lighterColor(0.7)
//        
//        gearRefreshControl?.endRefreshing()
//        gearRefreshControl?.removeFromSuperview()
//        gearRefreshManager()
//    }
    
    
    
    // MARK: - part of GearRefreshControl
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        gearRefreshControl?.scrollViewDidScroll(scrollView)
//    }
//    
//    private func gearRefreshManager(){
//        gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
//        gearRefreshControl.gearTintColor = CUSTOM_THEME_COLOR.lighterColor(0.7)
//        gearRefreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
//        refreshControl = gearRefreshControl
//    }
//    
//    
//    // MARK: - Automatic pulling down to refresh
//    func automaticPullingDownToRefresh(){
//        
//        NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "automaticContentOffset", userInfo: nil, repeats: false)
//        //        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "endRefresh", userInfo: nil, repeats: false)
//        //        NSTimer.performSelector("endRefresh", withObject: nil, afterDelay: 0.1)
//    }
//    
//    func automaticContentOffset(){
//        self.gearRefreshControl.beginRefreshing()
//        self.tableView.setContentOffset(CGPointMake(0, -125.0), animated: true)
//        
//        let delayInSeconds: Double = 0.5
//        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * delayInSeconds))
//        dispatch_after(popTime, dispatch_get_main_queue(), {
//            self.gearRefreshControl.endRefreshing()
//            
//        })
//    }
    
    func hideCornerActionButton() {
        print("hide corner button")
        self.cornerActionButton?.hidden = true
    }
    
    func showCornerActionButton() {
        print("show corner button")
        self.cornerActionButton?.hidden = false
    }
}

extension BaseViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == MainStoryboard.SegueIdentifiers.postNewArticleWithNodeSegue {
            if let destinationVC = segue.destinationViewController as? UINavigationController {
                
                self.presentLoginViewControllerIfNotLogin(alertMessage: LOGIN_TO_POST, completion: {
                    
                    self.presentViewController(destinationVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    func performPostNewArticleSegue(segueIdentifier segueID: String){
        print("editing...")
        CMContext.sharedInstance.isTokenLegal(){ (isTokenLegal) -> Void in
            if isTokenLegal{
                self.performSegueWithIdentifier(segueID, sender: self)
            }else {
                self.presentLoginViewControllerIfNotLogin(alertMessage: LOGIN_TO_POST, completion:{self.performPostNewArticleSegue(segueIdentifier: segueID) })
                
            }
            
        }
    }
    
    func presentLoginViewControllerIfNotLogin(alertMessage message: String, completion: (() -> Void)?){
        CMContext.sharedInstance.isTokenLegal(){ (isTokenLegal) -> Void in
            if !isTokenLegal {
                let loginAlertController = UIAlertController(title: "", message: message, preferredStyle: .Alert)
                let okAction = UIAlertAction(title: BUTTON_OK, style: .Default, handler: { (_) -> Void in
                    let vc = CMEffectViewController()
                    vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    CMContext.sharedInstance.login(cancelled: {
                        vc.dismissViewControllerAnimated(true , completion: nil)
                        }, completion: {
                            vc.dismissViewControllerAnimated(true, completion: nil)
                            
                            if let completionHandler = completion {
                                completionHandler()
                            }
                    })
                })
                let cancelAction = UIAlertAction(title: BUTTON_CANCEL, style: .Cancel , handler: nil)
                loginAlertController.addAction(cancelAction)
                loginAlertController.addAction(okAction)
                self.presentViewController(loginAlertController, animated: true, completion: nil)
                
            }
        }
    }
}

extension BaseViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
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
        dataInitLoad()
    }
    
    // 加载错误
    func emptyViewForError() {
        self.emptyView.show(message: "加载错误", titleOfButton: "重试")
        self.tableView.reloadEmptyDataSet()
        removeLoadingScreen()
    }
    
    func emptyViewForError(timer: NSDate) {
        Tool.uiHalfSec(timer) {
            self.emptyViewForError()
        }
    }
    
    // 自定义错误信息
    func emptyViewForError(msg: String, btn: String) {
        self.emptyView.show(message: msg, titleOfButton: btn)
        self.tableView.reloadEmptyDataSet()
        removeLoadingScreen()
    }
    
    func emptyViewForError(msg: String, btn: String, timer: NSDate) {
        Tool.uiHalfSec(timer) {
            self.emptyViewForError(msg, btn: btn)
        }
    }
    
    // 暂无数据
    func emptyViewForNoData() {
        self.emptyView.show(message: "暂无数据", titleOfButton: "重试")
        self.tableView.reloadEmptyDataSet()
        removeLoadingScreen()
    }
    
    func emptyViewForNoData(timer: NSDate) {
        Tool.uiHalfSec(timer) { 
            self.emptyViewForNoData()
        }
    }
}

extension BaseViewController: CMDataLoader {
    
    func dataInitLoad() {
        setLoadingScreen()
    }
    
    func dataReload() {
    }
    
    func dataLoadMore() {
        
    }
}

