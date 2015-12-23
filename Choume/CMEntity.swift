//
//  CMEntity.swift
//  Choume
//
//  Created by 汪阳坪 on 15/12/18.
//  Copyright © 2015年 outsouring. All rights reserved.
//
import Foundation
import JSONJoy

//-------------------  筹么用户 ---------------------------------


struct CfUser: JSONJoy {
    var id: Int64?
    var hongId: Int64?
    var fundProjects:Array<CfProject>?
    var certification:CfUserCertApply?
    var collectedProjects:Array<CfProject>?
    var addrs:Array<CfUserAddr>?
    var point:UInt64?
    var coin:UInt64?
    var rcToken:String?
    var user: User?
    init() {
    }
    init(_ decoder: JSONDecoder) {
        id = Int64(decoder["id"].integer!)
        hongId = Int64(decoder["hongId"].integer!)
        user = User(decoder["user"])
        certification = CfUserCertApply(decoder["certification"])
        if let decoderArray = decoder["collectedProjects"].array {
            collectedProjects = Array<CfProject>()
            for cpDecoder in decoderArray {
                collectedProjects?.append(CfProject(cpDecoder))
            }
        }
//        if let tmp = decoder["certification"].integer {
//            certification = CfUserCertApply(
//        }else{
//            authority = UserAuthority(rawValue: decoder["authority"].integer!)
//        }
    }
}

// 众筹用户收货地址
struct CfUserAddr: JSONJoy {
    var id: Int64?
    var cfUserId: Int64?
    var contact: String?
    var tel: String?
    var address: String?
    init(_ decoder: JSONDecoder) {
        //id = decoder["id"].int64Value
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
struct CfUserCertApply: JSONJoy {
    var id: Int64?
    // 认证类型
    var type: CfUserCertificationType?
    // 用户id
    var cfUserId: Int64?
    // 申请时间
    var applyTime: Int64?
    // 认证状态
    var status: CfUserCeritificationStatus?
    // 审核人
    var auditor: UInt64?
    // 备注
    var comment: String?
    // 审核时间
    var auditTime: Int64?
    // 认证名
    var name: String?
    // 所属学校
    var school: String?
    // 材料
    var pics:Array<CfUserCertPic>?
    var hongId: Int64?
    init(){}
    init(_ decoder: JSONDecoder) {
        id = decoder["id"].int64Value
        if let tmp = decoder["type"].integer {
            type = CfUserCertificationType(rawValue: tmp)
        }
        cfUserId = decoder["cfUserId"].int64Value
        applyTime = decoder["applyTime"].int64Value
        if let tmp = decoder["status"].integer {
            status = CfUserCeritificationStatus(rawValue: tmp)
        }
        auditor = decoder["auditor"].uint64Value
        comment = decoder["comment"].string
        auditTime = decoder["auditTime"].int64Value
        name = decoder["name"].string
        school = decoder["school"].string
        if let decoderArray = decoder["pics"].array {
            pics = Array<CfUserCertPic>()
            for picDecoder in decoderArray {
                pics?.append(CfUserCertPic(picDecoder))
            }
        }
        hongId = decoder["hongId"].int64Value
    }
}


// 认证申请材料
struct CfUserCertPic: JSONJoy {
    var id: Int64?
    var cfUserCertApplyId: Int64?
    var url: String?
    init(_ decoder: JSONDecoder) {
        id = decoder["id"].int64Value
        cfUserCertApplyId = decoder["cfUserCertApplyId"].int64Value
        url = decoder["url"].string
    }
}


//------------------------------  筹么项目  ----------------------------

// 众筹项目
struct CfProject: JSONJoy {
    var id: Int64?
    // 标题
    var title: String?
    // 描述（255字符）
    var desc:String?
    // 联系人
    var contact:String?
    // 联系方式
    var tel: String?
    // 发起者
    var cfUserId: Int64?
    // 发起时间
    var fundTime: Int64?
    // 图片列表
    var pics: Array<CfProjectPic>?
    // 想筹集的钱(筹币)
    var requiredMoneyAmount: UInt64?
    // 想筹集的物品数量
    var requiredGoodsAmount: UInt64?
    // 想筹集的人数
    var requiredPeopleAmount: UInt64?
    // 募集的物品名称
    var requiredGoodsName: String?
    // 截止日期
    var deadline: Int64?
    // 众筹类别
    var category: CrowdFundingCategory?
    // 回报方式列表
    var rewards: Array<CfProjectReward>?
    var status: CfProjectStatus?
    // 收藏的用户
    var collectedUsers: Array<CfUser>?
    // 投资记录
    var invests: Array<CfProjectInvest>?
    // 聚合标签
    var tag: CfProjectTag?
    // 发起者hongid
    var hongId: UInt64?
    var auditTime: Int64?
    var auditer: UInt64?
    // 已筹的钱(筹币)
    var alreadyMoneyAmount: UInt64?
    // 已筹的物品数
    var alreadyGoodsAmount: UInt64?
    // 已筹的人数
    var alreadyPeopleAmount: UInt64?
    // 主要目标类型
    var majarType: CfProjectSupportType?
    // 学校code
    var school: String?
    // 校园合伙人-项目-融资额
    var requiredProjectAmount: UInt64?
    // 校园合伙人-项目-出让股份千分之n
    var requiredProjectEquity: UInt64?
    // 校园合伙人-项目-已筹集的股份
    var alreadyProjectEquity: UInt64?
    // 附加费统计
    var additionalCoin: UInt64?
    // 校园合伙人-产品-二次收益分配股权
    var secondProductEquity: UInt64?
    // 从哪个项目派生
    var parentProjectId: Int64?
    // 利润率  千分之n
    var profitRate: UInt64?
    init() {}
    init(_ decoder: JSONDecoder) {
        id = decoder["id"].int64Value
        title = decoder["title"].string
    }
}


// 支持方式
enum CfProjectSupportType: Int {
    case INVALID_CFPST = 0;
    // 钱
    case MONEY_CFPST = 1;
    // 人
    case PEOPLE_CFPST = 2;
    // 物
    case GOODS_CFPST = 3;
    func desc(count: UInt64) -> String {
        switch self {
        case .MONEY_CFPST: return String(count)+"元"
        case .PEOPLE_CFPST: return "人员"+String(count)+"名"
        case .GOODS_CFPST: return "物品"+String(count) + "件"
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
}

// 众筹项目投资记录
struct CfProjectInvest {
    var id: Int64?
    // 项目id
    var cfProjectId: Int64
    // 回报方式ID
    var cfProjectRewardId: Int64
    // 投资份数
    var count: UInt64
    // 投资时间
    var investTime: Int64
    // 用户
    var hongId: UInt64
    // 备注
    var comment: String
    // 地址id
    var addrId: Int64
    // 过期时间
    var expiredTime: Int64
    // 投资状态
    var status: CfProjectInvestStatus
    // 订单
    var orderId: String
    // // 应该支付的筹币数
    var coinPay: UInt64
}

// 回报方式
struct CfProjectReward {
    var id: Int64?
    // 回报描述(255字符)
    var desc: String?
    // 支持方式
    var supportType: CfProjectSupportType?
    // 支持数量(人/钱/物/股权), 股权支持为千分之n
    var amount: UInt64?
    // 限制份数
    var limitedCount: UInt64?
    // 项目id
    var CfProjectId: Int64?
    // 已经投资的份数
    var alreadyCount: UInt64?
    // 附加筹币
    var additionalCoin: UInt64?
    // 是否已被删除
    var del: Bool?
    init(){}
}

// 用户与项目的收藏关系 many to many
struct UsersCollectProjects {
    var id: Int64
    // 项目id
    var CfProjectId: Int64
    // 用户id
    var CfUserId:Int64
}

// 众筹项目图片
struct CfProjectPic {
    var id: Int64
    var cfProjectId: Int64
    var url: String
    // 是否已被删除
    var del: Bool
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
struct CFCBHistory {
    var id: Int64
    var type: CFCBHistoryType
    var coin: UInt64
    var  remain: UInt64
    var time: Int64
    var orderId: String
    var hongId: Int64
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
struct CfMessage {
    // 消息头
    var title: String
    // 时间
    var time: Int64
    // 消息类型
    var type: CfMessageType
    // 消息内容
    var content: String
}



//------------------------ ht ------------------------------

struct User: JSONJoy {
    var id: Int64?
    var hongId: Int64?
    var nick: String?
    var tel: String?
    var email: String?
    var password: String?
    var avatar: String?
    var age: Int?
    var sex: UserSex?
    var authority: UserAuthority?
    var status: UserStatus?
    var regTime: Int64?
    var genTime: Int64?
    var comment: String?
    var auditor: UInt64?
    init(){}
    init(_ decoder: JSONDecoder) {
        id = Int64(decoder["id"].integer!)
        hongId = Int64(decoder["hongId"].integer!)
        nick = decoder["nick"].string
        tel = decoder["tel"].string
        email = decoder["email"].string
        password = decoder["password"].string
        avatar = decoder["avatar"].string
        age = decoder["age"].integer
        if decoder["sex"].integer == nil {
            sex = UserSex.UNKNOWN_Sex
        }else{
            sex = UserSex(rawValue: decoder["sex"].integer!)
        }
        if decoder["authority"].integer == nil{
            authority = UserAuthority.USER
        }else{
            authority = UserAuthority(rawValue: decoder["authority"].integer!)
        }
        if decoder["status"].integer == nil {
            status = UserStatus.USE
        }else{
            status = UserStatus(rawValue: decoder["status"].integer!)
        }
        regTime = Int64(decoder["regTime"].integer!)
        genTime = Int64(decoder["genTime"].integer!)
        comment = decoder["comment"].string
    }
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
}

enum UserAuthority: Int {
    // 基本用户权限
    case USER  = 0;
    // 管理员权限
    case ADMIN = 1;
}