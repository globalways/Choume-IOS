import Foundation
import Alamofire
import SwiftyJSON
import Qiniu

//1. 环途用户中心服务器
//    - http: 121.42.48.12:6060
//    - rpc: 121.42.48.12:6061
//2. 筹么APP服务器
//    - http: 121.42.48.12:8088
//    - rpc: 121.42.48.12:8089
//    - admin: 121.42.48.12:8090

//筹么http
let CMHttpURL = "http://121.42.48.12:8088/"
let HTHttpURL = "http://121.42.48.12:6060/"

class APIClient {
    
    static let RESP = "resp"
    static let CODE = "code"
    static let MSG  = "msg"
    static let cfUser = "cfUser"
    static let TOKEN = "token"
    static let sharedInstance = APIClient()
    
    private init(){}
    
    func getJSONData(server: String!,path: String, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        print("get url:",server+path)
        Alamofire.request(.GET, server + path, parameters: parameters, encoding: .JSON)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }

    func postJSONData(server: String!,path: String, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        print("post url:",server+path)
        Alamofire.request(.POST, server + path, parameters: parameters, encoding: .JSON)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }
    
    func deleteJSONData(server: String!,path: String, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        Alamofire.request(.DELETE, server + path, parameters: parameters, encoding: .JSON)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }

    func isTokenLegal(uid: AnyObject, token: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void){
        let param = ["uid": uid, "token": token]
        self.getJSONData(CMHttpURL,path: "isTokenLegal", parameters: param, success: success, failure: failure)
    }
    
    func readMessage(uid: AnyObject, token: AnyObject, msgID: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["uid": uid, "token": token, "msg_id": msgID]
        self.getJSONData(CMHttpURL,path: "read_message", parameters: dict , success: success, failure: failure)
    }
    
    func getMessages(userID: AnyObject, token: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["uid": userID, "token": token]
        self.getJSONData(CMHttpURL, path: "messages", parameters: dict, success: success, failure: failure)
    }
    
    func sendMessage(uid: AnyObject, token: AnyObject, receiver_uid: AnyObject,title: AnyObject, content: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["uid": uid, "send_to": receiver_uid,"title": title, "content": content, "token": token]
        self.postJSONData(CMHttpURL, path: "send_message", parameters: dict, success: success, failure: failure)
    }
    
    
    /**
    - parameter title:  title can be nil

    */
    func replyMessage(uid: AnyObject, token: AnyObject, receiver_uid: AnyObject, title: AnyObject?, content: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        var dict = [String: AnyObject]()
        if title == nil {
            dict = ["uid": uid, "send_to": receiver_uid, "content": content, "token": token]
        }else{
            dict = ["uid": uid, "send_to": receiver_uid, "title": title!, "content": content, "token": token]
        }
        self.postJSONData(CMHttpURL, path: "send_message", parameters: dict, success: success, failure: failure)
    }
    
    func post(userID: AnyObject, nodeID: AnyObject, content: AnyObject, title: AnyObject, token: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["uid": userID, "board": nodeID, "content": content, "title": title, "token": token]
        self.postJSONData(CMHttpURL, path: "create_post", parameters: dict, success: success, failure: failure)
    }
    
    func comment(userID: AnyObject, postID: AnyObject, content: AnyObject, token: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["uid": userID, "post_id": postID, "content": content, "token": token]
        self.postJSONData(CMHttpURL, path: "create_comment", parameters: dict, success: success, failure: failure)
    }
    
    
    //--------------------------------  用户相关  ---------------------------------------
    
    func userRegister(tel: AnyObject, username: AnyObject, passwd: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["tel": tel, "nick": username, "password": passwd]
        self.postJSONData(CMHttpURL, path: "users/register", parameters: dict, success: success, failure: failure)
    }
    
    func userLogin(token: String?,userID: AnyObject, passwd: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        var tmpToken = token
        if tmpToken == nil {
            tmpToken = String("")
        }
        let dict = ["username": userID, "password": passwd, "token":tmpToken!]
        print(dict)
        self.postJSONData(CMHttpURL, path: "users/login", parameters: dict, success: success, failure: failure)
    }
    // 注销用户 (http url: /users/logout[post])
    func logoutApp(token: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token]
        self.postJSONData(CMHttpURL, path: "users/logout", parameters: dict, success: success, failure: failure)
    }
    
    
    
    
    // 更改昵称
    func userChangeNick(token: String!, nick: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["nick": nick, "token":token]
        self.postJSONData(HTHttpURL, path: "users/nick/change", parameters: dict, success: success, failure: failure)
    }
    // 新增用户地址
    func userNewAddress(token: String!, name: String, contact: String?, area: String?, detail: String?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "name":name, "contact":contact, "area":area, "detail":detail]
        self.postJSONData(HTHttpURL, path: "users/addrs", parameters: dict, success: success, failure: failure)
    }
    // 修改密码
    func userChangePassword(token: String!, passwordOld: String, passwordNew: String?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "passwordOld":passwordOld, "passwordNew":passwordNew]
        self.postJSONData(HTHttpURL, path: "users/password/change", parameters: dict, success: success, failure: failure)
    }
    
    // 更改昵称 (http url: /users/nick/change [post]
    func changeUserAvatar(token: String!, avatar: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "avatar":avatar]
        self.postJSONData(HTHttpURL, path: "users/avatar/change", parameters: dict, success: success, failure: failure)
    }
    
    
    
    // 更新用户基本信息 (http url: /users/update [post])
    func updateAppUser(token: String, cfUser: CfUser, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "cfUser": JSONSerializer.toJson(cfUser)]
        self.postJSONData(CMHttpURL, path: "users/update", parameters: dict, success: success, failure: failure)
    }
    
    // 获取app用户信息 (http url: /users/info [get])
    func getAppUser(hongId: UInt64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["hongId": String(hongId)]
        self.getJSONData(CMHttpURL, path: "users/info", parameters: dict, success: success, failure: failure)
    }
    
    // 新增用户认证 （http url: /users/cert[post]）
    func userCertApply(token: String, apply: CfUserCertApply, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "apply": JSONSerializer.toJson(apply)]
        self.postJSONData(CMHttpURL, path: "users/cert", parameters: dict, success: success, failure: failure)
    }
    
    // 收藏项目 （http url: /users/projects/collect[post]）
    func userCollectProject(token: String, projectId: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "projectId": String(projectId)]
        self.postJSONData(CMHttpURL, path: "users/projects/collect", parameters: dict, success: success, failure: failure)
    }
    
    // 取消收藏项目 （http url: /users/projects/collect[delete]）
    func userUncollectProject(token: String, projectId: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "projectId": String(projectId)]
        self.deleteJSONData(CMHttpURL, path: "users/projects/collect", parameters: dict, success: success, failure: failure)
    }
    
    
    // 筹币消费 (http url: /users/cb/consume [post])
    func cfUserCBConsume(token: String, coin: UInt64, orderId: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "coin": String(coin), "orderId": orderId]
        self.postJSONData(CMHttpURL, path: "users/cb/consume", parameters: dict, success: success, failure: failure)
    }
    
    // 筹币兑换 (http url: /users/cb/exchage [post])
    func cfUserCBExchange(token: String, rmb: UInt64, password: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "rmb": String(rmb), "password": password]
        self.postJSONData(CMHttpURL, path: "users/cb/exchage", parameters: dict, success: success, failure: failure)
    }
    
    // 筹币提现 (http url: /users/cb/withdraw [post])
    func cfUserWithdraw(token: String, coin: UInt64, thirdPartyWalletId: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "coin": String(coin), "thirdPartyWalletId": String(thirdPartyWalletId)]
        self.postJSONData(CMHttpURL, path: "users/cb/withdraw", parameters: dict, success: success, failure: failure)
    }
    
    // 筹币明细 (http url: /users/cb/history [get])
    func cfUserHistories(token: String, type: CFCBHistoryType, startTime: Int64, endTime: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "type": String(type.rawValue), "startTime": String(startTime), "endTime": String(endTime)]
        self.getJSONData(CMHttpURL, path: "users/cb/history", parameters: dict, success: success, failure: failure)
    }
    
    
    
    
    
    //------------------  项目相关 -------------------------------------
    
    
    
    // 发起一个项目 （http url: /projects[post]）
    func raiseCfProject(token: String!, project: CfProject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "project":JSONSerializer.toJson(project)]
        self.postJSONData(CMHttpURL, path: "projects", parameters: dict, success: success, failure: failure)
    }
    
    // 查询不同种类的项目(首页分类项目列表) （http url: /projects [get]）
    func findCfProject(category: CrowdFundingCategory, status: CfProjectStatus, tag: CfProjectTag, page: Int, size: Int, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: Int]  = ["category": category.rawValue, "status": status.rawValue, "tag": tag.rawValue, "page": page, "size": size]
        self.getJSONData(CMHttpURL, path: "projects", parameters: dict, success: success, failure: failure)
    }
    
    // 查询一个项目详情 (http url: /projects/single [get])
    func getCfProject(id: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["id": String(id)]
        self.getJSONData(CMHttpURL, path: "projects/single", parameters: dict, success: success, failure: failure)
    }
    
    // 结束项目 (http url: /projects [delete])
    func closeCfProject(token: String, id: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["id": String(id), "token":token]
        self.deleteJSONData(CMHttpURL, path: "projects", parameters: dict, success: success, failure: failure)
    }
    
    // 更新项目基本信息 (http url: /projects/single [post])
    func updateCfProject(token: String, project: CfProject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["project": JSONSerializer.toJson(project), "token":token]
        self.postJSONData(CMHttpURL, path: "projects/single", parameters: dict, success: success, failure: failure)
    }
    
    
    // 新增项目投资 (http url: /projects/invest [post])
    func newCfProjectInvest(token: String, cfProjectId: Int64, cfProjectRewardId: Int64, count: Int64, comment: String?,addrId: Int64?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["cfProjectId": String(cfProjectId), "token":token, "cfProjectRewardId": String(cfProjectRewardId), "count": String(count), "addrId": String(addrId)]
        self.postJSONData(CMHttpURL, path: "projects/invest", parameters: dict, success: success, failure: failure)
    }
    
    // 接受项目投资 (http url: /projects/invest/pass [post])
    func passCfProjectInvest(token: String, investId: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["investId": String(investId), "token":token]
        self.postJSONData(CMHttpURL, path: "projects/invest/pass", parameters: dict, success: success, failure: failure)
    }
    
    // 拒绝项目投资 (http url: /projects/invest/reject [post])
    func rejectCfProjectInvest(token: String, investId: Int64, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict:[String: String]  = ["investId": String(investId), "token":token]
        self.postJSONData(CMHttpURL, path: "projects/invest/reject", parameters: dict, success: success, failure: failure)
    }
    
    
    func getLatestTopics(page: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let param = ["page": page]
        self.getJSONData(CMHttpURL, path: "latest", parameters: param, success: success, failure: failure)
    }
    
    func getLatestTopics(nodeID: AnyObject, page: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["boardId": nodeID, "page": page]
        self.getJSONData(CMHttpURL, path: "posts", parameters: dict, success: success, failure: failure)
    }

    func getReplies(postID: AnyObject, page: AnyObject, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["postId": postID, "page": page]
        self.getJSONData(CMHttpURL, path: "comments", parameters: dict, success: success, failure: failure)
    }
    
    func getNodes(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData(CMHttpURL, path: "boards", parameters: nil, success: success, failure: failure)
    }
    
    //--------------- qiniu------------------------------------------------------------
    
    // 制作上传凭证 (http url: /qiniu/uptoken [post])
    func makeUpToken(token: String!,key: String, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["token": token, "appId":"com.globalways.choume","bucket":"choume","key": key]
        self.postJSONData(HTHttpURL, path: "qiniu/uptoken", parameters: dict, success: success, failure: failure)
    }

    
    func uploadImage(token: String,imageDatas: [NSData],success: ([String]) -> Void,failure: (NSError) -> Void){
        let upManager: QNUploadManager = QNUploadManager()
        var qiniu_keys = [String]()
        for index in 0...imageDatas.count-1 {
            let key = NSUUID().UUIDString
            makeUpToken(token,key: key, success: { (json) -> Void in
               let code = json[APIClient.RESP][APIClient.CODE].intValue
                    print(json)
                    if APIStatus(rawValue: code) != .OK {
                        
                    } else {
                        let uptoken = json["upToken"]["uptoken"].stringValue
                        let domain = json["upToken"]["domain"].stringValue
                        upManager.putData(imageDatas[index], key: key, token: uptoken, complete: {
                            (info, key, respDict) -> Void in
                            if info.statusCode == 200 && respDict != nil {
                                let url = "http://"+domain+"/"+key
                                qiniu_keys.append(url)
                                if qiniu_keys.count == imageDatas.count {
                                    success(qiniu_keys)
                                }
                            } else {
                                print(info.error)
                            }
                            
                            }, option: nil)
                    }
                }, failure: { (error) -> Void in
                    print(error)
                   }
            )
            
            
        }
    }
    
}

enum APIStatus: Int {
    case OK                        = 1
    case APP_ERROR                 = 100
    case SERVER_ERROR              = 101
    case LOGIN_TOKEN_ERROR         = 102
    case USER_UNAUTHORIZED         = 103
    case USER_RES_INSUFFICIENT     = 104
    case USER_REGISTER_ERROR       = 105
    case NICK_OR_PW_ERROR          = 106
    case PARAM_ERROR               = 107
    case USER_EXISTS               = 108
    case UNSUPPORTED_SMS           = 109
    case SMS_CODE_ERROR            = 110
    case WALLET_NSF                = 111
    case RECORD_NOT_FOUND          = 112
    case THIRD_PARTY_WALLET_ERROR  = 113
    case USER_LOCKED               = 114
    case PROJECT_NOT_PUBLISH       = 115
    case PROJECT_HAS_RETURN_FULL   = 116
    case PROJECT_OUT_DATE          = 117
    
    func description() -> String {
        switch self {
        case .OK                        : return "ok"
        case .APP_ERROR                 : return "app错误"
        case .SERVER_ERROR              : return "服务器错误"
        case .LOGIN_TOKEN_ERROR         : return "登陆token错误"
        case .USER_UNAUTHORIZED         : return "用户未被授权"
        case .USER_RES_INSUFFICIENT     : return "用户资源不够"
        case .USER_REGISTER_ERROR       : return "注册用户错误"
        case .NICK_OR_PW_ERROR          : return "用户名密码错误"
        case .PARAM_ERROR               : return "请求参数错误"
        case .USER_EXISTS               : return "用户已经存在"
        case .UNSUPPORTED_SMS           : return "不支持的短信类型"
        case .SMS_CODE_ERROR            : return "短信验证码错误"
        case .WALLET_NSF                : return "钱包余额不足"
        case .RECORD_NOT_FOUND          : return "未找到该记录"
        case .THIRD_PARTY_WALLET_ERROR  : return "第三方钱包未验证"
        case .USER_LOCKED               : return "用户被锁定"
        case .PROJECT_NOT_PUBLISH       : return "众筹项目未发布"
        case .PROJECT_HAS_RETURN_FULL   : return "众筹项目的某一回报方式已经投资满额"
        case .PROJECT_OUT_DATE          : return "众筹项目过期了"
        }
    }
}