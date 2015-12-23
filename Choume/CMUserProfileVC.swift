
import UIKit
import SVProgressHUD

class UserProfileVC: UITableViewController {
    
    @IBOutlet weak var userAvatar1: CMAvatarImageView! {
        didSet{
            userAvatar1.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            userAvatar1.image = AVATAR_PLACEHOLDER_IMAGE
            
        }
    }
    private var nick: String = ""{
        didSet{
            userNameDetailLabel.text = nick
            if CMContext.currentUser?.user?.nick != nick {
                CMContext.currentUser?.user?.nick = nick
            }
        }
    }
    private var tel: String = "" {
        didSet{
            telDetailLabel.text = tel
        }
    }
    private var selectedSex: String?
    private var sex:UserSex = .UNKNOWN_Sex {
        didSet{
            sexDetailLabel.text = sex.desc()
        }
    }
    @IBOutlet weak var userNameDetailLabel: UILabel!
    @IBOutlet weak var sexDetailLabel: UILabel!
    @IBOutlet weak var telDetailLabel: UILabel!

    private lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    private lazy var iconActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    var avatarTaped: UITapGestureRecognizer?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        avatarTaped = UITapGestureRecognizer(target: self, action: "tapAvatar")
        userAvatar1.userInteractionEnabled = true
        userAvatar1.addGestureRecognizer(avatarTaped!)
        loadUserInfo()
        
    }
    
    func loadUserInfo() {
        if let cfUser = CMContext.currentUser {
            nick = (cfUser.user?.nick)!
            tel = (cfUser.user?.tel)!
            sex = (cfUser.user?.sex)!
            
            if let avatar_url = cfUser.user?.avatar {
                let url = NSURL(string: avatar_url as String)
                userAvatar1.kf_setImageWithURL(url!, placeholderImage: AVATAR_PLACEHOLDER_ADMIN_IMAGE)
               
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toUserAddressManage"){
            print("toUserAddressManage")
        }
        if segue.identifier == "PickSex" {
            if let sexPickerViewController = segue.destinationViewController as? CMUserSexPickerTVC {
                sexPickerViewController.selectedSex = sex
            }
        }
        if segue.identifier == "toEditUserNick" {
            if let editFiledVC = segue.destinationViewController as? CMFieldEditVC {
                editFiledVC.delegate = self
                editFiledVC.original = nick
            }
        }
        
        
    }
    @IBAction func cancelManageAddress(segue: UIStoryboardSegue){}
    //修改保存了用户名
    @IBAction func savedUserNick(segue: UIStoryboardSegue){
        
    }
    
    func tapAvatar() {
        iconActionSheet.showInView(view)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = theme.CMNavBGColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func unwindWithSelectedSex(segue:UIStoryboardSegue) {
        if let sexPickerViewController = segue.sourceViewController as? CMUserSexPickerTVC,
            selectedSex = sexPickerViewController.selectedSex {
                if sex == selectedSex {
                    return
                }else {
                    
                    CMContext.currentUser?.user?.sex = selectedSex
                    APIClient.sharedInstance.updateAppUser(CMContext.sharedInstance.getToken()!, cfUser: CMContext.currentUser!, success: { (json) -> Void in
                            if json.respStatus() == .OK {
                                self.sex = selectedSex
                            }else {
                                print("update user.sex failed:\(json.respMsg())")
                            }
                        }, failure: { (error) -> Void in
                            
                    })
                }
        }
    }

}

/// MARK: UIActionSheetDelegate
extension UserProfileVC: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex, terminator: "")
        switch buttonIndex {
        case 1:
            openCamera()
        case 2:
            openUserPhotoLibrary()
        default:
            print("", terminator: "")
        }
    }
    
}

/// MARK: 摄像机和相册的操作和代理方法
extension UserProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 打开照相功能
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            pickVC.sourceType = .Camera
            self.presentViewController(pickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showErrorWithStatus("模拟器没有摄像头,请链接真机调试", maskType: SVProgressHUDMaskType.Black)
        }
    }
    
    /// 打开相册
    private func openUserPhotoLibrary() {
        pickVC.sourceType = .PhotoLibrary
        pickVC.allowsEditing = true
        presentViewController(pickVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 对用户选着的图片进行质量压缩,上传服务器,本地持久化存储
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data: NSData?
                    let smallImage = imageClipToNewImage(image, newSize: userAvatar1.size)
                    if UIImagePNGRepresentation(smallImage) == nil {
                        data = UIImageJPEGRepresentation(smallImage, 0.8)
                    } else {
                        data = UIImagePNGRepresentation(smallImage)
                    }
                    
                    if data != nil {
                        do {
                            let datas = [data!]
                            // TODO: 将头像的data传入服务器
                            if let cmToken = CMContext.sharedInstance.getToken(){
                                APIClient.sharedInstance.uploadImage(cmToken, imageDatas: datas, success: { (urls) -> Void in
                                    let token = CMContext.sharedInstance.getToken()
                                    APIClient.sharedInstance.changeUserAvatar(token, avatar: urls[0], success: { (json) -> Void in
                                            CMContext.currentUser?.user?.avatar = urls[0]
                                        }, failure: { (error) -> Void in
                                            
                                    })
                                    }, failure: { (error) -> Void in
                                         print("uploadFaild")
                                })
                            }
                            
                            // 本地也保留一份data数据
                            try NSFileManager.defaultManager().createDirectoryAtPath(theme.cachesPath, withIntermediateDirectories: true, attributes: nil)
                        } catch _ {
                        }
                        print(SD_UserIconData_Path)
                        NSFileManager.defaultManager().createFileAtPath(SD_UserIconData_Path, contents: data, attributes: nil)
                        userAvatar1.image = UIImage(data: NSData(contentsOfFile: SD_UserIconData_Path)!)
                        
                    } else {
                        SVProgressHUD.showErrorWithStatus("照片保存失败", maskType: SVProgressHUDMaskType.Black)
                    }
                }
            }
        } else {
            SVProgressHUD.showErrorWithStatus("图片无法获取", maskType: SVProgressHUDMaskType.Black)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        pickVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageClipToNewImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRect(origin: CGPointZero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UserProfileVC: CMFieldEditVCDelegate {
    func fieldEditVCResponse(para: String) {
        nick = para
    }
}

