// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: user.qiniu.proto

#import "GPBProtocolBuffers.h"

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30000
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

CF_EXTERN_C_BEGIN

@class QiniuUpToken;
@class Response;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UserQiniuRoot

@interface UserQiniuRoot : GPBRootObject

// The base class provides:
//   + (GPBExtensionRegistry *)extensionRegistry;
// which is an GPBExtensionRegistry that includes all the extensions defined by
// this file and all files that it depends on.

@end

#pragma mark - MakeQiniuUpTokenParam

typedef GPB_ENUM(MakeQiniuUpTokenParam_FieldNumber) {
  MakeQiniuUpTokenParam_FieldNumber_Token = 1,
  MakeQiniuUpTokenParam_FieldNumber_AppId = 2,
  MakeQiniuUpTokenParam_FieldNumber_Bucket = 3,
  MakeQiniuUpTokenParam_FieldNumber_Key = 4,
};

@interface MakeQiniuUpTokenParam : GPBMessage

// 用户token
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

// 哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

// 七牛文件夹
@property(nonatomic, readwrite, copy, null_resettable) NSString *bucket;

// 文件的key，可选
@property(nonatomic, readwrite, copy, null_resettable) NSString *key;

@end

#pragma mark - MakeQiniuUpTokenResp

typedef GPB_ENUM(MakeQiniuUpTokenResp_FieldNumber) {
  MakeQiniuUpTokenResp_FieldNumber_Resp = 1,
  MakeQiniuUpTokenResp_FieldNumber_UpToken = 2,
};

@interface MakeQiniuUpTokenResp : GPBMessage

@property(nonatomic, readwrite) BOOL hasResp;
@property(nonatomic, readwrite, strong, null_resettable) Response *resp;

// 上传凭证
@property(nonatomic, readwrite) BOOL hasUpToken;
@property(nonatomic, readwrite, strong, null_resettable) QiniuUpToken *upToken;

@end

#pragma mark - QiniuUpToken

typedef GPB_ENUM(QiniuUpToken_FieldNumber) {
  QiniuUpToken_FieldNumber_Uptoken = 1,
  QiniuUpToken_FieldNumber_Domain = 2,
};

@interface QiniuUpToken : GPBMessage

// 上传token
@property(nonatomic, readwrite, copy, null_resettable) NSString *uptoken;

// 图片的根域名，上传成功后将domain与key结合，合成完整url存到app服务器
@property(nonatomic, readwrite, copy, null_resettable) NSString *domain;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

// @@protoc_insertion_point(global_scope)