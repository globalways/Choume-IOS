#import "User.app.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"UserAppService";

@implementation UserAppService

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
#pragma mark ChangePassword(ChangePasswordParam) returns (Response)

- (void)changePasswordWithRequest:(ChangePasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToChangePasswordWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToChangePasswordWithRequest:(ChangePasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"ChangePassword"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ForgetPassword(ForgetPasswordParam) returns (Response)

- (void)forgetPasswordWithRequest:(ForgetPasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToForgetPasswordWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToForgetPasswordWithRequest:(ForgetPasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"ForgetPassword"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ChangeUserAvatar(ChangeUserAvatarParam) returns (Response)

- (void)changeUserAvatarWithRequest:(ChangeUserAvatarParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToChangeUserAvatarWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToChangeUserAvatarWithRequest:(ChangeUserAvatarParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"ChangeUserAvatar"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ChangeUserNick(ChangeUserNickParam) returns (Response)

- (void)changeUserNickWithRequest:(ChangeUserNickParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToChangeUserNickWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToChangeUserNickWithRequest:(ChangeUserNickParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"ChangeUserNick"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ChangeUserSex(ChangeUserSexParam) returns (Response)

- (void)changeUserSexWithRequest:(ChangeUserSexParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToChangeUserSexWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToChangeUserSexWithRequest:(ChangeUserSexParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"ChangeUserSex"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NewUserAddr(NewUserAddrParam) returns (NewUserAddrResp)

- (void)newUserAddrWithRequest:(NewUserAddrParam *)request handler:(void(^)(NewUserAddrResp *response, NSError *error))handler{
  [[self RPCToNewUserAddrWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToNewUserAddrWithRequest:(NewUserAddrParam *)request handler:(void(^)(NewUserAddrResp *response, NSError *error))handler{
  return [self RPCToMethod:@"NewUserAddr"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NewUserAddrResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateUserAddrs(UpdateUserAddrsParam) returns (Response)

- (void)updateUserAddrsWithRequest:(UpdateUserAddrsParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToUpdateUserAddrsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUpdateUserAddrsWithRequest:(UpdateUserAddrsParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"UpdateUserAddrs"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DelUserAddr(DelUserAddrParam) returns (Response)

- (void)delUserAddrWithRequest:(DelUserAddrParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToDelUserAddrWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToDelUserAddrWithRequest:(DelUserAddrParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"DelUserAddr"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetUserAddr(GetUserAddrParam) returns (GetUserAddrResp)

- (void)getUserAddrWithRequest:(GetUserAddrParam *)request handler:(void(^)(GetUserAddrResp *response, NSError *error))handler{
  [[self RPCToGetUserAddrWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetUserAddrWithRequest:(GetUserAddrParam *)request handler:(void(^)(GetUserAddrResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetUserAddr"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetUserAddrResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetUser(GetUserParam) returns (GetUserResp)

- (void)getUserWithRequest:(GetUserParam *)request handler:(void(^)(GetUserResp *response, NSError *error))handler{
  [[self RPCToGetUserWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetUserWithRequest:(GetUserParam *)request handler:(void(^)(GetUserResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetUser"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetUserResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
