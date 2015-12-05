//
//  MyUserInfoTableViewController.swift
//
//  Created by 汪阳坪 on 15/11/18.
//  Copyright © 2015年 iAugus. All rights reserved.
//

import UIKit

class MyUserInfoTableViewController: UITableViewController {

    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "toUserAddressManage"){
            print("toUserAddressManage")
        }
    }
    
    @IBAction func cancelManageAddress(segue: UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}
