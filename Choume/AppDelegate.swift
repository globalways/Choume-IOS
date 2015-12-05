//
//  AppDelegate.swift
//  iBBS
//
//  Created by Augus on 9/1/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//



import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var containerViewController:  ContainerViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
        // SlideMenu
        application.statusBarStyle = .LightContent
        containerViewController = ContainerViewController()
        let homeNav = mainStoryboard.instantiateViewControllerWithIdentifier("homeNav") as! UINavigationController
        homeNav.viewControllers[0] = containerViewController
        homeNav.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = homeNav
        
        
        // Settings
        
        if isIphone3_5Inch {
            SHOULD_HIDE_NAVIGATIONBAR = true
        }
        
//        SHOULD_HIDE_NAVIGATIONBAR = true
        
        
    
        // by wyp
//        UINavigationBar.appearance().barTintColor = theme.CMNavBGColor
//        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        let attr: NSMutableDictionary! = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        UINavigationBar.appearance().titleTextAttributes = attr as? [String: AnyObject]
        
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
        
        return true
    }
    
    func setWindowColor(){
        self.window?.tintColor = CUSTOM_THEME_COLOR
        self.window?.backgroundColor = CUSTOM_THEME_COLOR.lighterColor(0.6)

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
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

