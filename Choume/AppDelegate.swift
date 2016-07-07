import UIKit
import ObjectMapper
import SVProgressHUD


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var containerViewController:  ContainerViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // SlideMenu
        application.statusBarStyle = .LightContent
        containerViewController = ContainerViewController()
        let homeNav = mainStoryboard.instantiateViewControllerWithIdentifier("homeNav") as! UINavigationController
        homeNav.viewControllers[0] = containerViewController
        homeNav.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = homeNav
        
        
        // Settings
        
        if isIphone3_5Inch {
            SHOULD_HIDE_NAVIGATIONBAR = false
        }
        
        //SHOULD_HIDE_NAVIGATIONBAR = true
        
        // Set Theme
        //清除设置的主题 by wyp
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(kCurrentTheme)
        if let theme = userDefaults.objectForKey(kCurrentTheme) {
            CMThemes(rawValue: Int(theme as! NSNumber))?.setTheme()
            self.setWindowColor()
            
        }else {
            let theme = CMThemes.WhiteTheme
            theme.setTheme()
            self.setWindowColor()
            
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setWindowColor", name: kThemeDidChangeNotification, object: nil)
        
        RCIMClient.sharedRCIMClient().initWithAppKey(RONG_APP_ID)
        tryToLoadUserInfo()
        
        Pingpp.setDebugMode(true)
        return true
    }
    
    func setWindowColor(){
        self.window?.tintColor = CUSTOM_THEME_COLOR
        self.window?.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.6)
    }
    
    ///  尝试从本地读取用户信息，加载到内存
    func tryToLoadUserInfo(){
    
        let pwd = CMContext.sharedInstance.getPwd()
        let tel = CMContext.sharedInstance.getTel()
        
        let token = CMContext.sharedInstance.getToken()
        
        //使用token登录
        APIClient.sharedInstance.userLogin(token, userID: nil, passwd: nil, success: { (json) -> Void in

            if json.respStatus() == APIStatus.OK {
                CMContext.currentUser = json.cfUserJSON().toCfUser()
                CMContext.sharedInstance.saveToken(json.getToken())
                //登录成功后连接容云服务器
                self.connectToRc(json.getToken())
                
            }else {
                //提示错误
                print("tryToLoadUserInfo Login faild json: \(json)")
            }
            
            },
            failure: {(error) -> Void in
                print(error)
        })
    }
    
    
    func connectToRc(token: String) {
        APIClient.sharedInstance.getRCCFUserToken(token, success: { (result) in
            if result.respStatus() == .OK {
                let rcToken = result["rcToken"].stringValue
                RCIMClient.sharedRCIMClient().connectWithToken(rcToken, success: { (userID) in
                        print("rc connect success: ", userID)
                    }, error: { (RcError) in
                        print(RcError)
                    }, tokenIncorrect: {
                        print("token error")
                })
            }
            
            }, failure: { (error) in
                
        })
    }
    
    // disable orientation for messages view controller
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
//        if let topMostVC = UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController(){
//            if topMostVC.isKindOfClass(CMMessagesViewController.classForCoder()) {
//                return UIInterfaceOrientationMask.Portrait
//            }
//        }
        return UIInterfaceOrientationMask.All
    }
    
    func applicationWillResignActive(application: UIApplication) {}
    
    func applicationDidEnterBackground(application: UIApplication) {}
    
    func applicationWillEnterForeground(application: UIApplication) {}
    
    func applicationDidBecomeActive(application: UIApplication) {}
    
    func applicationWillTerminate(application: UIApplication) {}
    
    // ping++ iOS 9 以上请用这个
    // 渠道为微信、支付宝(安装了支付宝钱包)、银联或者测试模式时
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let r = Pingpp.handleOpenURL(url, withCompletion: { (result, error) in
            var data: [String:AnyObject]?
            if error == nil {
                data = ["result":result]
            }else {
                data = ["result":result, "error":error]
                print("pay error", error.getMsg())
            }
            NSNotificationCenter.defaultCenter().postNotificationName(kRechargePayFinish, object: nil, userInfo: data)
        })
        return r
    }
    
}

