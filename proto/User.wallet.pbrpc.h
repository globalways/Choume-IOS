#import "User.wallet.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"
#import "User.wallet.common.pbobjc.h"

@protocol UserWalletService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark GetUserWallet(GetUserWalletParam) returns (GetUserWalletResp)

- (void)getUserWalletWithRequest:(GetUserWalletParam *)request handler:(void(^)(GetUserWalletResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetUserWalletWithRequest:(GetUserWalletParam *)request handler:(void(^)(GetUserWalletResp *response, NSError *error))handler;


#pragma mark ListUserWalletHistories(ListUserWalletHistoriesParam) returns (ListUserWalletHistoriesResp)

- (void)listUserWalletHistoriesWithRequest:(ListUserWalletHistoriesParam *)request handler:(void(^)(ListUserWalletHistoriesResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToListUserWalletHistoriesWithRequest:(ListUserWalletHistoriesParam *)request handler:(void(^)(ListUserWalletHistoriesResp *response, NSError *error))handler;


#pragma mark PrepareUserWalletRecharge(PrepareUserWalletRechargeParam) returns (PrepareUserWalletRechargeResp)

- (void)prepareUserWalletRechargeWithRequest:(PrepareUserWalletRechargeParam *)request handler:(void(^)(PrepareUserWalletRechargeResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToPrepareUserWalletRechargeWithRequest:(PrepareUserWalletRechargeParam *)request handler:(void(^)(PrepareUserWalletRechargeResp *response, NSError *error))handler;


#pragma mark UserWalletPay(UserWalletPayParam) returns (UserWalletPayResp)

- (void)userWalletPayWithRequest:(UserWalletPayParam *)request handler:(void(^)(UserWalletPayResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToUserWalletPayWithRequest:(UserWalletPayParam *)request handler:(void(^)(UserWalletPayResp *response, NSError *error))handler;


#pragma mark ThirdPartyWalletBind(ThirdPartyWalletBindParam) returns (ThirdPartyWalletBindResp)

- (void)thirdPartyWalletBindWithRequest:(ThirdPartyWalletBindParam *)request handler:(void(^)(ThirdPartyWalletBindResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToThirdPartyWalletBindWithRequest:(ThirdPartyWalletBindParam *)request handler:(void(^)(ThirdPartyWalletBindResp *response, NSError *error))handler;


#pragma mark UserWalletWithdraw(UserWalletWithdrawParam) returns (UserWalletWithdrawResp)

- (void)userWalletWithdrawWithRequest:(UserWalletWithdrawParam *)request handler:(void(^)(UserWalletWithdrawResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToUserWalletWithdrawWithRequest:(UserWalletWithdrawParam *)request handler:(void(^)(UserWalletWithdrawResp *response, NSError *error))handler;


#pragma mark GetPayDetail(GetPayDetailParam) returns (GetPayDetailResp)

- (void)getPayDetailWithRequest:(GetPayDetailParam *)request handler:(void(^)(GetPayDetailResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetPayDetailWithRequest:(GetPayDetailParam *)request handler:(void(^)(GetPayDetailResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface UserWalletService : ProtoService<UserWalletService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
