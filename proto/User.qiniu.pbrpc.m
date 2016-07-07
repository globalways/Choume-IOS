#import "User.qiniu.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

static NSString *const kPackageName = @"proto";
static NSString *const kServiceName = @"QiniuService";

@implementation QiniuService

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
#pragma mark MakeUpToken(MakeQiniuUpTokenParam) returns (MakeQiniuUpTokenResp)

- (void)makeUpTokenWithRequest:(MakeQiniuUpTokenParam *)request handler:(void(^)(MakeQiniuUpTokenResp *response, NSError *error))handler{
  [[self RPCToMakeUpTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (ProtoRPC *)RPCToMakeUpTokenWithRequest:(MakeQiniuUpTokenParam *)request handler:(void(^)(MakeQiniuUpTokenResp *response, NSError *error))handler{
  return [self RPCToMethod:@"MakeUpToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[MakeQiniuUpTokenResp class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
