//
//  CMEntity.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/18.
//  Copyright © 2015年 outsouring. All rights reserved.
//
import Foundation
import ObjectMapper


//-------------------  筹么用户 ---------------------------------


class CfUser: Mappable {
    var id: Int?
    var hongId: Int?
    var fundProjects: [CfProject]           = []
    var certification: CfUserCertApply?
    var collectedProjects: Array<CfProject> = []
    var investProjects: [CfProjectInvest]   = []
    var point:Int = 0
    var coin:Int  = 0
    var rcToken:String?
    var role: CfUserRole = CfUserRole.USER_CFUR
    var user: User?
    
    required init?(_ map: Map){
        
    }
    func mapping(map: Map){
        id                 <- map["id"]
        hongId             <- map["hongId"]
        fundProjects       <- map["fundProjects"]
        certification      <- map["certification"]
        collectedProjects  <- map["collectedProjects"]
        investProjects     <- map["investProjects"]
        point              <- map["point"]
        coin               <- map["coin"]
        rcToken            <- map["rcToken"]
        role               <- map["role"]
        user               <- map["user"]
    }
}

// 众筹用户收货地址
class UserAddress: Mappable {
    var id: Int?
    var name: String?
    var contact: String?
    var area: String?
    var detail: String?
    var userId: Int?

    init(){}
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                 <- map["id"]
        name               <- map["name"]
        contact            <- map["contact"]
        area               <- map["area"]
        detail             <- map["detail"]
        userId             <- map["userId"]
    }
    
}

enum CfUserRole: Int {
    case INVALID_CFUR = 0;
    case USER_CFUR = 1;
    case ADMIN_CFUR = 2;
}


// 认证类型
enum CfUserCertificationType: Int {
    case INVALID_CFUCT = 0;
    case STUDENT_CFUCT = 1;
    case AGENCY_CFUCT = 2;
}

// 认证状态
enum CfUserCeritificationStatus: Int {
    case INVALID_CFUCS = 0;
    // 申请中
    case APPLYING_CFUCS = 1;
    // 成功
    case SUCCESS_CFUCS = 2;
    // 失败
    case FAILURE_CFUCS = 3;
}

// 认证申请
class CfUserCertApply: Mappable {
    var id: Int?
    // 认证类型
    var type: CfUserCertificationType?
    // 用户id
    var cfUserId: Int?
    // 申请时间
    var applyTime: Int?
    // 认证状态
    var status: CfUserCeritificationStatus?
    // 审核人
    var auditor: Int?
    // 备注
    var comment: String?
    // 审核时间
    var auditTime: Int?
    // 认证名
    var name: String?
    // 所属学校
    var school: String?
    // 材料
    var pics:Array<CfUserCertPic>?
    var hongId: Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                 <- map["id"]
        type               <- map["type"]
        cfUserId           <- map["cfUserId"]
        applyTime          <- map["applyTime"]
        status             <- map["status"]
        auditor            <- map["auditor"]
        comment            <- map["comment"]
        auditTime          <- map["auditTime"]
        name               <- map["name"]
        school             <- map["school"]
        pics               <- map["pics"]
        hongId             <- map["hongId"]
    }
    
}


// 认证申请材料
class CfUserCertPic: Mappable {
    var id: Int?
    var cfUserCertApplyId: Int?
    var url: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                 <- map["id"]
        cfUserCertApplyId  <- map["cfUserCertApplyId"]
        url                <- map["url"]
    }
}


//------------------------------  筹么项目  ----------------------------

// 众筹项目
class CfProject: Mappable, Equatable {
    var id: Int?
    // 标题
    var title: String?
    // 描述（255字符）
    var desc:String?
    // 联系人
    var contact:String?
    // 联系方式
    var tel: String?
    // 发起者
    var cfUserId: Int?
    // 发起时间
    var fundTime: Int?
    // 图片列表
    var pics: [CfProjectPic] = []
    // 想筹集的钱(筹币)
    var requiredMoneyAmount: Int = 0
    // 想筹集的物品数量
    var requiredGoodsAmount: Int = 0
    // 想筹集的人数
    var requiredPeopleAmount: Int = 0
    // 募集的物品名称
    var requiredGoodsName: String?
    // 截止日期
    var deadline: Int = 0
    // 众筹类别
    var category: CrowdFundingCategory?
    // 回报方式列表
    var rewards: Array<CfProjectReward>?
    var status: CfProjectStatus?
    // 收藏的用户
    var collectedUsers: Array<CfUser>?
    // 投资记录
    var invests: Array<CfProjectInvest> = []
    // 聚合标签
    var tag: CfProjectTag?
    // 发起者hongid
    var hongId: Int?
    var auditTime: Int?
    var auditer: Int?
    // 已筹的钱(筹币)
    var alreadyMoneyAmount: Int = 0
    // 已筹的物品数
    var alreadyGoodsAmount: Int = 0
    // 已筹的人数
    var alreadyPeopleAmount: Int = 0
    // 主要目标类型
    var majarType: CfProjectSupportType?
    // 学校code
    var school: String?
    // 校园合伙人-项目-融资额
    var requiredProjectAmount: Int?
    // 校园合伙人-项目-出让股份千分之n
    var requiredProjectEquity: Int?
    // 校园合伙人-项目-已筹集的股份
    var alreadyProjectEquity: Int?
    // 附加费统计
    var additionalCoin: Int?
    // 校园合伙人-产品-二次收益分配股权
    var secondProductEquity: Int?
    // 从哪个项目派生
    var parentProjectId: Int?
    // 利润率  千分之n
    var profitRate: Int?
    // 介绍 html文本
    var intro: String?
    
    init(){
        
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                       <- map["id"]
        title                    <- map["title"]
        desc                     <- map["desc"]
        contact                  <- map["contact"]
        tel                      <- map["tel"]
        cfUserId                 <- map["cfUserId"]
        fundTime                 <- map["fundTime"]
        pics                     <- map["pics"]
        requiredMoneyAmount      <- map["requiredMoneyAmount"]
        requiredGoodsAmount      <- map["requiredGoodsAmount"]
        requiredPeopleAmount     <- map["requiredPeopleAmount"]
        requiredGoodsName        <- map["requiredGoodsName"]
        deadline                 <- map["deadline"]
        category                 <- map["category"]
        rewards                  <- map["rewards"]
        status                   <- map["status"]
        collectedUsers           <- map["collectedUsers"]
        invests                  <- map["invests"]
        tag                      <- map["tag"]
        hongId                   <- map["hongId"]
        auditTime                <- map["auditTime"]
        auditer                  <- map["auditer"]
        alreadyMoneyAmount       <- map["alreadyMoneyAmount"]
        alreadyGoodsAmount       <- map["alreadyGoodsAmount"]
        alreadyPeopleAmount      <- map["alreadyPeopleAmount"]
        majarType                <- map["majarType"]
        school                   <- map["school"]
        requiredProjectAmount    <- map["requiredProjectAmount"]
        requiredProjectEquity    <- map["requiredProjectEquity"]
        alreadyProjectEquity     <- map["alreadyProjectEquity"]
        additionalCoin           <- map["additionalCoin"]
        secondProductEquity      <- map["secondProductEquity"]
        parentProjectId          <- map["parentProjectId"]
        profitRate               <- map["profitRate"]
        intro                    <- map["intro"]
    }
    
}

func ==(lhs: CfProject, rhs: CfProject) -> Bool {
    return lhs.id == rhs.id
}


// 支持方式
enum CfProjectSupportType: RawRepresentable {
    case INVALID_CFPST
    // 钱
    case MONEY_CFPST
    // 人
    case PEOPLE_CFPST
    // 物
    case GOODS_CFPST
    // 股权众筹 校园合伙人项目类专用
    case EQUITY_CFPST

    typealias RawValue = Int
    var rawValue: RawValue {
        switch self {
        case .INVALID_CFPST: return 0
        case .MONEY_CFPST: return 1
        case .PEOPLE_CFPST:return 2
        case .GOODS_CFPST: return 3
        case .EQUITY_CFPST: return 4
        }
    }
        
    
    init?(rawValue: CfProjectSupportType.RawValue) {
        switch rawValue {
        case 0: self = .INVALID_CFPST; break
        case 1: self = .MONEY_CFPST; break
        case 2: self = .PEOPLE_CFPST; break
        case 3: self = .GOODS_CFPST; break
        case 4: self = .EQUITY_CFPST; break
        default: self = .INVALID_CFPST; break
        }
    }
    
    func desc(count: Int) -> String {
        switch self {
        case .MONEY_CFPST: return String(count)+"筹币"
        case .PEOPLE_CFPST: return "人员"+String(count)+"名"
        case .GOODS_CFPST: return "物品"+String(count) + "件"
        case .EQUITY_CFPST: return ""
        default: return "未知"
        }
    }
}

// 众筹类别
enum CrowdFundingCategory: Int {
    case INVALID_CFC = 0;
    // 筹乐子
    case HAPPY_CFC = 1;
    // 筹票子
    case MONEY_CFC = 2;
    // 筹爱心
    case LOVE_CFC = 3;
    // 校园合伙人-项目
    case PROJECT_CFC = 4;
    // 校园合伙人-产品
    case PRODUCT_CFC = 5;
}

// 众筹标签，聚合分类
enum CfProjectTag: Int {
    case INVALID_CFPT = 0;
    // 一元秒筹，限时特筹
    case LIMIT_TIME_CFPT = 1;
    // 世纪难题，周末去哪
    case QUESTION_CFPT = 2;
    // 热门众筹，非筹不可
    case HOT_CFPT = 3;
}

// 众筹项目状态
enum CfProjectStatus: Int {
    case INVALID_CFPS = 0;
    // 审核中
    case AUDITING_CFPS = 1;
    // 已发布
    case PUBLISHED_CFPS = 2;
    // 已筹满(主要目标)
    case FINISH_CFPS = 3;
    // 失败
    case FAILURE_CFPS = 4;
    // 已完成
    case COMPLETED_CFPS = 5;
}

// 项目投资状态
enum CfProjectInvestStatus: Int {
    case INVALID_CFPIS = 0;
    // 等待
    case PENDING_CFPIS = 1;
    // 已支付
    case PAID_CFPIS = 2;
    // 成功
    case SUCCESS_CFPIS = 3;
    // 过期
    case EXPIRED_CFPIS = 4;
    func desc() -> String {
        switch self {
        case .PENDING_CFPIS: return "等待"
        case .PAID_CFPIS: return "已支付"
        case .SUCCESS_CFPIS: return "成功"
        case .EXPIRED_CFPIS: return "过期"
        default:
            return "未知状态"
        }
    }
}

// 众筹项目投资记录
class CfProjectInvest: Mappable {
    var id: Int?
    // 项目id
    var cfProjectId: Int?
    // 回报方式ID
    var cfProjectRewardId: Int?
    // 投资份数
    var count: Int?
    // 投资时间
    var investTime: Int = 0
    // 用户
    var hongId: Int?
    // 备注
    var comment: String?
    // 地址id
    var addrId: Int = 0
    // 过期时间
    var expiredTime: Int?
    // 投资状态
    var status: CfProjectInvestStatus?
    // 订单
    var orderId: String?
    // 应该支付的筹币数
    var coinPay: Int?
    // 回报方式
    var rewardName: String?
    // 项目
    var projectName: String?
    // 投资者内部id,关联用,客户端不管
    var cfUserId: Int?
    // 项目头一张图
    var projectPic:String = ""
    // 支持份数
    var rewardCount: Int = 0
    // 每份的量
    var rewardAmount: Int = 0
    // 回报方式类型
    var rewardSupportType: CfProjectSupportType = .INVALID_CFPST
    // 投资者头像
    var investorAvatar: String = ""
    // 投资者昵称
    var investorNick: String?
    
    required init?(_ map: Map){
        
    }

    func mapping(map: Map){
        id                   <- map["id"]
        cfProjectId          <- map["cfProjectId"]
        cfProjectRewardId    <- map["cfProjectRewardId"]
        count                <- map["count"]
        investTime           <- map["investTime"]
        hongId               <- map["hongId"]
        comment              <- map["comment"]
        addrId               <- map["addrId"]
        expiredTime          <- map["expiredTime"]
        status               <- map["status"]
        orderId              <- map["orderId"]
        coinPay              <- map["coinPay"]
        rewardName           <- map["rewardName"]
        projectName          <- map["projectName"]
        cfUserId             <- map["cfUserId"]
        projectPic           <- map["projectPic"]
        rewardCount          <- map["rewardCount"]
        rewardAmount         <- map["rewardAmount"]
        rewardSupportType    <- map["rewardSupportType"]
        investorAvatar       <- map["investorAvatar"]
        investorNick         <- map["investorNick"]
    }

}

// 回报方式
class CfProjectReward: Mappable {
    var id: Int?
    // 回报描述(255字符)
    var desc: String?
    // 支持方式
    var supportType: CfProjectSupportType?
    // 支持数量(人/钱/物/股权), 股权支持为千分之n
    var amount: Int = 0
    // 限制份数
    var limitedCount: Int?
    // 项目id
    var CfProjectId: Int?
    // 已经投资的份数
    var alreadyCount: Int = 0
    // 附加筹币
    var additionalCoin: Int?
    // 是否已被删除
    var del: Bool?
    // 是否需要收货地址
    var needAddr: Bool = false
    // 是否需要联系方式
    var needPhone: Bool = false
    
    init(){
        
    }
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                     <- map["id"]
        desc                   <- map["desc"]
        supportType            <- map["supportType"]
        amount                 <- map["amount"]
        limitedCount           <- map["limitedCount"]
        CfProjectId            <- map["CfProjectId"]
        alreadyCount           <- map["alreadyCount"]
        additionalCoin         <- map["additionalCoin"]
        del                    <- map["del"]
        needAddr               <- map["needAddr"]
        needPhone              <- map["needPhone"]
    }
}

// 用户与项目的收藏关系 many to many
class UsersCollectProjects {
    var id: Int?
    // 项目id
    var CfProjectId: Int?
    // 用户id
    var CfUserId:Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                     <- map["id"]
        CfProjectId            <- map["CfProjectId"]
        CfUserId               <- map["CfUserId"]
    }
}

// 众筹项目图片
class CfProjectPic: Mappable {
    var id: Int!
    var cfProjectId: Int?
    var url: String!
    // 是否已被删除
    var del: Bool = false
    
    required init?(_ map: Map){
        
    }
    
    init(url: String){
        self.url = url
    }

    func mapping(map: Map){
        id                     <- map["id"]
        cfProjectId            <- map["CfProjectId"]
        url                    <- map["url"]
        del                    <- map["del"]
    }
}

//------------------------  钱包  --------------------------

// 筹币消费类型
enum CFCBHistoryType: Int {
    case INVAILD_CB = 0;
    // 兑换
    case EXCHANGE_CB = 1;
    // 消费
    case CONSUME_CB = 2;
    // 提现
    case WITHDRAW_CB = 3;
    // 退还
    case TURNBACK_CB = 4;
    // 平台赠送
    case GIVE_CB = 5;
    // 项目筹集
    case CHOU_CB = 6;
}

// 筹币消费记录
class CFCBHistory {
    var id: Int!
    var type: CFCBHistoryType?
    var coin: Int?
    var remain: Int?
    var time: Int?
    var orderId: String?
    var hongId: Int?
    var finished: Bool?
    
    required init?(_ map: Map){
        
    }

    func mapping(map: Map){
        id                     <- map["id"]
        type                   <- map["type"]
        coin                   <- map["coin"]
        remain                 <- map["remain"]
        time                   <- map["time"]
        orderId                <- map["orderId"]
        hongId                 <- map["hongId"]
        finished               <- map["finished"]
    }
}

//---------------------- 消息 ------------------------------
// 消息类型
enum CfMessageType: Int {
    case INVALID_CFMT = 0;
    // 文字消息
    case TXT_CFMT = 1;
    // 网页链接
    case WEB_CFMT = 2;
}

// 众筹系统消息
class CfMessage: Mappable {
    // 消息头
    var title: String?
    // 时间
    var time: Int?
    // 消息类型
    var type: CfMessageType?
    // 消息内容
    var content: String?
    // 项目消息此处有值
    var project: CfProject?
    // 评论消息此处有值
    var comment: CfProjectComment?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        title                  <- map["title"]
        time                   <- map["time"]
        type                   <- map["type"]
        content                <- map["content"]
        project                <- map["project"]
        comment                <- map["comment"]
    }
}


// 项目评论
class CfProjectComment: Mappable {
    var id: Int!
    // 项目id
    var projectId: Int?
    // 评论人头像
    var avatar: String = ""
    // 评论人hongid
    var userId: Int?
    // 评论人nick
    var userNick: String?
    // 被回复人hongid
    var repliedUserId: Int?
    // 被回复人nick
    var repliedUserNick: String?
    // 内容
    var content: String?
    // 评论时间
    var time: Int = 0
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                  <- map["id"]
        projectId           <- map["projectId"]
        avatar              <- map["avatar"]
        userId              <- map["userId"]
        userNick            <- map["userNick"]
        repliedUserId       <- map["repliedUserId"]
        repliedUserNick     <- map["repliedUserNick"]
        content             <- map["content"]
        time                <- map["time"]
    }
}



//------------------------ ht ------------------------------

class User: Mappable{
    var id: Int?
    var hongId: Int?
    var nick: String?
    var tel: String?
    var email: String?
    var password: String?
    var avatar: String?
    var age: Int?
    var sex: UserSex?
    var authority: UserAuthority?
    var status: UserStatus?
    var regTime: Int?
    var genTime: Int?
    var comment: String?
    // 操作者
    var auditor: Int?
    // 用户地址
    var addrs: [UserAddress]?
    // 用户钱包
    var wallet: UserWallet?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                  <- map["id"]
        hongId              <- map["hongId"]
        nick                <- map["nick"]
        tel                 <- map["tel"]
        email               <- map["email"]
        password            <- map["password"]
        avatar              <- map["avatar"]
        age                 <- map["age"]
        sex                 <- map["sex"]
        authority           <- map["authority"]
        status              <- map["status"]
        regTime             <- map["regTime"]
        genTime             <- map["genTime"]
        comment             <- map["comment"]
        auditor             <- map["auditor"]
        addrs               <- map["addrs"]
        wallet              <- map["wallet"]
    }
}

// 环途用户钱包
class UserWallet:Mappable {
    var id: Int?
    // 用户红id
    var hongId: Int?
    // 余额，单位分
    var amount: Int = 0
    // 绑定的第三方钱包
    var thirdPartyWallets: [ThirdPartyWallet]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                      <- map["id"]
        hongId                  <- map["hongId"]
        amount                  <- map["amount"]
        thirdPartyWallets       <- map["thirdPartyWallets"]
    }
}

// 环途用户钱包明细
class UserWalletHistory: Mappable {
    var id: Int?
    // 用户红id
    var hongId:Int?
    // 明细类型
    var type: UserWalletHistoryType?
    // 额度，单位分
    var amount:Int = 0;
    // 创建时间
    var created:Int = 0;
    // 标题
    var subject:String?
    // 剩余余额，单位分
    var remain = 0;
    // 来自哪个app
    var appId:String?
    // 订单id
    var orderId: String?
    // 明细状态
    var status: UserWalletHistoryStatus?
    // 操作者
    var auditor:Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id                    <- map["id"]
        hongId                <- map["hongId"]
        type                  <- map["type"]
        amount                <- map["amount"]
        created               <- map["created"]
        subject               <- map["subject"]
        remain                <- map["remain"]
        appId                 <- map["appId"]
        orderId               <- map["orderId"]
        status                <- map["status"]
        auditor               <- map["auditor"]
    }
}

// 第三方钱包
class ThirdPartyWallet: Mappable {
    var id: Int?
    // 账户名
    var name: String?
    // 账号
    var account: String?
    // 用户钱包id
    var userWalletId: Int?
    // 是否验证通过
    var varified: Bool?
    // 钱包类型
    var type: ThirdPartyWalletType?
    // 创建时间
    var created: Int?
    // 预打款额度，单位分
    var rechargeAmount: Int?
    // 预打款订单id
    var orderId: String?
    // 后台操作人
    var auditor: Int?
    // 来自哪个app
    var appId: String?
    var hongId: Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id                  <- map["id"]
        name                <- map["name"]
        account             <- map["account"]
        userWalletId        <- map["userWalletId"]
        varified            <- map["varified"]
        type                <- map["type"]
        created             <- map["created"]
        rechargeAmount      <- map["rechargeAmount"]
        orderId             <- map["orderId"]
        auditor             <- map["auditor"]
        appId               <- map["appId"]
        hongId              <- map["hongId"]
    }
}

// 第三方钱包类型 枚举
enum ThirdPartyWalletType: Int {
    case INVALID_TPWT = 0;
    // 支付宝
    case ALIPAY_TPWT  = 1;
    // 微信
    case WEIXIN_TPWT  = 2;
    init?(rawValue: Int){
        switch rawValue {
        case 0 : self = .INVALID_TPWT
        case 1 : self = .ALIPAY_TPWT
        case 2 : self = .WEIXIN_TPWT
        default: self = .INVALID_TPWT
        }
    }
}

enum UserWalletHistoryType:Int {
    case INVALID_WHT = 0;
    // 消费
    case CONSUME_WHT = 1;
    // 充值
    case RECHARGE_WHT = 2;
    // 退款
    case REFUND_WHT = 3;
    // 提现
    case WITHDRAW_WHT = 4;
}

enum UserWalletHistoryStatus:Int {
    case INVALID_WHS = 0;
    // 等待
    case PENDING_WHS = 1;
    // 成功
    case SUCCESS_WHS = 2;
    // 失败
    case FAIL_WHS = 3;
    // 取消
    case CANCEL_WHS = 4;
}

enum UserSex: Int {
    case UNKNOWN_Sex    = 0
    case MALE           = 1
    case FAMALE         = 2
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .UNKNOWN_Sex
        case 1: self = .MALE
        case 2: self = .FAMALE
        default: self = .UNKNOWN_Sex
        }
    }
    
    func desc() -> String{
        switch self.rawValue {
        case 0 : return UserSex.descs()[0]
        case 1 : return UserSex.descs()[1]
        case 2 : return UserSex.descs()[2]
        default:return UserSex.descs()[0]
        }
    }
    
    static func descs() -> [String] {
        let descArray = ["未设定","男","女"]
        return descArray
    }
}


enum UserStatus: Int {
    case INVALID  = 0;
    // 未被使用
    case NOTUSE   = 1;
    // 等待被使用
    case PENDING  = 2;
    // 使用中
    case USE      = 3;
    // 锁定中
    case LOCK     = 4;
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .INVALID
        case 1: self = .NOTUSE
        case 2: self = .PENDING
        case 3: self = .USE
        case 4: self = .LOCK
        default: self = .INVALID
        }
    }
}

enum UserAuthority: Int {
    // 基本用户权限
    case USER  = 0;
    // 管理员权限
    case ADMIN = 1;
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .USER
        case 1: self = .ADMIN
        default: self = .USER
        }
    }
}