//
//  MCHomeManager.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"
/**
 *  首页
 *
 *  @param MCHomeManager
 *
 *  @return
 */
#define Home_request_circle     @"home/life/key_drawing"    //轮播
#define Home_request_main       @"home/life/index"          //首页
#define Home_request_lifeSearch @"home/life/life_search"    //首页搜索
#define Home_request_lifeCity   @"home/life/life_region"    //地区



#define Home_request_company_home    @"home/life/native_seller" //企业首页
/**
 *  公司
 */
#define Home_request_seller_publish           @"home/seller/seller_publish"//商家发布
#define Home_request_seller_details           @"home/seller/seller_details"//商家详情
#define Home_request_seller_details_comment   @"home/seller/seller_details_comment"//商家评论
#define Home_request_seller_praise            @"home/seller/seller_praise"//商家点赞
#define Home_request_seller_collect           @"home/seller/seller_collect"//商家收藏
#define Home_request_seller_comment_list      @"home/seller/seller_comment_list"
#define Home_request_no_seller_collect        @"home/seller/no_seller_collect"//商家取消收藏
#define Home_request_update_seller            @"home/seller/update_seller"//修改商家资料
/**
 *  产品
 */
#define Home_request_goods_publish      @"home/seller/goods_publish"//发布产品
#define Home_request_goods_list         @"home/seller/product_list" //产品列表
#define Home_request_goods_search       @"home/seller/goods_search"//产品搜索
#define Home_request_all_goods_delete   @"home/Person/all_goods_delete" //产品删除

#define Home_request_goods_details      @"home/seller/goods_details"//产品详情
#define Home_request_goods_comment      @"home/seller/goods_comment"//产品评论
#define Home_request_goods_praise       @"home/seller/goods_praise"//产品点赞
#define Home_request_goods_collect      @"home/seller/goods_collect"//产品收藏
#define Home_request_goods_comment_list @"home/seller/goods_comment_list"//产品评论列表
#define Home_request_goods_service      @"home/seller/seller_service"//商家服务

/**
 *  招聘
 *
 *  @param MCHomeManager
 *
 *  @return
 */
#define Home_request_zhaopin_index   @"home/zhaopin/index"//招聘首页
#define Home_request_zhaopin_job     @"home/zhaopin/job"//求职首页
#define Home_request_zhaopin_publish @"home/zhaopin/zhaopin_publish"//招聘发布
#define Home_request_zhaopin_details @"home/zhaopin/zhaopin_details"//招聘详情
#define Home_request_zhaopin_collect @"home/zhaopin/zhaopin_collect"    //昭平收藏
#define Home_request_job_details     @"home/zhaopin/job_details"//求职详情



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

/**
 *  @brief  商家发布
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/


- (void)requestHome_seller_publishWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


-(void)requestHome_seller_publishWithParamDic:(NSMutableDictionary*)param
                           updateFiles:(NSMutableArray*)files
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

/**
 *  @brief  商家详情
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_seller_detailsWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家评论
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_seller_details_commentCityWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家点赞
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_seller_praiseWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_seller_collectWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家取消收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_no_seller_collectWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  商家评论列表
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_seller_comment_listWithParam:(NSMutableDictionary*)param
                             withIndicatorView:(UIView*)view
                           withCancelRequestID:(NSString*)requestID
                                withHttpMethod:(kHTTPMethod)httpMethod
                               onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                               onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  修改商家资料
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_update_sellerWithParam:(NSMutableDictionary*)param
                   withIndicatorView:(UIView*)view
                 withCancelRequestID:(NSString*)requestID
                      withHttpMethod:(kHTTPMethod)httpMethod
                     onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

-(void)requestHome_update_sellerWithParam:(NSMutableDictionary*)param
                                  updateFiles:(NSMutableArray*)files
                            withIndicatorView:(UIView*)view
                          withCancelRequestID:(NSString*)requestID
                              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                              onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

/**
 *  @brief  发布产品
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_goods_publishWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

- (void)requestHome_goods_publishWithParam:(NSMutableDictionary*)param
                                  updateFiles:(NSMutableArray*)files
                            withIndicatorView:(UIView*)view
                          withCancelRequestID:(NSString*)requestID
                              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                              onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;


/**
 *  @brief  产品列表
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_goods_listWithParam:(NSMutableDictionary*)param
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  产品删除
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_goods_DeleteWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  产品搜索
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_goods_searchWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  产品详情
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_detailsWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  产品评论
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_commentWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  产品点赞
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_praiseWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  产品收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_collectWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  产品评论列表
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_comment_listWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  商家服务
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_request_goods_serviceWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  @brief  招聘首页
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_zhaopin_indexWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  求职首页
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_zhaopin_jobWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  @brief  本地企业首页
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_company_homeWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  招聘发布
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_zhaopin_publishWithParam:(NSMutableDictionary*)param
                         withIndicatorView:(UIView*)view
                       withCancelRequestID:(NSString*)requestID
                            withHttpMethod:(kHTTPMethod)httpMethod
                           onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                           onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  招聘详情
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_haopin_detailsWithParam:(NSMutableDictionary*)param
                           withIndicatorView:(UIView*)view
                         withCancelRequestID:(NSString*)requestID
                              withHttpMethod:(kHTTPMethod)httpMethod
                             onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                             onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  招聘收藏
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_zhaopin_collectWithParam:(NSMutableDictionary*)param
                       withIndicatorView:(UIView*)view
                     withCancelRequestID:(NSString*)requestID
                          withHttpMethod:(kHTTPMethod)httpMethod
                         onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                         onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  @brief  求职详情
 *  @param  params
 *  @param  view                    在那一页上的请求
 *  @param  requestID               请求的ID
 *  @param  onFinishedBlock         请求完成的block，可以得到请求成功解析后的数组以及得到的数据个数，实现自己的逻辑
 *  @param  onFailedBlock           请求失败的的block，可以得到请求是失败后的错误，并实现自己的逻辑
 *  @return
 **/

- (void)requestHome_job_detailsWithParam:(NSMutableDictionary*)param
                           withIndicatorView:(UIView*)view
                         withCancelRequestID:(NSString*)requestID
                              withHttpMethod:(kHTTPMethod)httpMethod
                             onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                             onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;




@end
