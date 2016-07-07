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
    
    func setType(type:ProjectCategory, title: String){
        let vc = self.childViewControllers[0] as! StartedVC
        vc.setType(type)
        vc.navigationItemTitle = title
    }
    
    //首页项目列表参数
    
    // tag:
    
    /*
     // 众筹标签，聚合分类
     enum CfProjectTag {
     INVALID_CFPT = 0;
     // 一元秒筹，限时特筹
     LIMIT_TIME_CFPT = 1;
     // 世纪难题，周末去哪
     QUESTION_CFPT = 2;
     // 热门众筹，非筹不可
     HOT_CFPT = 3;
     }
     */
    
    // category:
     /* INVALID_CFC = 0;
     // 筹乐子
     HAPPY_CFC = 1;
     // 筹票子
     MONEY_CFC = 2;
     // 筹爱心
     LOVE_CFC = 3;
     // 校园合伙人-项目
     PROJECT_CFC = 4;
     // 校园合伙人-产品
     PRODUCT_CFC = 5;
     */
    
    func setCategoryAndTag(category:CrowdFundingCategory, tag:CfProjectTag){
        let vc = self.childViewControllers[0] as! StartedVC
        vc.category = category
        vc.tag = tag
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
