import UIKit
import SwiftyJSON
import JSONJoy


class CMRegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var avatarImageView: CMAvatarImageView! {
        didSet{
            avatarImageView.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            avatarImageView.image           = AVATAR_PLACEHOLDER_IMAGE
        }
    }
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.secureTextEntry = true
        }
    }
    @IBOutlet var passwordAgainTextField: UITextField! {
        didSet{
            passwordAgainTextField.secureTextEntry = true
        }
    }
    @IBOutlet weak var signupButton: UIButton!
    
    private var blurView: UIView!    
    override func loadView() {
        super.loadView()
        usernameTextField.delegate      = self
        //emailTextField.delegate         = self
        telTextField.delegate           = self
        passwordTextField.delegate      = self
        passwordAgainTextField.delegate = self
        self.view.backgroundColor       = theme.CMWhite
        blurView                        = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.frame                  = self.view.frame
        blurView.alpha                  = BLUR_VIEW_ALPHA_OF_BG_IMAGE + 0.2
        self.view.insertSubview(blurView, atIndex: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.becomeFirstResponder()
        let origImage = signupButton.imageView?.image
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        signupButton.setImage(tintedImage, forState: .Normal)
        signupButton.tintColor = theme.CMNavBGColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurView.frame = self.view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        //        UIView.animateWithDuration(0.75, animations: { () -> Void in
        //            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        //            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.navigationController!.view, cache: false)
        //        })
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        let username = usernameTextField.text as NSString?
        //diable email enable tel
        let email = "disable@xxx.com" as NSString?
        let tel = telTextField.text as NSString?
        let passwd = passwordTextField.text as NSString?
        let passwdAgain = passwordAgainTextField.text as NSString?
        
        if username?.length == 0 || email?.length == 0 || passwd?.length == 0 || passwdAgain?.length == 0 {
            // not all the form are filled in
            let alertCtl = CMAlertController(title: FILL_IN_ALL_THE_FORM, message: CHECK_IT_AGAIN, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: I_WILL_CHECK, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return
        }
        
        if username?.length > 15 || username?.length < 4 {
            let alertCtl = CMAlertController(title: "", message: CHECK_DIGITS_OF_USERNAME, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return
        }
        
        if !email!.isValidEmail(){
            // invalid email address
            let alertCtl = CMAlertController(title: "", message: INVALID_EMAIL, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return
        }
        
        if passwd?.length < 6 {
            let alertCtl = CMAlertController(title: "", message: CHECK_DIGITS_OF_PASSWORD, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: I_KNOW, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return
        }
        
        if !passwd!.isValidPassword() {
            let alertCtl = CMAlertController(title: "", message: INVALID_PASSWORD, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return

        }
        
        if passwd != passwdAgain {
            let alertCtl = CMAlertController(title: PASSWD_MUST_BE_THE_SAME, message: TRY_AGAIN, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: nil)
            alertCtl.addAction(cancelAction)
            
            self.presentViewController(alertCtl, animated: true, completion: nil)
            return
        }
        
        // everything is fine, ready to go
        var encryptedPasswd = (passwd as! String).MD5()
        APIClient.sharedInstance.userRegister(tel!, username: username!, passwd: encryptedPasswd, success: { (json) -> Void in
            print(json)
            let code = json[APIClient.RESP][APIClient.CODE].intValue
            if code == APIStatus.OK.rawValue {
                // register successfully!
                print(JSONDecoder(json[APIClient.cfUser].stringValue))
                //通过tel登录 username 即tel
                APIClient.sharedInstance.userLogin(nil,userID: tel!, passwd: encryptedPasswd, success: { (json) -> Void in
                    print(json)
                    let code = json[APIClient.RESP][APIClient.CODE].intValue
                    if APIStatus(rawValue: code) == .OK {
                        
                        CMContext.sharedInstance.saveLoginData(json[APIClient.cfUser].object)
                        CMContext.sharedInstance.saveToken(json[APIClient.TOKEN].object)
                        if let cfUser = json[APIClient.cfUser].toCfUser() {
                            CMContext.currentUser = cfUser
                        }
                        
                        self.view.makeToast(message: REGISTER_SUCESSFULLY, duration: TIME_OF_TOAST_OF_REGISTER_SUCCESS, position: HRToastPositionTop)
                        
                        let delayInSeconds: Double = 1
                        let delta = Int64(Double(NSEC_PER_SEC) * delayInSeconds)
                        let popTime = dispatch_time(DISPATCH_TIME_NOW,delta)
                        dispatch_after(popTime, dispatch_get_main_queue(), {
                            // do something
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        })
                    }
                    }, failure: { (error) -> Void in
                        print(error)
                        self.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
                        
                })
                
            }else{
                // failed
                let errorInfo = json[APIClient.RESP][APIClient.MSG].stringValue
                let description = APIStatus(rawValue: code)?.description()
                let alertCtl = CMAlertController(title: REGISTER_FAILED, message: description, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: TRY_AGAIN, style: .Cancel, handler: nil)
                alertCtl.addAction(cancelAction)
                
                self.presentViewController(alertCtl, animated: true, completion: nil)

            }
            }, failure: { (error) -> Void in
                print(error)
                self.view.makeToast(message: SERVER_ERROR, duration: TIME_OF_TOAST_OF_SERVER_ERROR, position: HRToastPositionTop)
                
        })
        
    }
    
    // MARK: - text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            textField.resignFirstResponder()
            telTextField.becomeFirstResponder()
        }else if textField == telTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            textField.resignFirstResponder()
            passwordAgainTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
//            performSelector("signupButton:")
        }
        return true
    }
    
}



