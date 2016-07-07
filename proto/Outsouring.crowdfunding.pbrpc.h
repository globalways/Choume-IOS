#import "Outsouring.crowdfunding.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"
#import "User.common.pbobjc.h"

@protocol CFAppUserService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark RegisterAppUser(RegisterAppUserParam) returns (RegisterCFAppUserResp)

- (void)registerAppUserWithRequest:(RegisterAppUserParam *)request handler:(void(^)(RegisterCFAppUserResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToRegisterAppUserWithRequest:(RegisterAppUserParam *)request handler:(void(^)(RegisterCFAppUserResp *response, NSError *error))handler;


#pragma mark LoginApp(LoginAppParam) returns (LoginCFAppResp)

- (void)loginAppWithRequest:(LoginAppParam *)request handler:(void(^)(LoginCFAppResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToLoginAppWithRequest:(LoginAppParam *)request handler:(void(^)(LoginCFAppResp *response, NSError *error))handler;


#pragma mark LogoutApp(LogoutParam) returns (Response)

- (void)logoutAppWithRequest:(LogoutParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToLogoutAppWithRequest:(LogoutParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark UpdateAppUser(UpdateCFUserParam) returns (UpdateCFUserResp)

- (void)updateAppUserWithRequest:(UpdateCFUserParam *)request handler:(void(^)(UpdateCFUserResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToUpdateAppUserWithRequest:(UpdateCFUserParam *)request handler:(void(^)(UpdateCFUserResp *response, NSError *error))handler;


#pragma mark GetAppUser(GetAppUserParam) returns (GetCFUserResp)

- (void)getAppUserWithRequest:(GetAppUserParam *)request handler:(void(^)(GetCFUserResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetAppUserWithRequest:(GetAppUserParam *)request handler:(void(^)(GetCFUserResp *response, NSError *error))handler;


#pragma mark UserCertApply(UserCertApplyParam) returns (UserCertApplyResp)

- (void)userCertApplyWithRequest:(UserCertApplyParam *)request handler:(void(^)(UserCertApplyResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToUserCertApplyWithRequest:(UserCertApplyParam *)request handler:(void(^)(UserCertApplyResp *response, NSError *error))handler;


#pragma mark UserCollectProject(UserCollectProjectParam) returns (Response)

- (void)userCollectProjectWithRequest:(UserCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToUserCollectProjectWithRequest:(UserCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark UserUnCollectProject(UserUnCollectProjectParam) returns (Response)

- (void)userUnCollectProjectWithRequest:(UserUnCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToUserUnCollectProjectWithRequest:(UserUnCollectProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark GetRCCFUserToken(GetRCCFUserTokenParam) returns (GetRCCFUserTokenResp)

- (void)getRCCFUserTokenWithRequest:(GetRCCFUserTokenParam *)request handler:(void(^)(GetRCCFUserTokenResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetRCCFUserTokenWithRequest:(GetRCCFUserTokenParam *)request handler:(void(^)(GetRCCFUserTokenResp *response, NSError *error))handler;


#pragma mark CfUserCBConsume(CfUserCBConsumeParam) returns (CfUserCBConsumeResp)

- (void)cfUserCBConsumeWithRequest:(CfUserCBConsumeParam *)request handler:(void(^)(CfUserCBConsumeResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCfUserCBConsumeWithRequest:(CfUserCBConsumeParam *)request handler:(void(^)(CfUserCBConsumeResp *response, NSError *error))handler;


#pragma mark CfUserCBExchange(CfUserCBExchangeParam) returns (CfUserCBExchangeResp)

- (void)cfUserCBExchangeWithRequest:(CfUserCBExchangeParam *)request handler:(void(^)(CfUserCBExchangeResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCfUserCBExchangeWithRequest:(CfUserCBExchangeParam *)request handler:(void(^)(CfUserCBExchangeResp *response, NSError *error))handler;


#pragma mark CfUserWithdraw(CfUserWithdrawParam) returns (CfUserWithdrawResp)

- (void)cfUserWithdrawWithRequest:(CfUserWithdrawParam *)request handler:(void(^)(CfUserWithdrawResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCfUserWithdrawWithRequest:(CfUserWithdrawParam *)request handler:(void(^)(CfUserWithdrawResp *response, NSError *error))handler;


#pragma mark CfUserHistories(CfUserHistoriesParam) returns (CfUserHistoriesResp)

- (void)cfUserHistoriesWithRequest:(CfUserHistoriesParam *)request handler:(void(^)(CfUserHistoriesResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCfUserHistoriesWithRequest:(CfUserHistoriesParam *)request handler:(void(^)(CfUserHistoriesResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface CFAppUserService : ProtoService<CFAppUserService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
@protocol CfProjectService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark RaiseCfProject(RaiseCfProjectParam) returns (RaiseCfProjectResp)

- (void)raiseCfProjectWithRequest:(RaiseCfProjectParam *)request handler:(void(^)(RaiseCfProjectResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToRaiseCfProjectWithRequest:(RaiseCfProjectParam *)request handler:(void(^)(RaiseCfProjectResp *response, NSError *error))handler;


#pragma mark FindCfProjects(FindCfProjectsParam) returns (FindCfProjectsResp)

- (void)findCfProjectsWithRequest:(FindCfProjectsParam *)request handler:(void(^)(FindCfProjectsResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToFindCfProjectsWithRequest:(FindCfProjectsParam *)request handler:(void(^)(FindCfProjectsResp *response, NSError *error))handler;


#pragma mark GetCfProject(GetCfProjectParam) returns (GetCfProjectResp)

- (void)getCfProjectWithRequest:(GetCfProjectParam *)request handler:(void(^)(GetCfProjectResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToGetCfProjectWithRequest:(GetCfProjectParam *)request handler:(void(^)(GetCfProjectResp *response, NSError *error))handler;


#pragma mark CloseCfProject(CloseCfProjectParam) returns (CloseCfProjectResp)

- (void)closeCfProjectWithRequest:(CloseCfProjectParam *)request handler:(void(^)(CloseCfProjectResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCloseCfProjectWithRequest:(CloseCfProjectParam *)request handler:(void(^)(CloseCfProjectResp *response, NSError *error))handler;


#pragma mark UpdateCfProject(UpdateCfProjectParam) returns (UpdateCfProjectResp)

- (void)updateCfProjectWithRequest:(UpdateCfProjectParam *)request handler:(void(^)(UpdateCfProjectResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToUpdateCfProjectWithRequest:(UpdateCfProjectParam *)request handler:(void(^)(UpdateCfProjectResp *response, NSError *error))handler;


#pragma mark NewCfProjectInvest(NewCfProjectInvestParam) returns (NewCfProjectInvestResp)

- (void)newCfProjectInvestWithRequest:(NewCfProjectInvestParam *)request handler:(void(^)(NewCfProjectInvestResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToNewCfProjectInvestWithRequest:(NewCfProjectInvestParam *)request handler:(void(^)(NewCfProjectInvestResp *response, NSError *error))handler;


#pragma mark PassCfProjectInvest(PassCfProjectInvestParam) returns (Response)

- (void)passCfProjectInvestWithRequest:(PassCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPassCfProjectInvestWithRequest:(PassCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark RejectCfProjectInvest(RejectCfProjectInvestParam) returns (Response)

- (void)rejectCfProjectInvestWithRequest:(RejectCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToRejectCfProjectInvestWithRequest:(RejectCfProjectInvestParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark NewCfProjectComment(CfProjectCommentParam) returns (CfProjectCommentResp)

- (void)newCfProjectCommentWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToNewCfProjectCommentWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler;


#pragma mark CfProjectComments(CfProjectCommentParam) returns (CfProjectCommentResp)

- (void)cfProjectCommentsWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToCfProjectCommentsWithRequest:(CfProjectCommentParam *)request handler:(void(^)(CfProjectCommentResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface CfProjectService : ProtoService<CfProjectService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
@protocol CfAdminService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark FindCfUserCertApplyList(FindCfUserCertApplyListParam) returns (FindCfUserCertApplyListResp)

- (void)findCfUserCertApplyListWithRequest:(FindCfUserCertApplyListParam *)request handler:(void(^)(FindCfUserCertApplyListResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToFindCfUserCertApplyListWithRequest:(FindCfUserCertApplyListParam *)request handler:(void(^)(FindCfUserCertApplyListResp *response, NSError *error))handler;


#pragma mark PassCfUserCertApply(PassCfUserCertApplyParam) returns (Response)

- (void)passCfUserCertApplyWithRequest:(PassCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPassCfUserCertApplyWithRequest:(PassCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark RejectCfUserCertApply(RejectCfUserCertApplyParam) returns (Response)

- (void)rejectCfUserCertApplyWithRequest:(RejectCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToRejectCfUserCertApplyWithRequest:(RejectCfUserCertApplyParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark FindCfUsers(FindCfUsersParam) returns (FindCfUsersResp)

- (void)findCfUsersWithRequest:(FindCfUsersParam *)request handler:(void(^)(FindCfUsersResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToFindCfUsersWithRequest:(FindCfUsersParam *)request handler:(void(^)(FindCfUsersResp *response, NSError *error))handler;


#pragma mark AuditCfProject(AuditCfProjectParam) returns (Response)

- (void)auditCfProjectWithRequest:(AuditCfProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToAuditCfProjectWithRequest:(AuditCfProjectParam *)request handler:(void(^)(Response *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface CfAdminService : ProtoService<CfAdminService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
