//
//  YXBaseRequestManager.m
//  YiXin
//
//  Created by keke on 14/12/6.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "YXBaseRequestManager.h"
#import "NSData+ITTAdditions.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
#import "YXUserEngine.h"
#import "ITTDataEnvironment.h"


@interface YXBaseRequestManager ()
@property (nonatomic , strong) YXBaseEngine *engine;
@property (nonatomic , strong) YXUserEngine *userEngine;
@end

@implementation YXBaseRequestManager
@synthesize engine=_engine;
@synthesize userEngine = _userEngine;

static YXBaseRequestManager *defaultCenterInstance = nil;
+(YXBaseRequestManager*)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _engine = [[YXBaseEngine alloc]initWithHostName:HostURL];
        [_engine registerOperationSubclass:[YXBaseOperation class]];
        _userEngine = [[YXUserEngine alloc]initWithHostName:HostURL];
        [_userEngine registerOperationSubclass:[YXBaseOperation class]];
    }
    return self;
}
-(void)requestWithPath:(NSString*)path
          withParamDic:(NSMutableDictionary*)param
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
withPostORDeleteMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;
{
    //对参数进行操作
    NSMutableDictionary * finalParam = [self getUrlBody:param];

    ITTMKNetworkEngine *engine;
    if (useSSl) {
        engine = _userEngine;
    }else
    {
        engine = _engine;
    }

   [super requestWithPath:path
                useEngine:engine
                withFiles:nil
                withParam:finalParam
        withIndicatorView:view
      withCancelRequestID:requestID
               withMethod:httpMethod
                authToken:token
                    isSSL:useSSl
          onRequestFinish:^(MKNetworkOperation *operation) {
              if (onFinishedBlock) {
                  NSLog(@"resultDic=====%@",operation.resultDic);

                  onFinishedBlock(operation);
              }
      }
          onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
              if (onFailedBlock) {
                  onFailedBlock(operation,error);
              }
      }];

}

-(void)requestWithPath:(NSString*)path
          withParamArr:(NSMutableArray*)param
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
            withMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;
{
    NSMutableString* finalPath = [NSMutableString string];
    if (path) {
        [finalPath appendString:path];
    }
    [finalPath appendString:[self getURLPath:param]];

    ITTMKNetworkEngine *engine;
    if (useSSl) {
        engine = _userEngine;
    }else
    {
        engine = _engine;
        [engine emptyCache];
    }

    [super requestWithPath:finalPath
                 useEngine:engine
                 withFiles:nil
                 withParam:nil
         withIndicatorView:view
       withCancelRequestID:requestID
                withMethod:httpMethod
                 authToken:token
                     isSSL:useSSl
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   NSLog(@"resultDic=====%@",operation.resultDic);
                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];

}
-(void)requestWithPath:(NSString*)path
          withParamDic:(NSMutableDictionary*)param
           updateFiles:(NSMutableArray*)files
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
withPostORDeleteMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;
{
    //对参数进行操作
    NSMutableDictionary * finalParam = [self getUrlBody:param];

    ITTMKNetworkEngine *engine;
    if (useSSl) {
        engine = _userEngine;
    }else
    {
        engine = _engine;
    }
    
    [super requestWithPath:path
                 useEngine:engine
                 withFiles:files
                 withParam:finalParam
         withIndicatorView:view
       withCancelRequestID:requestID
                withMethod:httpMethod
                 authToken:token
                     isSSL:useSSl
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   NSLog(@"resultDic=====%@",operation.resultDic);

                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];
}
-(NSMutableString*)getURLPath:(NSMutableArray*)arr
{
    NSMutableString*finnalurl=[NSMutableString string];
    for (NSString* item in arr) {
        [finnalurl appendString:@"/"];
        [finnalurl appendString:item];
    }
    return finnalurl;
}

-(NSMutableDictionary*)getUrlBody:(NSMutableDictionary*)dic
{
    
//    NSMutableString *rawPostString = [NSMutableString string];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *name = [[UIDevice currentDevice] name];
//    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//
//    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    NSString *model = [[UIDevice currentDevice] model];
//
//    NSString *appFrom = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"AppFrom"];
//    NSString *deviceToken = [USER_DEFAULT objectForKey:DEVICE_TOKEN];
//
//    
//    NSMutableString *rawPostString = [NSMutableString stringWithFormat:@"did=%@&_dname=%@&_requesttime=%.f&_language=%@&_version=%@&_appversion=%@&_model=%@&_systemtype=ios&userLat=%@&userLon=%@",[CommonHelp getUUIDFromKeychainItemWrapper],name,[[NSDate date] timeIntervalSince1970],currentLanguage,systemVersion,appVersion,model,[USER_DEFAULT objectForKey:MMLastLatitude],[USER_DEFAULT objectForKey:MMLastLongitude]];
//    
//    [rawPostString appendString:@"&_devicetoken="];
//    if (deviceToken) {
//        [rawPostString appendString:deviceToken];
//    }
//    
//    [rawPostString appendString:@"&_from="];
//    if (appFrom) {
//        [rawPostString appendString:appFrom];
//    }
//    //位置
////    [rawPostString appendFormat:@"&cityCode=%@",[USER_DEFAULT objectForKey:CITYCODE]?[USER_DEFAULT objectForKey:CITYCODE]:@"101010100"];
////    [rawPostString appendFormat:@"&citycn=%@",[USER_DEFAULT objectForKey:CITYNAME]?[USER_DEFAULT objectForKey:CITYNAME]:@"北京"];
////    [rawPostString appendFormat:@"&provinceCode=%@",[USER_DEFAULT objectForKey:PROVINCECODE]?[USER_DEFAULT objectForKey:PROVINCECODE]:@"101010000"];
////    [rawPostString appendFormat:@"&provincecn=%@",[USER_DEFAULT objectForKey:PROVINCENAME]?[USER_DEFAULT objectForKey:PROVINCENAME]:@"北京"];
//
//    //用户信息
//
////    [rawPostString appendFormat:@"&appUserId=%@",[UserManager shareManager].userID];
//    [rawPostString appendFormat:@"&token=%@",[[UserManager shareManager]loginToken]];
////    [rawPostString appendFormat:@"&tokenexpire=%@",[[UserManager shareManager]exceedTime]];
////
//    //网络环境
//    NSString *network = [[ITTDataEnvironment sharedDataEnvironment] netType];
//
//        [rawPostString appendString:@"&network="];
//    if (network) {
//
//        [rawPostString appendString:network];
//    }
//
//
//    [rawPostString appendString:@"&"];
//    for (NSString *key in [dic allKeys])
//    {
//        [rawPostString appendFormat:@"%@=%@&", key, [dic objectForKey:key]];
//    }
////    NSLog(@"hehehhe===%@",rawPostString);
//
//    DLog(@"postData=%@",rawPostString);
//    
//    NSString * poststring = [self encryptUseAES:rawPostString key:@"1%7jhs#Zjasd&tr*"];
//    NSMutableDictionary* adic = [NSMutableDictionary dictionary];
//    [adic safeString:poststring ForKey:@"vals"];
    return dic;
}

- (NSString*)decryptUseAES:(NSString*)cipherText key:(NSString*)key {
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeAES128,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
- (NSString *)encryptUseAES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[2048];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeAES128,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          2048,
                                          &numBytesEncrypted);

    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        ITTDPRINT(@"AES加密失败");
    }
    return plainText;
}
-(void)cancelRequestWithID:(NSString*)requestID finishCancel:(void(^)(void))cacelBlock
{
    [super cancelRequestWithID:requestID finishCancel:^{
        if (cacelBlock) {
            cacelBlock();
        }
    }];
}
-(void)cancelAllRequest
{
    [super cancelAllRequestWithEngine:_engine withCancelBlock:^{

    }];
    [super cancelAllRequestWithEngine:_userEngine withCancelBlock:^{

    }];
}

@end
