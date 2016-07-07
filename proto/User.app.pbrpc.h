#import "User.app.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"
#import "User.common.pbobjc.h"

@protocol UserAppService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark ChangePassword(ChangePasswordParam) returns (Response)

- (void)changePasswordWithRequest:(ChangePasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToChangePasswordWithRequest:(ChangePasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark ForgetPassword(ForgetPasswordParam) returns (Response)

- (void)forgetPasswordWithRequest:(ForgetPasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToForgetPasswordWithRequest:(ForgetPasswordParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark ChangeUserAvatar(ChangeUserAvatarParam) returns (Response)

- (void)changeUserAvatarWithRequest:(ChangeUserAvatarParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToChangeUserAvatarWithRequest:(ChangeUserAvatarParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark ChangeUserNick(ChangeUserNickParam) returns (Response)

- (void)changeUserNickWithRequest:(ChangeUserNickParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToChangeUserNickWithRequest:(ChangeUserNickParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark ChangeUserSex(ChangeUserSexParam) returns (Response)

- (void)changeUserSexWithRequest:(ChangeUserSexParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToChangeUserSexWithRequest:(ChangeUserSexParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark NewUserAddr(NewUserAddrParam) returns (NewUserAddrResp)

- (void)newUserAddrWithRequest:(NewUserAddrParam *)request handler:(void(^)(NewUserAddrResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToNewUserAddrWithRequest:(NewUserAddrParam *)request handler:(void(^)(NewUserAddrResp *response, NSError *error))handler;


#pragma mark UpdateUserAddrs(UpdateUserAddrsParam) returns (Response)

- (void)updateUserAddrsWithRequest:(UpdateUserAddrsParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToUpdateUserAddrsWithRequest:(UpdateUserAddrsParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark DelUserAddr(DelUserAddrParam) returns (Response)

- (void)delUserAddrWithRequest:(DelUserAddrParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToDelUserAddrWithRequest:(DelUserAddrParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark GetUserAddr(GetUserAddrParam) returns (GetUserAddrResp)

- (void)getUserAddrWithRequest:(GetUserAddrParam *)request handler:(void(^)(GetUserAddrResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetUserAddrWithRequest:(GetUserAddrParam *)request handler:(void(^)(GetUserAddrResp *response, NSError *error))handler;


#pragma mark GetUser(GetUserParam) returns (GetUserResp)

- (void)getUserWithRequest:(GetUserParam *)request handler:(void(^)(GetUserResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetUserWithRequest:(GetUserParam *)request handler:(void(^)(GetUserResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface UserAppService : ProtoService<UserAppService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
