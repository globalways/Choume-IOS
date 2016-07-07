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
    
    func cmAlert(title: String, msg: String, ok:(UIAlertAction) -> Void, cancel:(UIAlertAction) -> Void) {
        let alertVc = CMAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: BUTTON_OK, style: .Default, handler: ok)
        let cancelAction = UIAlertAction(title: BUTTON_CANCEL, style: .Cancel, handler: cancel)
        alertVc.addAction(okAction)
        alertVc.addAction(cancelAction)
        
        self.presentViewController(alertVc, animated: true, completion: nil)
    }
}