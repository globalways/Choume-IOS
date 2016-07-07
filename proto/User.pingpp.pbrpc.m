#import "User.pingpp.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"UserPingppService";

@implementation UserPingppService

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


#pragma mark PingppCharge(PingppChargeParam) returns (PingppChargeResp)

- (void)pingppChargeWithRequest:(PingppChargeParam *)request handler:(void(^)(PingppChargeResp *response, NSError *error))handler{
  [[self RPCToPingppChargeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToPingppChargeWithRequest:(PingppChargeParam *)request handler:(void(^)(PingppChargeResp *response, NSError *error))handler{
  return [self RPCToMethod:@"PingppCharge"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PingppChargeResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
