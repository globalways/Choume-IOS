import UIKit
import SwiftyJSON
import JSONJoy

class CMContext {
    static let sharedInstance = CMContext()
    
    private init(){}
    
    private let kNodesId = "kNodes"
    private let kLoginFeedbackJson = "kLoginFeedbackJson"
    private let kLoginFeedbackJsonToken = "kLoginFeedbackJsonToken"

    static var currentUser: CfUser?
    
    func isTokenLegal(completionHandler: ((isTokenLegal: Bool) -> Void)) {

        if let json = CMContext.sharedInstance.getLoginData() {
            let uid = json["uid"].stringValue
            let token = json["token"].stringValue
            APIClient.sharedInstance.isTokenLegal(uid, token: token, success: { (json) -> Void in
                print(json)
                
                if json["code"].intValue == 1 {
                    completionHandler(isTokenLegal: true)
                    
                }else{
                    let msg = json["msg"].stringValue
                   UIApplication.topMostViewController()?.view.makeToast(message: msg, duration: TIME_OF_TOAST_OF_TOKEN_ILLEGAL, position: HRToastPositionTop)
                    completionHandler(isTokenLegal: false)
                    
                }
                }, failure: { (error) -> Void in
                    print(error)
                    completionHandler(isTokenLegal: false)
            })
        }else{
            completionHandler(isTokenLegal: false)
        }
    }
    
    
    func login(cancelled cancelled: (() -> Void)?, completion: (() -> Void)?) {
        var username, password: UITextField!
      
        let alertVC = CMAlertController(title: BUTTON_LOGIN, message: INSERT_UID_AND_PASSWD, preferredStyle: .Alert)
        
        alertVC.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = HOLDER_USERNAME
            username = textField
        }
        alertVC.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = HOLDER_PASSWORD
            textField.secureTextEntry = true
            textField.enablesReturnKeyAutomatically = true
            password = textField
        }
        
        let okAction = UIAlertAction(title: BUTTON_OK, style: .Default) { (action: UIAlertAction) -> Void in
            let encryptedPasswd = password.text?.MD5()
            let token = CMContext.sharedInstance.getToken()
            APIClient.sharedInstance.userLogin(token,userID: username.text!, passwd: encryptedPasswd!, success: { (json) -> Void in
                print(json)
                // something wrong , alert!!
                let code = json[APIClient.RESP][APIClient.CODE].intValue
                if APIStatus(rawValue: code) != .OK {
                    let description = APIStatus(rawValue: code)?.description()
                    let alert = CMAlertController(title: ERROR_MESSAGE, message: description, preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: { (_) -> Void in
                        self.login(cancelled: nil, completion: nil)
                        alertVC.dismissViewControllerAnimated(true , completion: nil)
                    })
                    
                    alert.addAction(cancelAction)
                    UIApplication.topMostViewController()?.presentViewController(alert, animated: true, completion: nil)
                }else{
                    // 保存信息到本地
                    CMContext.sharedInstance.saveLoginData(json[APIClient.cfUser].object)
                    CMContext.sharedInstance.saveToken(json[APIClient.TOKEN].object)
                    // 保存用户对象
                    if let cfUser = json[APIClient.cfUser].toCfUser() {
                        CMContext.currentUser = cfUser
                    }
                    
                    if let completionHandler = completion {
                        completionHandler()
                    }
                }
                
                
                }) { (error ) -> Void in
                    print(error)
            }
        }
        let cancelAction = UIAlertAction(title: BUTTON_CANCEL, style: .Cancel) { (_) -> Void in
            alertVC.dismissViewControllerAnimated(true , completion: nil)
            if let cancelHandler = cancelled {
                cancelHandler()
            }
        }
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        UIApplication.topMostViewController()?.presentViewController(alertVC, animated: true, completion: nil)
        
       
    }

    func logout(completion completion: (() -> Void)?){
        
        self.saveLoginData("")
        self.saveToken("")
        CMContext.currentUser = nil
        
        let alertController = CMAlertController(title: "", message: SURE_TO_LOGOUT, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: BUTTON_CANCEL, style: .Default, handler: nil)
        let okAction = UIAlertAction(title: BUTTON_OK, style: .Default) { (_) -> Void in
            
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.removeObjectForKey(self.kLoginFeedbackJson)
            
            if let completionHandler = completion {
                completionHandler()
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        UIApplication.topMostViewController()?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func saveLoginData(data: AnyObject) {
        print("----\(data)-----")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(data), forKey: kLoginFeedbackJson)
        userDefaults.synchronize()
    }
    
    func saveToken(data: AnyObject) {
        print("save token:----\(data)-----")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(data), forKey: kLoginFeedbackJsonToken)
        userDefaults.synchronize()
    }
    
    func getLoginData() -> JSON? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let data = userDefaults.objectForKey(kLoginFeedbackJson) {
            let json = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
            return JSON(json!)
        }
        
        return nil
    }
    
    func getToken() -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let data = userDefaults.objectForKey(kLoginFeedbackJsonToken) {
            let token = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)
            return String(token!)
        }
        return nil
    }
    
    func saveNodes(nodes: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(kNodesId)
        userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(nodes), forKey: kNodesId)
        userDefaults.synchronize()
    }
    
    func getNodes() -> JSON? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data: AnyObject? = userDefaults.objectForKey(kNodesId)
        if let obj: AnyObject = data {
            let json: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(obj as! NSData)
            return JSON(json!)
        }
        return nil
    }
    
    func configureCurrentUserAvatar(imageView: UIImageView, label: UILabel){
        if let cfUser = CMContext.currentUser {
            let avatar = cfUser.user?.avatar
            //if avatar!.utf16.count == 0 {
            if avatar == nil {
                print("there is no avatar, set a image holder")
                imageView.image = AVATAR_PLACEHOLDER_ADMIN_IMAGE
            }else{
                if let url = NSURL(string: avatar! as String) {
                    imageView.kf_setImageWithURL(url, placeholderImage: AVATAR_PLACEHOLDER_ADMIN_IMAGE)
                }
            }
            
            if let username = cfUser.user?.nick{
                if username.utf16.count != 0 {
                    label.text = username
                }else{
                    label.text = ""
                }
            }
            
        }
    }
    
}

