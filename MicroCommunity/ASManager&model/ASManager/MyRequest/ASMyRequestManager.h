//
//  ASMyRequestManager.h
//  ITotem
//
//  Created by qiuyan on 15-3-26.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

#define HEADImageCache  @"HEADImageCache"

#define BackImageCache  @"BackImageCache"


@interface ASMyRequestManager : YXBaseRequestManager

/**
 *  请求manager
 *
 */
+ (ASMyRequestManager *)shareManager;


/**
 *  订单列表（/adv/advList）
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderListWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  我的
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestMyWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  设置
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestSetWithParam:(NSMutableDictionary*)param
        withIndicatorView:(UIView*)view
      withCancelRequestID:(NSString*)requestID
           withHttpMethod:(kHTTPMethod)httpMethod
          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  跳到BC认证页
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestAuthWithParam:(NSMutableDictionary*)param
         withIndicatorView:(UIView*)view
       withCancelRequestID:(NSString*)requestID
            withHttpMethod:(kHTTPMethod)httpMethod
           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  职业信息
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestJobWithParam:(NSMutableDictionary*)param
          withIndicatorView:(UIView*)view
        withCancelRequestID:(NSString*)requestID
             withHttpMethod:(kHTTPMethod)httpMethod
            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  账户余额
 *
 *  @param param           请求的参数 /AppUserId
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
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
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
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *
 *  @param param           请求的参数 /collectList
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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;



/**
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
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;



@end
