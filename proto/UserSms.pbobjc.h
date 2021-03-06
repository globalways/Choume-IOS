// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: user.sms.proto

#import "GPBProtocolBuffers.h"

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30000
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum SMSType

typedef GPB_ENUM(SMSType) {
  SMSType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  SMSType_UnknownSms = 0,

  // 操作验证码
  SMSType_Varify = 1,
};

GPBEnumDescriptor *SMSType_EnumDescriptor(void);

BOOL SMSType_IsValidValue(int32_t value);

#pragma mark - UserSmsRoot

@interface UserSmsRoot : GPBRootObject

// The base class provides:
//   + (GPBExtensionRegistry *)extensionRegistry;
// which is an GPBExtensionRegistry that includes all the extensions defined by
// this file and all files that it depends on.

@end

#pragma mark - SendSMSParam

typedef GPB_ENUM(SendSMSParam_FieldNumber) {
  SendSMSParam_FieldNumber_AppId = 1,
  SendSMSParam_FieldNumber_TelsArray = 2,
  SendSMSParam_FieldNumber_Type = 3,
  SendSMSParam_FieldNumber_Text = 4,
  SendSMSParam_FieldNumber_TemplateId = 5,
};

@interface SendSMSParam : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

// |telsArray| contains |NSString|
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray *telsArray;
@property(nonatomic, readonly) NSUInteger telsArray_Count;

@property(nonatomic, readwrite) SMSType type;

// 非必须，如果字符串长度不为0，则直接发送text内容
@property(nonatomic, readwrite, copy, null_resettable) NSString *text;

// 使用云通讯时，必须指定模板id
@property(nonatomic, readwrite) int64_t templateId;

@end

int32_t SendSMSParam_Type_RawValue(SendSMSParam *message);
void SetSendSMSParam_Type_RawValue(SendSMSParam *message, int32_t value);

#pragma mark - VarifySMSCodeParam

typedef GPB_ENUM(VarifySMSCodeParam_FieldNumber) {
  VarifySMSCodeParam_FieldNumber_AppId = 1,
  VarifySMSCodeParam_FieldNumber_Tel = 2,
  VarifySMSCodeParam_FieldNumber_Code = 3,
};

@interface VarifySMSCodeParam : GPBMessage

// 哪个app
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

// 手机号
@property(nonatomic, readwrite, copy, null_resettable) NSString *tel;

// 验证码
@property(nonatomic, readwrite, copy, null_resettable) NSString *code;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

// @@protoc_insertion_point(global_scope)
