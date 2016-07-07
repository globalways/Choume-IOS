#import "User.sms.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"UserSMSService";

@implementation UserSMSService

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


#pragma mark SendSMS(SendSMSParam) returns (Response)

- (void)sendSMSWithRequest:(SendSMSParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToSendSMSWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToSendSMSWithRequest:(SendSMSParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"SendSMS"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark VarifySMSCode(VarifySMSCodeParam) returns (Response)

- (void)varifySMSCodeWithRequest:(VarifySMSCodeParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  [[self RPCToVarifySMSCodeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToVarifySMSCodeWithRequest:(VarifySMSCodeParam *)request handler:(void(^)(Response *response, NSError *error))handler{
  return [self RPCToMethod:@"VarifySMSCode"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Response class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
