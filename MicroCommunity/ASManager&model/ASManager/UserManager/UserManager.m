//
//  UserManager.m
//  YiXin
//
//  Created by keke on 14/12/1.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "UserManager.h"

//获取验证码（注册)验证手机号
#define GetCodeURL  @"identifyCode/pushIdentifyCode"
//注册时候确认验证码
#define ConfirmCodeURL @"identifyCode/checkIdentifyCode"
//注册
#define RegisterUrl  @"appUser/register"
//登录
#define LoginURL     @"appUser/login"
//忘记密码
#define ForgetPwdUrl @"appUser/forgetPwd"
//修改密码
#define ChangePwdUrl @"appUser/updatePwd"
//用户认证
#define Authentication @"authentication/save"
//融云好友列表
#define UserfriendsList @"rongCloud/friendsList"
//IM搜索好友
#define FindUserForAdd @"rongCloud/findUserForAdd"
//添加好友
#define AddFriends @"rongCloud/addFriends"
//接受或者拒绝好友请求
#define ReRequest @"rongCloud/reRequest"
//删除好友
#define DelFriend @"rongCloud/delFriend"
//用户信息
#define UserInfo @"appUser/personalInfo"
//修改用户信息
#define UserInfoChange @"appUser/updatePersonalInfo"
//获取用户信息
#define getMyInfo @"appUser/getMyInfo"
//CC分享
#define ccShow @"appUser/ccShow/getUgcByCCShare"
//BC分享
#define bcShow @"appUser/bcShow/getBcShowByShare"
//获取黑名单列表
#define BlackFriendList @"rongCloud/blackList"
//加入黑名单
#define AddBlackFriend @"rongCloud/addBlack"
//移除黑名单
#define DelBlackFriend @"rongCloud/delBlack"
//获取用户token
#define GetUserToken @"common/reLogin"

@interface UserManager ()
///登录的token
@property (nonatomic , strong , readwrite)NSString   *loginToken;
///token的过期时间
@property (nonatomic , strong , readwrite)NSString   *exceedTime;
@property (nonatomic , strong) UserModel * currentModel;
@property (nonatomic , strong , readwrite)NSString   *userID;


@end

@implementation UserManager

static UserManager *defaultCenterInstance = nil;

+(UserManager*)shareManager
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
//        [self exitLogin];
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
    [self getCurrentUser].userId = nil;
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
-(UserModel *)getCurrentUser
{
   _currentModel = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:USER_INFO_KEY];
   return _currentModel;
}
//是否已登录
-(BOOL)isLogin
{
    self.userID = _currentModel.userId;
    if (self.userID && ![self.userID isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(void)safeAccountToLocal:(UserModel *)account
{
    [[ITTDataCacheManager sharedManager] addObject:account forKey:USER_INFO_KEY];
    [[ITTDataCacheManager sharedManager] doSave];
}

//注册
-(void)requestRegisterWithParam:(NSMutableDictionary*)params
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:RegisterUrl
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

//获取验证码
-(void)requestGetCodeWithParam:(NSMutableDictionary*)params
             withIndicatorView:(UIView*)view
           withCancelRequestID:(NSString*)requestID
               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:GetCodeURL
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

//注册验证验证码
-(void)requestConfirmCodeWithParam:(NSMutableDictionary*)params
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:ConfirmCodeURL
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

//登录
-(void)requestLoginWithParam:(NSMutableDictionary*)params
           withIndicatorView:(UIView*)view
         withCancelRequestID:(NSString*)requestID
             onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
             onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
               doSaveAccount:(UserModel*(^)(void))accountBlock;
{
    __weak UserManager * weakself = self;
    [super requestWithPath:LoginURL
              withParamDic:params
         withIndicatorView:view
       withCancelRequestID:requestID
    withPostORDeleteMethod:kHTTPMethodPost
                 authToken:nil
                     isSSL:NO
           onRequestFinish:^(MKNetworkOperation *operation) {
               if ([operation isSuccees]) {
                   
                   NSDictionary *user = [operation.resultDic objectForKey:@"appUser"] ;
                   NSString *loveName = [operation.resultDic objectForKey:@"loverNickname"];
                   NSString *marrayDate = [operation.resultDic objectForKey:@"marryDate"];
                   weakself.userID = [[operation.resultDic objectForKey:@"appUser"] objectForKey:@"id"];
                    weakself.loginToken = [[operation.resultDic objectForKey:@"appUser"] objectForKey:@"token"];
                   UserModel * model ;
                   if (accountBlock) {
                       model = accountBlock();
                   }
                   if (model) {
                       model.headImg = [user objectForKey:@"headImg"];
                       model.backImg = [user objectForKey:@"backImg"];
                       model.cityId = [user objectForKey:@"cityId"];
                       model.citycn = [user objectForKey:@"citycn"];
                       model.createTime = [user objectForKey:@"createTime"];
                       model.distance = [user objectForKey:@"distance"];
                       model.gender = [user objectForKey:@"gender"];
                       model.userId = [user objectForKey:@"id"];
                       model.lastLoginTime = [user objectForKey:@"lastLoginTime"];
                       model.mobile = [user objectForKey:@"mobile"];
                       model.modifiedTime = [user objectForKey:@"modifiedTime"];
                       model.nickname = [user objectForKey:@"nickname"];
                       model.openGps = [user objectForKey:@"openGps"];
                       model.openPush = [user objectForKey:@"openPush"];
                       model.openShow = [user objectForKey:@"openShow"];
                       model.personalSign = [user objectForKey:@"personalSign"];
                       model.referralId = [user objectForKey:@"referralId"];
                       model.rongToken = [user objectForKey:@"rongToken"];
                       model.showIndex = [user objectForKey:@"showIndex"];
                       model.token = [user objectForKey:@"token"];
                       model.type = [user objectForKey:@"type"];
                       model.loverNickname = loveName;
                       model.marryDate = marrayDate;
                       
                       [self safeAccountToLocal:model];
                   }
                   [self setAutoLogin:YES];
                   onFinishedBlock(operation);
               }else{
                   [ITTPromptView showMessage:[operation message]];
               }
           }
           onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
               if (operation && error) {
                   onFailedBlock(operation,error);
               }
           }];
}

-(void)requestForgetPwdWithParam:(NSMutableDictionary*)params
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{

    [super requestWithPath:ForgetPwdUrl
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

-(void)requestChangePwdWithParam:(NSMutableDictionary*)params
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:ChangePwdUrl
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

-(void)requestAuthenticationWithParam:(NSMutableDictionary*)params
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:Authentication
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

- (void)requestUserFriendsListWithParam:(NSMutableDictionary*)params
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:UserfriendsList
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
 *  bc_CC个人信息           /appUser/personalSign
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
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:UserInfo
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
 *  CC个人信息修改           /appUser/personalSign
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
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{


    [super requestWithPath:UserInfoChange
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
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    
    [super requestWithPath:FindUserForAdd
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
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:AddFriends
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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:ReRequest
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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:DelFriend
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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:getMyInfo
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
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:ccShow
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
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:bcShow
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
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:BlackFriendList
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
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:AddBlackFriend
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
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:DelBlackFriend
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
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {

    [super requestWithPath:GetUserToken
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


@end
