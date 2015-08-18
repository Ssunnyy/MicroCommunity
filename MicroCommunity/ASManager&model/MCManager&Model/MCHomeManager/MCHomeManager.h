//
//  MCHomeManager.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

#define Home_request_circle @"home/life/key_drawing"
#define Home_request_main @"home/life/index"
#define Home_request_lifeSearch @"home/life/life_search"
#define Home_request_lifeCity @"home/life/life_region"

@interface MCHomeManager : YXBaseRequestManager

/**
 *  @brief  创建MCHomeManager的manager
 **/
+ (MCHomeManager *)shareManager;

/**
 *  @brief  首页轮播图
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestCircleWithParam:(NSMutableDictionary*)param
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  首页
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHomeMainWithParam:(NSMutableDictionary*)param
             withIndicatorView:(UIView*)view
           withCancelRequestID:(NSString*)requestID
                withHttpMethod:(kHTTPMethod)httpMethod
               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  首页搜索
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHomeMainSearchWithParam:(NSMutableDictionary*)param
               withIndicatorView:(UIView*)view
             withCancelRequestID:(NSString*)requestID
                  withHttpMethod:(kHTTPMethod)httpMethod
                 onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                 onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  首页城市
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHomeMainCityWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
@end
