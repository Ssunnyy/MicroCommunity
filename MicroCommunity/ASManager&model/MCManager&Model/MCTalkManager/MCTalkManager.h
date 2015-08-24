//
//  MCTalkManager.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

#define Talk_Request_main_serach @"home/talk/talk_search" //搜索
#define Talk_Request_new_list @"home/talk/talk_new_list" //  最新
#define Talk_Request_hot_list @"home/talk/talk_hot_list" //  最热
#define Talk_Request_Public @"home/talk/issue_talk" //  发布
#define Talk_Request_Delete @"home/talk/delete_talk" //  删除
#define Talk_Request_praise @"home/talk/praise_talk" //  点赞
#define Talk_Request_comment @"home/talk/comment_talk" //  评论话题
#define Talk_Request_report_talk @"home/talk/report_talk_add" //  举报话题添加
#define Talk_Request_details @"home/talk/talk_details"  //  话题详情



@interface MCTalkManager : YXBaseRequestManager


/**
 *  @brief  创建MCTalkManager的manager
 **/
+ (MCTalkManager *)shareManager;


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
               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


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
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                      onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

-(void)requestTalk_PublishWithParamDic:(NSMutableDictionary*)param
           updateFiles:(NSMutableArray*)files
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

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
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


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
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

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
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  话题详情
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestTalk_DetailWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

@end
