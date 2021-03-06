// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: user.wallet.proto

#import "GPBProtocolBuffers.h"

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30000
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

CF_EXTERN_C_BEGIN

@class PayDetail;
@class Response;
@class ThirdPartyWallet;
@class UserWallet;
@class UserWalletHistory;
GPB_ENUM_FWD_DECLARE(ThirdPartyWalletType);
GPB_ENUM_FWD_DECLARE(UserWalletHistoryType);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UserWalletRoot

@interface UserWalletRoot : GPBRootObject

// The base class provides:
//   + (GPBExtensionRegistry *)extensionRegistry;
// which is an GPBExtensionRegistry that includes all the extensions defined by
// this file and all files that it depends on.

@end

#pragma mark - GetPayDetailParam

typedef GPB_ENUM(GetPayDetailParam_FieldNumber) {
  GetPayDetailParam_FieldNumber_AppId = 1,
  GetPayDetailParam_FieldNumber_OrderNo = 2,
};

@interface GetPayDetailParam : GPBMessage

// appId
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

// 订单号
@property(nonatomic, readwrite, copy, null_resettable) NSString *orderNo;

@end

#pragma mark - GetPayDetailResp

typedef GPB_ENUM(GetPayDetailResp_FieldNumber) {
  GetPayDetailResp_FieldNumber_Resp = 1,
  GetPayDetailResp_FieldNumber_Detail = 2,
};

@interface GetPayDetailResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 支付详情
@property(nonatomic, readwrite) BOOL hasDetail;
@property(nonatomic, readwrite, strong, null_resettable) PayDetail *detail;

@end

#pragma mark - GetUserWalletParam

typedef GPB_ENUM(GetUserWalletParam_FieldNumber) {
  GetUserWalletParam_FieldNumber_Token = 1,
};

@interface GetUserWalletParam : GPBMessage

// 当前登录token, 只能获得自己的钱包
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

@end

#pragma mark - GetUserWalletResp

typedef GPB_ENUM(GetUserWalletResp_FieldNumber) {
  GetUserWalletResp_FieldNumber_Resp = 1,
  GetUserWalletResp_FieldNumber_Wallet = 2,
};

@interface GetUserWalletResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 用户钱包对象
@property(nonatomic, readwrite) BOOL hasWallet;
@property(nonatomic, readwrite, strong, null_resettable) UserWallet *wallet;

@end

#pragma mark - ListUserWalletHistoriesParam

typedef GPB_ENUM(ListUserWalletHistoriesParam_FieldNumber) {
  ListUserWalletHistoriesParam_FieldNumber_Token = 1,
  ListUserWalletHistoriesParam_FieldNumber_Type = 2,
  ListUserWalletHistoriesParam_FieldNumber_Start = 3,
  ListUserWalletHistoriesParam_FieldNumber_End = 4,
  ListUserWalletHistoriesParam_FieldNumber_Page = 5,
  ListUserWalletHistoriesParam_FieldNumber_Count = 6,
};

@interface ListUserWalletHistoriesParam : GPBMessage

// 当前登录token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 操作类型：消费、充值、提现等等
@property(nonatomic, readwrite) enum UserWalletHistoryType type;

// 开始时间
@property(nonatomic, readwrite) int64_t start;

// 结束时间
@property(nonatomic, readwrite) int64_t end;

// 第几页
@property(nonatomic, readwrite) int64_t page;

// 每页数量
@property(nonatomic, readwrite) int64_t count;

@end

int32_t ListUserWalletHistoriesParam_Type_RawValue(ListUserWalletHistoriesParam *message);
void SetListUserWalletHistoriesParam_Type_RawValue(ListUserWalletHistoriesParam *message, int32_t value);

#pragma mark - ListUserWalletHistoriesResp

typedef GPB_ENUM(ListUserWalletHistoriesResp_FieldNumber) {
  ListUserWalletHistoriesResp_FieldNumber_Resp = 1,
  ListUserWalletHistoriesResp_FieldNumber_HistoriesArray = 2,
};

@interface ListUserWalletHistoriesResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 钱包历史列表
// |historiesArray| contains |UserWalletHistory|
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray *historiesArray;
@property(nonatomic, readonly) NSUInteger historiesArray_Count;

@end

#pragma mark - PrepareUserWalletRechargeParam

typedef GPB_ENUM(PrepareUserWalletRechargeParam_FieldNumber) {
  PrepareUserWalletRechargeParam_FieldNumber_Token = 1,
  PrepareUserWalletRechargeParam_FieldNumber_Amount = 2,
  PrepareUserWalletRechargeParam_FieldNumber_AppId = 3,
};

@interface PrepareUserWalletRechargeParam : GPBMessage

// 用户登陆token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 充值额度，单位分
@property(nonatomic, readwrite) uint64_t amount;

// 来自哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

@end

#pragma mark - PrepareUserWalletRechargeResp

typedef GPB_ENUM(PrepareUserWalletRechargeResp_FieldNumber) {
  PrepareUserWalletRechargeResp_FieldNumber_Resp = 1,
  PrepareUserWalletRechargeResp_FieldNumber_History = 2,
};

@interface PrepareUserWalletRechargeResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 钱包支付历史
@property(nonatomic, readwrite) BOOL hasHistory;
@property(nonatomic, readwrite, strong, null_resettable) UserWalletHistory *history;

@end

#pragma mark - UserWalletPayParam

typedef GPB_ENUM(UserWalletPayParam_FieldNumber) {
  UserWalletPayParam_FieldNumber_AppId = 1,
  UserWalletPayParam_FieldNumber_OrderId = 2,
  UserWalletPayParam_FieldNumber_Subject = 3,
  UserWalletPayParam_FieldNumber_Body = 4,
  UserWalletPayParam_FieldNumber_Amount = 5,
  UserWalletPayParam_FieldNumber_Token = 6,
  UserWalletPayParam_FieldNumber_Password = 7,
};

@interface UserWalletPayParam : GPBMessage

// 哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

// 订单id
@property(nonatomic, readwrite, copy, null_resettable) NSString *orderId;

// 订单标题
@property(nonatomic, readwrite, copy, null_resettable) NSString *subject;

// 订单详情描述
@property(nonatomic, readwrite, copy, null_resettable) NSString *body;

// 订单额度，单位分
@property(nonatomic, readwrite) uint64_t amount;

// 用户登陆token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 用户密码，用作于支付密码
@property(nonatomic, readwrite, copy, null_resettable) NSString *password;

@end

#pragma mark - UserWalletPayResp

typedef GPB_ENUM(UserWalletPayResp_FieldNumber) {
  UserWalletPayResp_FieldNumber_Resp = 1,
  UserWalletPayResp_FieldNumber_History = 2,
};

@interface UserWalletPayResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 支付历史对象
@property(nonatomic, readwrite) BOOL hasHistory;
@property(nonatomic, readwrite, strong, null_resettable) UserWalletHistory *history;

@end

#pragma mark - ThirdPartyWalletBindParam

typedef GPB_ENUM(ThirdPartyWalletBindParam_FieldNumber) {
  ThirdPartyWalletBindParam_FieldNumber_Token = 1,
  ThirdPartyWalletBindParam_FieldNumber_Name = 2,
  ThirdPartyWalletBindParam_FieldNumber_Account = 3,
  ThirdPartyWalletBindParam_FieldNumber_Type = 4,
  ThirdPartyWalletBindParam_FieldNumber_AppId = 5,
};

@interface ThirdPartyWalletBindParam : GPBMessage

// 用户登陆token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 账户用户名
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

// 账号
@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

// 第三方钱包类型
@property(nonatomic, readwrite) enum ThirdPartyWalletType type;

// 哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

@end

int32_t ThirdPartyWalletBindParam_Type_RawValue(ThirdPartyWalletBindParam *message);
void SetThirdPartyWalletBindParam_Type_RawValue(ThirdPartyWalletBindParam *message, int32_t value);

#pragma mark - ThirdPartyWalletBindResp

typedef GPB_ENUM(ThirdPartyWalletBindResp_FieldNumber) {
  ThirdPartyWalletBindResp_FieldNumber_Resp = 1,
  ThirdPartyWalletBindResp_FieldNumber_ThirdPartyWallet = 2,
};

@interface ThirdPartyWalletBindResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 第三方钱包绑定对象
@property(nonatomic, readwrite) BOOL hasThirdPartyWallet;
@property(nonatomic, readwrite, strong, null_resettable) ThirdPartyWallet *thirdPartyWallet;

@end

#pragma mark - UserWalletWithdrawParam

typedef GPB_ENUM(UserWalletWithdrawParam_FieldNumber) {
  UserWalletWithdrawParam_FieldNumber_Token = 1,
  UserWalletWithdrawParam_FieldNumber_ThirdPartyWalletId = 2,
  UserWalletWithdrawParam_FieldNumber_Amount = 3,
  UserWalletWithdrawParam_FieldNumber_AppId = 4,
};

@interface UserWalletWithdrawParam : GPBMessage

// 用户登陆token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 第三方钱包id
@property(nonatomic, readwrite) int64_t thirdPartyWalletId;

// 提现金额，单位分
@property(nonatomic, readwrite) uint64_t amount;

// 哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

@end

#pragma mark - UserWalletWithdrawResp

typedef GPB_ENUM(UserWalletWithdrawResp_FieldNumber) {
  UserWalletWithdrawResp_FieldNumber_Resp = 1,
  UserWalletWithdrawResp_FieldNumber_History = 2,
};

@interface UserWalletWithdrawResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 提现申请产生的支付历史对象
@property(nonatomic, readwrite) BOOL hasHistory;
@property(nonatomic, readwrite, strong, null_resettable) UserWalletHistory *history;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

// @@protoc_insertion_point(global_scope)
