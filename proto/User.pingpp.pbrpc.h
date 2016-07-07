#import "User.pingpp.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"

@protocol UserPingppService <NSObject>

#pragma mark PingppCharge(PingppChargeParam) returns (PingppChargeResp)

- (void)pingppChargeWithRequest:(PingppChargeParam *)request handler:(void(^)(PingppChargeResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingppChargeWithRequest:(PingppChargeParam *)request handler:(void(^)(PingppChargeResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface UserPingppService : ProtoService<UserPingppService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
