#import "User.wallet.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"UserWalletService";

@implementation UserWalletService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:kPackageName serviceName:kServiceName]);
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}


#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToPingWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"Ping"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetUserWallet(GetUserWalletParam) returns (GetUserWalletResp)

- (void)getUserWalletWithRequest:(GetUserWalletParam *)request handler:(void(^)(GetUserWalletResp *response, NSError *error))handler{
  [[self RPCToGetUserWalletWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetUserWalletWithRequest:(GetUserWalletParam *)request handler:(void(^)(GetUserWalletResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetUserWallet"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetUserWalletResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ListUserWalletHistories(ListUserWalletHistoriesParam) returns (ListUserWalletHistoriesResp)

- (void)listUserWalletHistoriesWithRequest:(ListUserWalletHistoriesParam *)request handler:(void(^)(ListUserWalletHistoriesResp *response, NSError *error))handler{
  [[self RPCToListUserWalletHistoriesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToListUserWalletHistoriesWithRequest:(ListUserWalletHistoriesParam *)request handler:(void(^)(ListUserWalletHistoriesResp *response, NSError *error))handler{
  return [self RPCToMethod:@"ListUserWalletHistories"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListUserWalletHistoriesResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark PrepareUserWalletRecharge(PrepareUserWalletRechargeParam) returns (PrepareUserWalletRechargeResp)

- (void)prepareUserWalletRechargeWithRequest:(PrepareUserWalletRechargeParam *)request handler:(void(^)(PrepareUserWalletRechargeResp *response, NSError *error))handler{
  [[self RPCToPrepareUserWalletRechargeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToPrepareUserWalletRechargeWithRequest:(PrepareUserWalletRechargeParam *)request handler:(void(^)(PrepareUserWalletRechargeResp *response, NSError *error))handler{
  return [self RPCToMethod:@"PrepareUserWalletRecharge"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PrepareUserWalletRechargeResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UserWalletPay(UserWalletPayParam) returns (UserWalletPayResp)

- (void)userWalletPayWithRequest:(UserWalletPayParam *)request handler:(void(^)(UserWalletPayResp *response, NSError *error))handler{
  [[self RPCToUserWalletPayWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUserWalletPayWithRequest:(UserWalletPayParam *)request handler:(void(^)(UserWalletPayResp *response, NSError *error))handler{
  return [self RPCToMethod:@"UserWalletPay"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UserWalletPayResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ThirdPartyWalletBind(ThirdPartyWalletBindParam) returns (ThirdPartyWalletBindResp)

- (void)thirdPartyWalletBindWithRequest:(ThirdPartyWalletBindParam *)request handler:(void(^)(ThirdPartyWalletBindResp *response, NSError *error))handler{
  [[self RPCToThirdPartyWalletBindWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToThirdPartyWalletBindWithRequest:(ThirdPartyWalletBindParam *)request handler:(void(^)(ThirdPartyWalletBindResp *response, NSError *error))handler{
  return [self RPCToMethod:@"ThirdPartyWalletBind"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ThirdPartyWalletBindResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UserWalletWithdraw(UserWalletWithdrawParam) returns (UserWalletWithdrawResp)

- (void)userWalletWithdrawWithRequest:(UserWalletWithdrawParam *)request handler:(void(^)(UserWalletWithdrawResp *response, NSError *error))handler{
  [[self RPCToUserWalletWithdrawWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUserWalletWithdrawWithRequest:(UserWalletWithdrawParam *)request handler:(void(^)(UserWalletWithdrawResp *response, NSError *error))handler{
  return [self RPCToMethod:@"UserWalletWithdraw"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UserWalletWithdrawResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPayDetail(GetPayDetailParam) returns (GetPayDetailResp)

- (void)getPayDetailWithRequest:(GetPayDetailParam *)request handler:(void(^)(GetPayDetailResp *response, NSError *error))handler{
  [[self RPCToGetPayDetailWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetPayDetailWithRequest:(GetPayDetailParam *)request handler:(void(^)(GetPayDetailResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetPayDetail"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPayDetailResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
