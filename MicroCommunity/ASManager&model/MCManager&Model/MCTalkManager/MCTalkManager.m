//
//  MCTalkManager.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkManager.h"

@implementation MCTalkManager

static MCTalkManager *defaultCenterInstance = nil;

/**
 *  @brief  创建MCTalkManager的manager
 **/

+ (MCTalkManager *)shareManager
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
 *  @brief  话题搜索
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_serachWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:Talk_Request_main_serach
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
 *  @brief  话题最新
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_New_ListWithParam:(NSMutableDictionary*)param
                    withIndicatorView:(UIView*)view
                  withCancelRequestID:(NSString*)requestID
                       withHttpMethod:(kHTTPMethod)httpMethod
                      onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_new_list
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
 *  @brief  话题最热
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_Hot_ListWithParam:(NSMutableDictionary*)param
                    withIndicatorView:(UIView*)view
                  withCancelRequestID:(NSString*)requestID
                       withHttpMethod:(kHTTPMethod)httpMethod
                      onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_hot_list
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
 *  @brief  话题发布
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_PublishWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_Public
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
 *  @brief  话题 删除
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_DeleteWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:Talk_Request_Delete
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
 *  @brief  话题点赞
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_PraiseWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_praise
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
 *  @brief  评论话题
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_CommentWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_comment
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
 *  @brief  举报话题添加
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_ReportWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:Talk_Request_report_talk
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
