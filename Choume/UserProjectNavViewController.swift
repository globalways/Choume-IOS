import UIKit

class ProjectListNavViewController: UINavigationController {
    
    var type: ProjectCategory?
    var listTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setType(type : ProjectCategory, title: String){
        var vc = self.childViewControllers[0] as! StartedVC
        vc.setType(type)
        vc.navigationItemTitle = title
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

enum ProjectCategory {
    case Started
    case Involved
    case Stared
    case Default
}
