//
//  MCUserManager.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCUserManager.h"

@interface MCUserManager()

///登录的token
@property (nonatomic , strong )NSString   *loginToken;
///token的过期时间
@property (nonatomic , strong )NSString   *exceedTime;
///用户ID
@property (nonatomic , strong )NSString   *userID;
//
@property (nonatomic, strong) MCUserModel *currentUser;

@end

@implementation MCUserManager

static MCUserManager *defaultCenterInstance = nil;

/**
 *  @brief  创建User的manager
 **/

+(MCUserManager*)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}


-(NSString *)loginToken
{
    if (!_loginToken) {
        return @"";
    }
    return [[self getCurrentUser] token];
}

-(NSString *)exceedTime
{
    if (!_exceedTime) {
        return @"";
    }
    return _exceedTime;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
//是否自动登录
-(BOOL)isAutoLoginResult
{
    BOOL isAutoLogin = [USER_DEFAULT boolForKey:ALLOW_AUTOLOGIN];
    if(!isAutoLogin) {
        return NO;
    }else {
        return YES;
    }
}

//退出登录
- (void)exitLogin
{
    self.loginToken = nil;
    self.userID = nil;
    [self getCurrentUser].user_id = nil;
    [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:USER_INFO_KEY];
    [USER_DEFAULT setBool:NO forKey:ALLOW_AUTOLOGIN];
    [USER_DEFAULT synchronize];
}

//设置自动登录
- (void)setAutoLogin:(BOOL)isAutoLogin
{
    [USER_DEFAULT setBool:isAutoLogin forKey:ALLOW_AUTOLOGIN];
}

//是否有效
- (BOOL)isValidToken:(MKNetworkOperation*)operation;
{
    id result = [operation.resultDic objectForKey:@"data"];
    if ([result isKindOfClass:[NSString class]]) {
        if ([result isEqualToString:@"tokenexpired"]) {
            return NO;
        }
    }
    return YES;
}
//获取当前用户
- (MCUserModel *)getCurrentUser
{
    _currentUser = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:USER_INFO_KEY];
    return _currentUser;
}
//是否已登录
- (BOOL)isLogin
{
    self.userID = _currentUser.user_id;
    if (self.userID && ![self.userID isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (void)safeAccountToLocal:(MCUserModel *)account
{
    [[ITTDataCacheManager sharedManager] addObject:account forKey:USER_INFO_KEY];
    [[ITTDataCacheManager sharedManager] doSave];
}


/**
 *  @brief  注册
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
- (void)requestRegisterWithParam:(NSMutableDictionary*)params
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:Request_User_Regist
              withParamDic:params
         withIndicatorView:view
       withCancelRequestID:requestID
    withPostORDeleteMethod:kHTTPMethodPost
                 authToken:nil
                     isSSL:NO
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];
}

/**
 *  @brief  登录网络请求
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
- (void)requestLoginWithParam:(NSMutableDictionary*)params
           withIndicatorView:(UIView*)view
         withCancelRequestID:(NSString*)requestID
             onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
             onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
               doSaveAccount:(UserModel*(^)(void))accountBlock {

    [super requestWithPath:Request_User_Login
              withParamDic:params
         withIndicatorView:view
       withCancelRequestID:requestID
    withPostORDeleteMethod:kHTTPMethodPost
                 authToken:nil
                     isSSL:NO
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];
}

/**
 *  @brief  获取验证码网络请求
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
- (void)requestCodeWithParam:(NSMutableDictionary*)param
          withIndicatorView:(UIView*)view
        withCancelRequestID:(NSString*)requestID
             withHttpMethod:(kHTTPMethod)httpMethod
            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Request_User_GetCode
              withParamDic:param
         withIndicatorView:view
       withCancelRequestID:requestID
    withPostORDeleteMethod:kHTTPMethodPost
                 authToken:nil
                     isSSL:NO
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];
    
}

/**
 *  @brief  重置密码网络请求
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
- (void)requestResetPassWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Request_User_ResetPass
              withParamDic:param
         withIndicatorView:view
       withCancelRequestID:requestID
    withPostORDeleteMethod:kHTTPMethodPost
                 authToken:nil
                     isSSL:NO
           onRequestFinish:^(MKNetworkOperation *operation) {
               if (onFinishedBlock) {
                   onFinishedBlock(operation);
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (onFailedBlock) {
                   onFailedBlock(operation,error);
               }
           }];
    
}

@end
