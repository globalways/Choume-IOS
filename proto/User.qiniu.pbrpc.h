#import "User.qiniu.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "Common.pbobjc.h"

@protocol QiniuService <NSObject>

#pragma mark Ping(NullRpcRequest) returns (Response)

- (void)pingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;

- (ProtoRPC *)RPCToPingWithRequest:(NullRpcRequest *)request handler:(void(^)(Response *response, NSError *error))handler;


#pragma mark MakeUpToken(MakeQiniuUpTokenParam) returns (MakeQiniuUpTokenResp)

- (void)makeUpTokenWithRequest:(MakeQiniuUpTokenParam *)request handler:(void(^)(MakeQiniuUpTokenResp *response, NSError *error))handler;

- (ProtoRPC *)RPCToMakeUpTokenWithRequest:(MakeQiniuUpTokenParam *)request handler:(void(^)(MakeQiniuUpTokenResp *response, NSError *error))handler;


@end

// Basic service implementation, over gRPC, that only does marshalling and parsing.
@interface QiniuService : ProtoService<QiniuService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
