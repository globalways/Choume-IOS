//
//  CMFourTargeView.swift
//  Choume
//
//  Created by wang on 16/6/1.
//  Copyright © 2016年 outsouring. All rights reserved.
//

import UIKit

class CMFourTargetView: UIView {
    
    private let labelDisableColor = theme.CMGraycacaca
    private let labelDisableText  = "不可用"
    
    @IBOutlet weak var item1Image: UIImageView!
    @IBOutlet weak var item1Label1: UILabel!
    @IBOutlet weak var item1Label2: UILabel!
    
    @IBOutlet weak var item2Image: UIImageView!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item2Label2: UILabel!
    
    @IBOutlet weak var item3Image: UIImageView!
    @IBOutlet weak var item3Label1: UILabel!
    @IBOutlet weak var item3Label2: UILabel!
    
    @IBOutlet weak var item4Image: UIImageView!
    @IBOutlet weak var item4Label1: UILabel!
    @IBOutlet weak var item4Label2: UILabel!
    
    
    func setProject(p: CfProject) {
        if p.requiredPeopleAmount < 1 {
            disableIndex(1)
        }else {
            item1Label2.text = String(p.alreadyPeopleAmount)
        }
        
        if p.requiredMoneyAmount < 1 {
            disableIndex(2)
        }else {
            item2Label2.text = Tool.fenToyuan(p.alreadyMoneyAmount)
        }
        
        if p.requiredGoodsAmount < 1 {
            disableIndex(3)
        }else {
            item3Label2.text = String(p.alreadyGoodsAmount)
        }
        let deadLine = NSDate(timeIntervalSince1970: NSTimeInterval(p.deadline))
        let components = NSCalendar.currentCalendar().components([.Day, .Hour, .Minute, .Second], fromDate: NSDate(), toDate: deadLine, options: [])
        item4Label2.text = String (components.day)
    }
    
    // 1 人员 2资金 3物品
    private func disableIndex(index: Int) {
        switch index {
        case 1:
            item1Image.image      = UIImage(named: "Icon-people-gray")
            item1Label1.textColor = labelDisableColor
            item1Label2.text      = labelDisableText
            item1Label2.textColor = labelDisableColor
            break
        case 2:
            item2Image.image      = UIImage(named: "Icon-jine-gray")
            item2Label.textColor = labelDisableColor
            item2Label2.text      = labelDisableText
            item2Label2.textColor = labelDisableColor
            break
        case 3:
            item3Image.image      = UIImage(named: "Icon-wupin-gray")
            item3Label1.textColor = labelDisableColor
            item3Label2.text      = labelDisableText
            item3Label2.textColor = labelDisableColor
            break
        default: break
        }
    }
}
