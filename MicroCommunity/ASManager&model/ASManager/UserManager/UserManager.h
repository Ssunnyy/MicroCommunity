//
//  UserManager.h
//  YiXin
//
//  Created by keke on 14/12/1.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "YXBaseRequestManager.h"
#import "UserModel.h"

#define ALLOW_AUTOLOGIN @"ALLOW_AUTOLOGIN"
#define USER_NAME_KEY   @"USER_NAME_KEY"
#define PASSWOED_KEY    @"PASSWOED_KEY"
#define USER_INFO_KEY   @"USER_INFO_KEY"
#define EXIT_LOGIN_KEY  @"EXIT_LOGIN_KEY"
#define UD_KEY_DATA_CACHE_OBJECTS   @"UD_KEY_DATA_CACHE_OBJECTS"

@interface UserManager : YXBaseRequestManager

///登录的token
@property (nonatomic , strong , readonly)NSString   *loginToken;
///token的过期时间
@property (nonatomic , strong , readonly)NSString   *exceedTime;
///用户ID
@property (nonatomic , strong , readonly)NSString   *userID;

/**
 *  @brief  创建User的manager
 **/
+(UserManager*)shareManager;

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
- (UserModel*)getCurrentUser;

/**
 *  @brief  是否已登录
 *  @return 是否
 */
- (BOOL)isLogin;


/**
 *  @brief  注册获取验证码网络请求
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
-(void)requestGetCodeWithParam:(NSMutableDictionary*)params
             withIndicatorView:(UIView*)view
           withCancelRequestID:(NSString*)requestID
               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  注册时验证验证码
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
-(void)requestConfirmCodeWithParam:(NSMutableDictionary*)params
             withIndicatorView:(UIView*)view
           withCancelRequestID:(NSString*)requestID
               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;



/**
 *  @brief  注册
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
-(void)requestRegisterWithParam:(NSMutableDictionary*)params
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
-(void)requestLoginWithParam:(NSMutableDictionary*)params
           withIndicatorView:(UIView*)view
         withCancelRequestID:(NSString*)requestID
             onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
             onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
               doSaveAccount:(UserModel*(^)(void))accountBlock;

/**
 *  @brief  忘记密码
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
-(void)requestForgetPwdWithParam:(NSMutableDictionary*)params
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  修改密码
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/
-(void)requestChangePwdWithParam:(NSMutableDictionary*)params
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家认证
 *  @param  params                  请求的参数 mobileNo
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

-(void)requestAuthenticationWithParam:(NSMutableDictionary*)params
                    withIndicatorView:(UIView*)view
                  withCancelRequestID:(NSString*)requestID
                      onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取好友列表
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestUserFriendsListWithParam:(NSMutableDictionary*)params
         withIndicatorView:(UIView*)view
       withCancelRequestID:(NSString*)requestID
            withHttpMethod:(kHTTPMethod)httpMethod
           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取 bc_CC个人信息           /appUser/personalSign
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestUserInfoWithParam:(NSMutableDictionary*)params
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  CC个人信息修改           /appUser/updatePersonalInfo
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestUserInfoChangeWithParam:(NSMutableDictionary*)params
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  添加好友中搜索好友
 *
 *  @param param           请求的参数 nikeName/phoneNumer
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestFindUserForAddWithParam:(NSMutableDictionary*)params
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  添加好友
 *
 *  @param param           请求的参数 appUserId/friendUserid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestAddFriendsWithParam:(NSMutableDictionary*)params
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  接受或者拒绝好友请求
 *
 *  @param param           请求的参数 appUserId/friendUserid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestReRequestWithParam:(NSMutableDictionary*)params
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  删除好友
 *
 *  @param param           请求的参数 appUserId/friendUserid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestDelFriendWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  根据UserId 获得用户信息
 *
 *  @param param           请求的参数 appUserId/friendUserid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetMyInfoWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  根据UserId 获得CC分享界面
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetCCShareWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  根据UserId 获得BC分享界面
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetBCShareWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  根据UserId 获得黑名单列表
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetBlackFriendListWithParam:(NSMutableDictionary*)params
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  根据UserId 获添加黑名单
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetAddBlackFriendWithParam:(NSMutableDictionary*)params
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  根据UserId 移除黑名单
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetDelBlackFriendWithParam:(NSMutableDictionary*)params
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  获取用户token
 *
 *  @param param           请求的参数 userID
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestgetUserTokenWithParam:(NSMutableDictionary*)params
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;



@end
