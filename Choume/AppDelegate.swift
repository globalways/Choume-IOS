import UIKit

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
        tryToLoadUserInfo()
        return true
    }
    
    func setWindowColor(){
        self.window?.tintColor = CUSTOM_THEME_COLOR
        self.window?.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.6)
    }
    
    func tryToLoadUserInfo(){
        if let json = CMContext.sharedInstance.getLoginData() {
            print("load local user data:\(json)")
            CMContext.currentUser = json.toCfUser()
        }
    }
    
    // disable orientation for messages view controller
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if let topMostVC = UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController(){
            if topMostVC.isKindOfClass(CMMessagesViewController.classForCoder()) {
                return UIInterfaceOrientationMask.Portrait
            }
        }
        return UIInterfaceOrientationMask.All
    }
    
    func applicationWillResignActive(application: UIApplication) {}
    
    func applicationDidEnterBackground(application: UIApplication) {}
    
    func applicationWillEnterForeground(application: UIApplication) {}
    
    func applicationDidBecomeActive(application: UIApplication) {}
    
    func applicationWillTerminate(application: UIApplication) {}
    
    
}

