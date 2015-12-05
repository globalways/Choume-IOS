import UIKit

var statusBarView: UIToolbar!

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.changeStatusBarColorOnSwipe()
        self.tabBar.items?[0].title = TITLE_HOME
        self.tabBar.items?[1].title = TITLE_NODE
        self.tabBar.items?[2].title = TITLE_MESSAGE
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.tintColor = CUSTOM_THEME_COLOR
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusBarView?.frame = UIApplication.sharedApplication().statusBarFrame
    }
    
    func changeStatusBarColorOnSwipe(){
        if SHOULD_HIDE_NAVIGATIONBAR {
            statusBarView = UIToolbar(frame:  UIApplication.sharedApplication().statusBarFrame)
            statusBarView.barStyle = UIBarStyle.Default
            self.view.addSubview(statusBarView)

        }
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
