//
//  ASOrderRequestManager.h
//  ITotem
//
//  Created by adims on 15/4/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

@interface ASOrderRequestManager : YXBaseRequestManager

/**
 *  请求manager
 *
 */
+ (ASOrderRequestManager *)shareManager;

/**
 *  发起订单（/orders/orderSave）
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderLanchWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  通过订单id userid查询信息（）
 *
 *  @param param           请求的参数   orderid    userid
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
 *  insertServer userid查询信息（）
 *
 *  @param param           请求的参数   orderid    userid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderInfoInsertWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  deleteServer userid查询信息（）
 *
 *  @param param           请求的参数   orderid    userid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderInfoDeleteWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  bc  Ok  订单            bc 确认订单
 *
 *  @param param           请求的参数   orderid    userid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderBCConfirmWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  cc  Ok  支付单单详情
 *
 *  @param param           请求的参数   orderid    userid
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderCCPayDetailWithParam:(NSMutableDictionary*)param
                    withIndicatorView:(UIView*)view
                  withCancelRequestID:(NSString*)requestID
                       withHttpMethod:(kHTTPMethod)httpMethod
                      onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  cc  Ok  支付订单
 *
 *  @param param           请求的参数   orderNo    productName money
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderCCPayWithParam:(NSMutableDictionary*)param
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  cc  Ok  平台支付
 *
 *  @param param           请求的参数   orderNo    productName money
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestOrderCCPayPlatWithParam:(NSMutableDictionary*)param
                    withIndicatorView:(UIView*)view
                  withCancelRequestID:(NSString*)requestID
                       withHttpMethod:(kHTTPMethod)httpMethod
                      onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

@end
