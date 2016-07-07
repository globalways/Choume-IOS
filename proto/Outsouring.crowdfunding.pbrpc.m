#import "Outsouring.crowdfunding.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"CFAppUserService";

@implementation CFAppUserService

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
#pragma mark RegisterAppUser(RegisterAppUserParam) returns (RegisterCFAppUserResp)

- (void)registerAppUserWithRequest:(RegisterAppUserParam *)request handler:(void(^)(RegisterCFAppUserResp *response, NSError *error))handler{
  [[self RPCToRegisterAppUserWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToRegisterAppUserWithRequest:(RegisterAppUserParam *)request handler:(void(^)(RegisterCFAppUserResp *response, NSError *error))handler{
  return [self RPCToMethod:@"RegisterAppUser"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RegisterCFAppUserResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LoginApp(LoginAppParam) returns (LoginCFAppResp)

- (void)loginAppWithRequest:(LoginAppParam *)request handler:(void(^)(LoginCFAppResp *response, NSError *error))handler{
  [[self RPCToLoginAppWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToLoginAppWithRequest:(LoginAppParam *)request handler:(void(^)(LoginCFAppResp *response, NSError *error))handler{
  return [self RPCToMethod:@"LoginApp"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LoginCFAppResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LogoutApp(LogoutParam) returns (Response)

- (void)logoutAppWithRequest:(LogoutParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToLogoutAppWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToLogoutAppWithRequest:(LogoutParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"LogoutApp"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateAppUser(UpdateCFUserParam) returns (UpdateCFUserResp)

- (void)updateAppUserWithRequest:(UpdateCFUserParam *)request handler:(void(^)(UpdateCFUserResp *response, NSError *error))handler{
  [[self RPCToUpdateAppUserWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUpdateAppUserWithRequest:(UpdateCFUserParam *)request handler:(void(^)(UpdateCFUserResp *response, NSError *error))handler{
  return [self RPCToMethod:@"UpdateAppUser"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateCFUserResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAppUser(GetAppUserParam) returns (GetCFUserResp)

- (void)getAppUserWithRequest:(GetAppUserParam *)request handler:(void(^)(GetCFUserResp *response, NSError *error))handler{
  [[self RPCToGetAppUserWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetAppUserWithRequest:(GetAppUserParam *)request handler:(void(^)(GetCFUserResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetAppUser"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetCFUserResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UserCertApply(UserCertApplyParam) returns (UserCertApplyResp)

- (void)userCertApplyWithRequest:(UserCertApplyParam *)request handler:(void(^)(UserCertApplyResp *response, NSError *error))handler{
  [[self RPCToUserCertApplyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUserCertApplyWithRequest:(UserCertApplyParam *)request handler:(void(^)(UserCertApplyResp *response, NSError *error))handler{
  return [self RPCToMethod:@"UserCertApply"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UserCertApplyResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UserCollectProject(UserCollectProjectParam) returns (Response)

- (void)userCollectProjectWithRequest:(UserCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToUserCollectProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUserCollectProjectWithRequest:(UserCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"UserCollectProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UserUnCollectProject(UserUnCollectProjectParam) returns (Response)

- (void)userUnCollectProjectWithRequest:(UserUnCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToUserUnCollectProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUserUnCollectProjectWithRequest:(UserUnCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"UserUnCollectProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetRCCFUserToken(GetRCCFUserTokenParam) returns (GetRCCFUserTokenResp)

- (void)getRCCFUserTokenWithRequest:(GetRCCFUserTokenParam *)request handler:(void(^)(GetRCCFUserTokenResp *response, NSError *error))handler{
  [[self RPCToGetRCCFUserTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetRCCFUserTokenWithRequest:(GetRCCFUserTokenParam *)request handler:(void(^)(GetRCCFUserTokenResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetRCCFUserToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetRCCFUserTokenResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CfUserCBConsume(CfUserCBConsumeParam) returns (CfUserCBConsumeResp)

- (void)cfUserCBConsumeWithRequest:(CfUserCBConsumeParam *)request handler:(void(^)(CfUserCBConsumeResp *response, NSError *error))handler{
  [[self RPCToCfUserCBConsumeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCfUserCBConsumeWithRequest:(CfUserCBConsumeParam *)request handler:(void(^)(CfUserCBConsumeResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CfUserCBConsume"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfUserCBConsumeResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CfUserCBExchange(CfUserCBExchangeParam) returns (CfUserCBExchangeResp)

- (void)cfUserCBExchangeWithRequest:(CfUserCBExchangeParam *)request handler:(void(^)(CfUserCBExchangeResp *response, NSError *error))handler{
  [[self RPCToCfUserCBExchangeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCfUserCBExchangeWithRequest:(CfUserCBExchangeParam *)request handler:(void(^)(CfUserCBExchangeResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CfUserCBExchange"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfUserCBExchangeResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CfUserWithdraw(CfUserWithdrawParam) returns (CfUserWithdrawResp)

- (void)cfUserWithdrawWithRequest:(CfUserWithdrawParam *)request handler:(void(^)(CfUserWithdrawResp *response, NSError *error))handler{
  [[self RPCToCfUserWithdrawWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCfUserWithdrawWithRequest:(CfUserWithdrawParam *)request handler:(void(^)(CfUserWithdrawResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CfUserWithdraw"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfUserWithdrawResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CfUserHistories(CfUserHistoriesParam) returns (CfUserHistoriesResp)

- (void)cfUserHistoriesWithRequest:(CfUserHistoriesParam *)request handler:(void(^)(CfUserHistoriesResp *response, NSError *error))handler{
  [[self RPCToCfUserHistoriesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCfUserHistoriesWithRequest:(CfUserHistoriesParam *)request handler:(void(^)(CfUserHistoriesResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CfUserHistories"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfUserHistoriesResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"CfProjectService";

@implementation CfProjectService

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
#pragma mark RaiseCfProject(RaiseCfProjectParam) returns (RaiseCfProjectResp)

- (void)raiseCfProjectWithRequest:(RaiseCfProjectParam *)request handler:(void(^)(RaiseCfProjectResp *response, NSError *error))handler{
  [[self RPCToRaiseCfProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToRaiseCfProjectWithRequest:(RaiseCfProjectParam *)request handler:(void(^)(RaiseCfProjectResp *response, NSError *error))handler{
  return [self RPCToMethod:@"RaiseCfProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RaiseCfProjectResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark FindCfProjects(FindCfProjectsParam) returns (FindCfProjectsResp)

- (void)findCfProjectsWithRequest:(FindCfProjectsParam *)request handler:(void(^)(FindCfProjectsResp *response, NSError *error))handler{
  [[self RPCToFindCfProjectsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToFindCfProjectsWithRequest:(FindCfProjectsParam *)request handler:(void(^)(FindCfProjectsResp *response, NSError *error))handler{
  return [self RPCToMethod:@"FindCfProjects"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FindCfProjectsResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetCfProject(GetCfProjectParam) returns (GetCfProjectResp)

- (void)getCfProjectWithRequest:(GetCfProjectParam *)request handler:(void(^)(GetCfProjectResp *response, NSError *error))handler{
  [[self RPCToGetCfProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToGetCfProjectWithRequest:(GetCfProjectParam *)request handler:(void(^)(GetCfProjectResp *response, NSError *error))handler{
  return [self RPCToMethod:@"GetCfProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetCfProjectResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CloseCfProject(CloseCfProjectParam) returns (CloseCfProjectResp)

- (void)closeCfProjectWithRequest:(CloseCfProjectParam *)request handler:(void(^)(CloseCfProjectResp *response, NSError *error))handler{
  [[self RPCToCloseCfProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCloseCfProjectWithRequest:(CloseCfProjectParam *)request handler:(void(^)(CloseCfProjectResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CloseCfProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CloseCfProjectResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateCfProject(UpdateCfProjectParam) returns (UpdateCfProjectResp)

- (void)updateCfProjectWithRequest:(UpdateCfProjectParam *)request handler:(void(^)(UpdateCfProjectResp *response, NSError *error))handler{
  [[self RPCToUpdateCfProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToUpdateCfProjectWithRequest:(UpdateCfProjectParam *)request handler:(void(^)(UpdateCfProjectResp *response, NSError *error))handler{
  return [self RPCToMethod:@"UpdateCfProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateCfProjectResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NewCfProjectInvest(NewCfProjectInvestParam) returns (NewCfProjectInvestResp)

- (void)newCfProjectInvestWithRequest:(NewCfProjectInvestParam *)request handler:(void(^)(NewCfProjectInvestResp *response, NSError *error))handler{
  [[self RPCToNewCfProjectInvestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToNewCfProjectInvestWithRequest:(NewCfProjectInvestParam *)request handler:(void(^)(NewCfProjectInvestResp *response, NSError *error))handler{
  return [self RPCToMethod:@"NewCfProjectInvest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NewCfProjectInvestResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark PassCfProjectInvest(PassCfProjectInvestParam) returns (Response)

- (void)passCfProjectInvestWithRequest:(PassCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToPassCfProjectInvestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToPassCfProjectInvestWithRequest:(PassCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"PassCfProjectInvest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RejectCfProjectInvest(RejectCfProjectInvestParam) returns (Response)

- (void)rejectCfProjectInvestWithRequest:(RejectCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToRejectCfProjectInvestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToRejectCfProjectInvestWithRequest:(RejectCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"RejectCfProjectInvest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NewCfProjectComment(CfProjectCommentParam) returns (CfProjectCommentResp)

- (void)newCfProjectCommentWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler{
  [[self RPCToNewCfProjectCommentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToNewCfProjectCommentWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler{
  return [self RPCToMethod:@"NewCfProjectComment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfProjectCommentResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CfProjectComments(CfProjectCommentParam) returns (CfProjectCommentResp)

- (void)cfProjectCommentsWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler{
  [[self RPCToCfProjectCommentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToCfProjectCommentsWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler{
  return [self RPCToMethod:@"CfProjectComments"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CfProjectCommentResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"CfAdminService";

@implementation CfAdminService

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
#pragma mark FindCfUserCertApplyList(FindCfUserCertApplyListParam) returns (FindCfUserCertApplyListResp)

- (void)findCfUserCertApplyListWithRequest:(FindCfUserCertApplyListParam *)request handler:(void(^)(FindCfUserCertApplyListResp *response, NSError *error))handler{
  [[self RPCToFindCfUserCertApplyListWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToFindCfUserCertApplyListWithRequest:(FindCfUserCertApplyListParam *)request handler:(void(^)(FindCfUserCertApplyListResp *response, NSError *error))handler{
  return [self RPCToMethod:@"FindCfUserCertApplyList"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FindCfUserCertApplyListResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark PassCfUserCertApply(PassCfUserCertApplyParam) returns (Response)

- (void)passCfUserCertApplyWithRequest:(PassCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToPassCfUserCertApplyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToPassCfUserCertApplyWithRequest:(PassCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"PassCfUserCertApply"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RejectCfUserCertApply(RejectCfUserCertApplyParam) returns (Response)

- (void)rejectCfUserCertApplyWithRequest:(RejectCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToRejectCfUserCertApplyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToRejectCfUserCertApplyWithRequest:(RejectCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"RejectCfUserCertApply"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark FindCfUsers(FindCfUsersParam) returns (FindCfUsersResp)

- (void)findCfUsersWithRequest:(FindCfUsersParam *)request handler:(void(^)(FindCfUsersResp *response, NSError *error))handler{
  [[self RPCToFindCfUsersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToFindCfUsersWithRequest:(FindCfUsersParam *)request handler:(void(^)(FindCfUsersResp *response, NSError *error))handler{
  return [self RPCToMethod:@"FindCfUsers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FindCfUsersResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark AuditCfProject(AuditCfProjectParam) returns (Response)

- (void)auditCfProjectWithRequest:(AuditCfProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToAuditCfProjectWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToAuditCfProjectWithRequest:(AuditCfProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"AuditCfProject"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
