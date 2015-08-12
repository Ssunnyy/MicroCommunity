//
//  ASMainRequestManager.h
//  ITotem
//
//  Created by qiuyan on 15-3-11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

/**
 *  广告缓存
 *
 *  @param ASMainRequestManager
 *
 *  @return
 */
#define MainAdImgKEY @"MainAdImgKEY"
/**
 *  素材缓存
 *
 *  @param ASMainRequestManager
 *
 *  @return
 */
#define MainMaterialImageKey @"MainMaterialImageKey"
/**
 *  bC缓存
 *
 *  @param ASMainRequestManager
 *
 *  @return
 */
#define MainAsBcImageKey @"MainAsBcImageKey"
/**
 *  cC缓存
 *
 *  @param ASMainRequestManager
 *
 *  @return
 */
#define MainAsCcImageKey @"MainAsCcImageKey"


@interface ASMainRequestManager : YXBaseRequestManager

/**
 *  主页请求manager
 *
 */
+ (ASMainRequestManager *)shareManager;

/**
 *  主页广告接口（/adv/advList）
 *
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestMainAdWithParam:(NSMutableDictionary*)param
          withIndicatorView:(UIView*)view
        withCancelRequestID:(NSString*)requestID
             withHttpMethod:(kHTTPMethod)httpMethod
            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
            onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取以及素材全部列表
 *  /firstMaterial/clickFirstMaterial
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestMaterialMainAllWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取以及素材列表
 *  /firstMaterial/firstMaterialList
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestMainMaterialWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取BC&CC列表
 *  /index/getCcBcShow
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestMainBCCCWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取素材主页信息
 *  /secondMaterial/getSecondMaterial
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestMaterialMainWithParam:(NSMutableDictionary*)param
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                 withHttpMethod:(kHTTPMethod)httpMethod
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  获取素材主页三级列表信息
 *  /secondMaterial/getThirdMaterialBySecondMaterial
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestMaterialMainThirdWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;
/**
 *  获取CCshow信息
 *  appUser/getUgc
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestCCShowMainThirdWithParam:(NSMutableDictionary*)param
                       withIndicatorView:(UIView*)view
                     withCancelRequestID:(NSString*)requestID
                          withHttpMethod:(kHTTPMethod)httpMethod
                         onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                         onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取BCshow信息
 *  appUser/getUgc
 *  @param param           请求的参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */

-(void)requestBCShowMainThirdWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  向七牛服务器上传token
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestQiniuTokenWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  个人show编辑 七牛返回的图片key给后台
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestCCSaveWithParam:(NSMutableDictionary*)param
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  个人show编辑 得到某个人的show页面已有的图
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestCCPersonShowWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  个人show编辑 删除已经上传过的图
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestDeleteCCPersonShowWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show编辑 七牛返回的图片key给后台
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCSaveWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show编辑 /bcShow/delete 删除照片集
 *
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCDeleteWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  商家show编辑 /bcShow/deleteImg 删除照片集中的某个图片 
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCDeleteImageWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show编辑 bcShow/editBcShowImgs 编辑照片集中的图片
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCEditImageWithParam:(NSMutableDictionary*)param
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show我的故事删除      bcShow/deleteMyStory
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCStoryImageDeleteWithParam:(NSMutableDictionary*)param
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show我的故事添加      bcShow/saveMyStory
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCStorySaveWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  商家show我的故事编辑1     bcShow/editMyStory
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestBCStoryEditWithParam:(NSMutableDictionary*)param
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  广告详情页               /adv/jumpAdv
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestADDetailWithParam:(NSMutableDictionary*)param
                 withIndicatorView:(UIView*)view
               withCancelRequestID:(NSString*)requestID
                    withHttpMethod:(kHTTPMethod)httpMethod
                   onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;


/**
 *  收藏               /collcet/confirmCollect
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestCollectionWithParam:(NSMutableDictionary*)param
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  取消收藏               "collcet/cancelCollect"
 *·
 *  @param param           参数
 *  @param view            在那个view上的请求 显示圈圈
 *  @param requestID       请求ID
 *  @param httpMethod      post or get
 *  @param onFinishedBlock 请求完成
 *  @param onFailedBlock   请求失败
 */
-(void)requestCollectionCancelWithParam:(NSMutableDictionary*)param
                      withIndicatorView:(UIView*)view
                    withCancelRequestID:(NSString*)requestID
                         withHttpMethod:(kHTTPMethod)httpMethod
                        onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                        onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock;

/**
 *  获取缓存
 */

- (NSMutableDictionary *)getLocalCache;

@end

