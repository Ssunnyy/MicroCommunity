//
//  MCMYManager.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

#define My_Request_ChangeUserInfo @"home/Person/index" //修改个人信息
#define My_Request_publish @"home/Person/my_publish" // 我的发布
#define My_Request_collect @"home/Person/my_company_collect" // 我的收藏
#define My_Request_goods_collect @"home/Person/my_goods_collect" // 我的产品收藏
#define MY_Request_view_feedback @"home/Person/viewfeedback"  //意见反馈

@interface MCMYManager : YXBaseRequestManager

/**
 *  @brief  我的mamager
 **/

+ (MCMYManager *)shareManager;


/**
 *  @brief  我的发布
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestMy_PublicWithParam:(NSMutableDictionary*)param
             withIndicatorView:(UIView*)view
           withCancelRequestID:(NSString*)requestID
                withHttpMethod:(kHTTPMethod)httpMethod
               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  我的收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestMy_CollectWithParam:(NSMutableDictionary*)param
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  我的产品收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestMy_Goods_CollectWithParam:(NSMutableDictionary*)param
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  我的意见反馈
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestMy_view_feedbackWithParam:(NSMutableDictionary*)param
                       withIndicatorView:(UIView*)view
                     withCancelRequestID:(NSString*)requestID
                          withHttpMethod:(kHTTPMethod)httpMethod
                         onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                         onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

@end
