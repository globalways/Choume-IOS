//
//  UserProjectNavViewController.swift
//  iBBS
//
//  Created by 汪阳坪 on 15/11/25.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class UserProjectNavViewController: UINavigationController {
    
    var type: ProjectCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setType(type : ProjectCategory){
        var vc = self.childViewControllers[0] as! StartedVC
        vc.setType(type)
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
}
