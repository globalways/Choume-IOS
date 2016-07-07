//
//  Tool.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/23.
//  Copyright © 2015年 outsouring. All rights reserved.
//

import Foundation
import Alamofire

public let SD_UserIconData_Path = theme.cachesPath + "/" + AvatarTmpFileName
public let CMCachesPath = theme.cachesPath + "/Choume/"
public let AvatarTmpFileName = "iconImage.data"

class Tool {
    
    /// 分转元
    static func fenToyuan(fen:Int) -> String {
        let dFen = Double(fen)
        let d100 = 100.00
        return String(format: "%.2f",dFen/d100)
    }
    
    /// 时间戳转时间
    static func formatTime(time: Int) -> String {
        let dformater = NSDateFormatter()
        dformater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time))
        return dformater.stringFromDate(date)
    }
    
    static func afterInterval(interval: Double, completion:() -> Void) {
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(interval * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    /// 网络加载太快的情况下，加载动画一闪而过。为了更佳的用户体验，少于0.5秒的时间，延长到0.5秒
    static func uiHalfSec(timer: NSDate, completion:() -> Void ){
        let interval = -timer.timeIntervalSinceNow
        if interval < 0.5 {
            Tool.afterInterval(0.5 - interval, completion: {
                completion()
            })
        }else { completion() }
    }
    
    static func afterSec(sec:Double, completion:() -> Void ){
        let timer = NSDate()
        let interval = -timer.timeIntervalSinceNow
        if interval < sec {
            Tool.afterInterval(sec - interval, completion: {
                completion()
            })
        }else { completion() }
    }
    
    /// 判断项目是否被当前用户收藏
    static func isCollected(project: CfProject) -> Bool {
        for tmpProject in CMContext.currentUser!.collectedProjects {
            if tmpProject.id == project.id {
                return true
            }
        }
        return false
    }
    
    
    /// 计算项目进度 1 - 100
    static func projectProgress(p:CfProject) -> Int {
        if p.majarType == CfProjectSupportType.PEOPLE_CFPST {
            guard p.requiredPeopleAmount > 0 else{return 0}
            let dPercent = Double(p.alreadyPeopleAmount) / Double(p.requiredPeopleAmount)
            return Int(dPercent * 100)
        }
        if p.majarType == CfProjectSupportType.MONEY_CFPST {
            guard p.requiredMoneyAmount > 0 else {return 0}
            let dPercent = Double(p.alreadyMoneyAmount) / Double(p.requiredMoneyAmount)
            return Int(dPercent * 100)
        }
        if p.majarType == CfProjectSupportType.GOODS_CFPST {
            guard p.requiredGoodsAmount > 0 else {return 0}
            let dPercent = Double(p.alreadyGoodsAmount) / Double(p.requiredGoodsAmount)
            return Int(dPercent * 100)
        }
        if p.majarType == CfProjectSupportType.EQUITY_CFPST {
            guard p.alreadyProjectEquity != nil && p.requiredProjectEquity != nil && p.requiredProjectEquity > 0 else {return 0}
            let dPercent = Double(p.alreadyProjectEquity!) / Double(p.requiredProjectEquity!)
            return Int(dPercent * 100)
        }
       return 0
    }
    
    /// 计算项目进度 0 - 1.0
    static func projectProgressDouble(p:CfProject) -> Double {
        if p.majarType == CfProjectSupportType.PEOPLE_CFPST {
            guard p.requiredPeopleAmount > 0 else{return 0}
            let dPercent = Double(p.alreadyPeopleAmount) / Double(p.requiredPeopleAmount)
            return dPercent
        }
        if p.majarType == CfProjectSupportType.MONEY_CFPST {
            guard p.requiredMoneyAmount > 0 else {return 0}
            let dPercent = Double(p.alreadyMoneyAmount) / Double(p.requiredMoneyAmount)
            return dPercent
        }
        if p.majarType == CfProjectSupportType.GOODS_CFPST {
            guard p.requiredGoodsAmount > 0 else {return 0}
            let dPercent = Double(p.alreadyGoodsAmount) / Double(p.requiredGoodsAmount)
            return dPercent
        }
        if p.majarType == CfProjectSupportType.EQUITY_CFPST {
            guard p.alreadyProjectEquity != nil && p.requiredProjectEquity != nil && p.requiredProjectEquity > 0 else {return 0}
            let dPercent = Double(p.alreadyProjectEquity!) / Double(p.requiredProjectEquity!)
            return dPercent
        }
        return 0
    }
    
    /// 生成投资描述
    static func generateAbbr(i: CfProjectInvest) -> String {
        var abbr = "支持了"
        switch i.rewardSupportType {
        case CfProjectSupportType.MONEY_CFPST:
            abbr += String(i.rewardCount * i.rewardAmount) + "筹币"
            break
        case CfProjectSupportType.PEOPLE_CFPST:
            var abbr = "报名:"
            abbr += String(i.rewardCount * i.rewardAmount) + "人"
            return abbr
        case CfProjectSupportType.GOODS_CFPST:
            abbr += String(i.rewardCount * i.rewardAmount) + "件物品"
            break
        case CfProjectSupportType.EQUITY_CFPST:
            abbr += String(i.rewardCount * i.rewardAmount) + "‰股份"
            break
        default:
            abbr = "未知"
            break
        }
        return abbr
    }
    
    /// 加载用户头像
    static func loadUserAvatarToView(hongid:Int, view:UIImageView){
        APIClient.sharedInstance.getAppUser(hongid, success: { (result) in
            if result.respStatus() == .OK {
                let cfUser = result[APIClient.cfUser].toCfUser()
                view.sd_setImageWithURL(NSURL(string: (cfUser?.user?.avatar)!), placeholderImage: UIImage(named: "Administrator"))
            }else {
                view.image = UIImage(named: "Administrator")
            }
            }) { (error) in
                view.image = UIImage(named: "Administrator")
        }
    }
    
}