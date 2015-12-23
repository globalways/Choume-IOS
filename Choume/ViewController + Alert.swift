//
//  ViewController + Alert.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/21.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import Foundation

extension UIViewController {
    func cmAlert(title: String, msg:String ){
        let alertCtl = CMAlertController(title: title, message: msg, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: CMOK, style: .Cancel, handler: nil)
        alertCtl.addAction(cancelAction)
        self.presentViewController(alertCtl, animated: true, completion: nil)
    }
}