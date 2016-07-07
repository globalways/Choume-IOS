#import "User.sms.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"

@protocol UserSMSService <NSObject>

#pragma mark SendSMS(SendSMSParam) returns (Response)

- (void)sendSMSWithRequest:(SendSMSParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToSendSMSWithRequest:(SendSMSParam *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark VarifySMSCode(VarifySMSCodeParam) returns (Response)

- (void)varifySMSCodeWithRequest:(VarifySMSCodeParam *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToVarifySMSCodeWithRequest:(VarifySMSCodeParam *)request handler:(void(^)(Response *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface UserSMSService : ProtoService<UserSMSService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
