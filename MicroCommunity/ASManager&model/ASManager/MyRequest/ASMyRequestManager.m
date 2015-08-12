//
//  ASMyRequestManager.m
//  ITotem
//
//  Created by qiuyan on 15-3-26.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMyRequestManager.h"

#define OrderListURl @"orderList"
#define MyUrl        @"appUser/clickMy"
#define SetUrl       @"appUser/setUp"
#define AuthUrl      @"authentication/findAuthentication"
#define JobListUrl   @"job/list"
#define Collect_List @"collect/collectList"
#define Job_Detail   @"job/selectJob"

//1,我的账户余额
///appUser/myCurCash
//参数  userid
#define my_count_curCash  @"appUser/myCurCash"
//2，我的收支明细
///appUser/myPaymentDetailList
//参数 userid
//返回 list对象
#define my_count_Pay_detail  @"appUser/myPaymentDetailList"
//3，我的申请提现
///appUser/myApplyCash
//参数 app_user_id,apply_date,money
#define my_count_myApplyCash  @"appUser/myApplyCash"
//4，查询我的支付账户或密码
///appUser/selMyalipayorPwd
//参数 userid
//返回 map对象
#define my_count_myCountOrPassWord  @"appUser/selMyalipayorPwd"
//5, 设置我的支付账号或密码
///appUser/setMyalipayorPwd
//参数  userid,alipay,paypwd
//返回 成功，失败
#define my_count_set_myCountOrPassWord  @"appUser/setMyalipayorPwd"
//6，提现密码验证
///orders/getPaypwd
//参数 userid ， pwd
//返回 成功，失败
#define my_count_getPaypwd  @"orders/getPaypwd"

#define my_count_ConfirmPwd @"appUser/auditMyalipayorPwd"

@implementation ASMyRequestManager

static  ASMyRequestManager *defaultCenterInstance = nil;

+(ASMyRequestManager*)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}


-(void)requestOrderListWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:OrderListURl
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

-(void)requestMyWithParam:(NSMutableDictionary*)param
        withIndicatorView:(UIView*)view
      withCancelRequestID:(NSString*)requestID
           withHttpMethod:(kHTTPMethod)httpMethod
          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MyUrl
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

-(void)requestSetWithParam:(NSMutableDictionary*)param
         withIndicatorView:(UIView*)view
       withCancelRequestID:(NSString*)requestID
            withHttpMethod:(kHTTPMethod)httpMethod
           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{

    [super requestWithPath:SetUrl
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

-(void)requestAuthWithParam:(NSMutableDictionary*)param
          withIndicatorView:(UIView*)view
        withCancelRequestID:(NSString*)requestID
             withHttpMethod:(kHTTPMethod)httpMethod
            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:AuthUrl
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

-(void)requestJobWithParam:(NSMutableDictionary*)param
         withIndicatorView:(UIView*)view
       withCancelRequestID:(NSString*)requestID
            withHttpMethod:(kHTTPMethod)httpMethod
           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:JobListUrl
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
 *  我的订单 提示标签
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderInfoWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:JobListUrl
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
 *  收藏列表
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestCollectListWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Collect_List
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
 *  职业筛选
 *
 *  @param param           请求的参数 /AppUserId jobId
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestSelectJobWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:Job_Detail
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
 *  1我的账户余额
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMyCurCashWithParam:(NSMutableDictionary*)params
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:my_count_curCash
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
 *  2我的收支明细
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMyPaymentDetailListWithParam:(NSMutableDictionary*)params
                          withIndicatorView:(UIView*)view
                        withCancelRequestID:(NSString*)requestID
                             withHttpMethod:(kHTTPMethod)httpMethod
                            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:my_count_Pay_detail
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
 *  3，我的申请提现
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMyApplyCashWithParam:(NSMutableDictionary*)params
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:my_count_myApplyCash
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
 *  4，查询我的支付账户或密码
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMyselMyalipayorPwdWithParam:(NSMutableDictionary*)params
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:my_count_myCountOrPassWord
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
 *  5, 设置我的支付账号或密码
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMysetMyalipayorPwdWithParam:(NSMutableDictionary*)params
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:my_count_set_myCountOrPassWord
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
 *  6, 提现密码验证
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMygetPaypwdWithParam:(NSMutableDictionary*)params
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:my_count_getPaypwd
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
 *  7, 提现密码验证
 *
 *  @param param           请求的参数 /collectList
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
- (void)requestMyConfirmpwdWithParam:(NSMutableDictionary*)params
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:my_count_ConfirmPwd
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
