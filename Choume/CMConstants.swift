//  Created by Augus on 9/16/15.
//
//  http://iAugus.com
//  https://github.com/iAugux
//
//  Copyright © 2015 iAugus. All rights reserved.
//


public let AppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let AppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height

let kThemeDidChangeNotification                    = "kThemeDidChangeNotification"
let kShouldHideCornerActionButton                  = "kShouldHideCornerActionButton"
let kShouldShowCornerActionButton                  = "kShouldShowCornerActionButton"
let kShouldReloadDataAfterPosting                  = "kShouldReloadDataAfterPosting"
let kJustLoggedinNotification                      = "kJustLoggedinNotification"

// add by wyp
let kNewInvestDidSelectedAddr                      = "kNewInvestDidSelectedAddr"
let kRechargePayFinish                             = "kRechargePayFinish"

let APPID                                          = "com.globalways.choume"
let RONG_APP_ID                                    = "p5tvi9dst10s4"
// end


var SHOULD_HIDE_NAVIGATIONBAR                      = false

let BLUR_VIEW_ALPHA_OF_BG_IMAGE: CGFloat           = 0.70

let isIphone3_5Inch: Bool                          = UIScreen.mainScreen().bounds.size.height == 480 ? true : false

//http://stackoverflow.com/questions/25780283/ios-how-to-detect-iphone-6-plus-iphone-6-iphone-5-by-macro
struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}

let HEADER_TITLE_FONT_SIZE: CGFloat                = 17
let HEADER_CONTENT_FONT_SIZE: CGFloat              = 15.0

let TITLE_FOR_HEADER_IN_SECTION_FONT_SIZE: CGFloat = 15.0

let TIME_OF_TOAST_OF_REGISTER_SUCCESS: Double      = 3.0
let TIME_OF_TOAST_OF_REPLY_SUCCESS: Double         = 1.0
let TIME_OF_TOAST_OF_POST_SUCCESS: Double          = 3.5
let TIME_OF_TOAST_OF_POST_FAILED: Double           = 3.0
let TIME_OF_TOAST_OF_COMMENT_SUCCESS: Double       = 3.5
let TIME_OF_TOAST_OF_COMMENT_FAILED: Double        = 3
let TIME_OF_TOAST_OF_TOKEN_ILLEGAL: Double         = 1.0
let TIME_OF_TOAST_OF_SERVER_ERROR: Double          = 3.0
let TIME_OF_TOAST_OF_NO_MORE_DATA: Double          = 0.8

let SWIPE_LEFT_TO_CANCEL_RIGHT_TO_CONTINUE         = true



let AVATAR_PLACEHOLDER_IMAGE = UIImage(named: "Administrator")
let AVATAR_PLACEHOLDER_ADMIN_IMAGE = UIImage(named: "Administrator")


@objc class  ConstantsForObjc: NSObject {
    class func customThemeColorForObjc() -> UIColor {
        return CUSTOM_THEME_COLOR
    }
    
}