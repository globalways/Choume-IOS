//
//  DZNEmptyDataSet+Additions.swift
//  Choume
//
//  Created by wang on 16/5/20.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import Foundation

/// DZNEmptyDataSet 属性
class CMVCEmptyView {
    var status:CMVCEmptyViewStatus = .HIDDEN
    var msg = ""
    var buttonTitle = ""
    var image: UIImage{
        get {
             return UIImage(named: "Icon-Smile")!
        }
    }
    
    /// 隐藏view 并且清除
    func hideAndClean() {
        setView(false, msg: "", buttonTitle: "")
    }
    
    func show(message msg: String!, titleOfButton buttonTitle: String!) {
        setView(true, msg: msg, buttonTitle: buttonTitle)
    }
    
    private func setView(isShown: Bool, msg: String!, buttonTitle: String!){
        if isShown {
            self.status = .SHOWN
        }else { self.status = .HIDDEN }
        
        self.msg = msg
        self.buttonTitle = buttonTitle
    }
}

enum CMVCEmptyViewStatus: Int {
    case SHOWN = 1
    case HIDDEN = 2
}
