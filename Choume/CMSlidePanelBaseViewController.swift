import UIKit

class CMSlidePanelBaseViewController: UIViewController {
    
    
    
    override func loadView() {
        super.loadView()
        self.manuallyConfigureTopBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.manuallyConfigureTopBar()
        self.configureScreenEdgePanGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func manuallyConfigureTopBar() {
//        // add status bar view
//        let statusBarView = UIToolbar(frame:  UIApplication.sharedApplication().statusBarFrame)
//        statusBarView.barStyle = .Default
//        statusBarView.translucent = true
//        self.view?.addSubview(statusBarView)
        
        // add navigation bar
//        let navBar = UINavigationBar(frame: CGRectMake(0.0, 20.0, UIScreen.screenWidth(), 44.0))
        let navBar = UINavigationBar(frame: CGRectMake(0.0, 0.0, UIScreen.screenWidth(), 64.0))

        navBar.barStyle = .Default
        navBar.translucent = true
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : CUSTOM_THEME_COLOR]
        navBar.setItems([UINavigationItem(title: self.title ?? "")], animated: false)
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .Plain, target: self, action: "popViewController")
        self.view.addSubview(navBar)
    }
    
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
      
    }
    
    func configureScreenEdgePanGesture() {
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "popViewController")
        recognizer.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(recognizer)
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
