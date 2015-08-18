//
//  MCMYManager.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMYManager.h"

@implementation MCMYManager

static MCMYManager *defaultCenterInstance = nil;

/**
 *  @brief  创建MCIMManager的manager
 **/

+ (MCMYManager *)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}

/**
 *  @brief  轮播图
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
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Home_request_circle
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
