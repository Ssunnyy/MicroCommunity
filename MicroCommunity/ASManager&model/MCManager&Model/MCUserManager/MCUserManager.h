//
//  MCUserManager.h
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"
#import "MCUserModel.h"

#define Request_User_Regist @"register"
#define Request_User_Login @"login"
#define Request_User_GetCode @"SendTemplateSMS"
#define Request_User_ResetPass @"reset_password"

@interface MCUserManager : YXBaseRequestManager

/**
 *  @brief  获取是否自动登录
 */
- (BOOL)isAutoLoginResult;

/**
 *  @brief  退出登录
 */
- (void)exitLogin;

/**
 *  @brief  退出登录
 *  @param  isAutoLogin       设置自动登录参数
 */
- (void)setAutoLogin:(BOOL)isAutoLogin;

/**
 *  @brief  token是否过期
 */
- (BOOL)isValidToken:(MKNetworkOperation*)operation;

/**
 *  @brief  获取当前用户
 *  @return 当前用户
 */
- (MCUserModel*)getCurrentUser;

/**
 *  @brief  是否已登录
 *  @return 是否
 */
- (BOOL)isLogin;

/**
 *  @brief  保存用户信息
 *  @return
 */
- (void)safeAccountToLocal:(MCUserModel *)account;

/**
 *  @brief  删除用户信息
 *  @return
 */

/**
 *  @brief  创建User的manager
 **/
+ (MCUserManager*)shareManager;

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
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
               doSaveAccount:(UserModel*(^)(void))accountBlock;

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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
@end
