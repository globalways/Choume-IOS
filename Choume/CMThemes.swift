//  Created by Augus on 10/7/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


let kCurrentTheme = "kCurrentTheme"
var CUSTOM_THEME_COLOR = UIColor.whiteColor()
var BACKGROUNDER_IMAGE = UIImage(named: "bg_image_yellow")

public enum CMThemes: Int {
    case DefaultTheme
    case RedTheme
    case GreenTheme
    case YellowTheme
    case PurpleTheme
    case PinkTheme
    case BlackTheme
    case WhiteTheme
    
    public func setTheme() {
        switch self {
        case .DefaultTheme:
            CUSTOM_THEME_COLOR = themeColorArray[0]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_blue")
            
        case .RedTheme:
            CUSTOM_THEME_COLOR = themeColorArray[1]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_red")
            
        case .GreenTheme:
            CUSTOM_THEME_COLOR = themeColorArray[2]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_green")
            
        case .YellowTheme:
            CUSTOM_THEME_COLOR = themeColorArray[3]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_yellow")
            
        case .PurpleTheme:
            CUSTOM_THEME_COLOR = themeColorArray[4]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_purple")
            
        case .PinkTheme:
            CUSTOM_THEME_COLOR = themeColorArray[5]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_pink")
            
        case .BlackTheme:
            CUSTOM_THEME_COLOR = themeColorArray[6]
            BACKGROUNDER_IMAGE = UIImage(named: "bg_image_black")
        case .WhiteTheme:
            CUSTOM_THEME_COLOR = themeColorArray[7]
            
        }
    }
    
    
}

public let themeColorArray = [
    UIColor(red:0, green:0.57, blue:1, alpha:1),
    UIColor.redColor(),
    UIColor(red:0.27, green:0.75, blue:0.76, alpha:1),
    UIColor(red:1, green:0.827, blue:0, alpha:1),
    UIColor.purpleColor(),
    UIColor(red:0.98, green:0.31, blue:0.73, alpha:1),
    UIColor(red:0.38, green:0.39, blue:0.4, alpha:1),
    UIColor.whiteColor()
]

//by wyp
let rgbColor = UIColor(red:35,green:164,blue:252,alpha:1)
//copy from small day
struct theme {
    static let CMWebViewProgressBar  = UIColor(hex: "#30b48e")
    static let CMNavBGColor: UIColor = UIColor(hex: "#11a2ff")
    static let CMGray333333: UIColor = UIColor(hex: "#333333")
    static let CMGray666666: UIColor = UIColor(hex: "#666666")
    /// 白底灰色文字
    static let CMGrayLight: UIColor = UIColor(hex: "#efeff4")
    /// 加载失败 gary
    static let CMGraycacaca: UIColor = UIColor(hex: "#cacaca")
    static let CMWhite: UIColor = UIColor.whiteColor()
    static let CMVCBackgroundColor = UIColor.whiteColor()
    ///  APP导航条barButtonItem文字大小
    static let CMNavItemFont: UIFont = UIFont.systemFontOfSize(16)
    ///  APP导航条titleFont文字大小
    static let CMNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
    /// cache文件路径
    static let cachesPath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
    /// UIApplication.sharedApplication()
    static let appShare = UIApplication.sharedApplication()
}

