//
//  ASMainRequestManager.m
//  ITotem
//
//  Created by qiuyan on 15-3-11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMainRequestManager.h"

#define MAINADURL               @"adv/advList"
#define MAINMATERIAL            @"firstMaterial/firstMaterialList"
#define MAINBCCCURL             @"index/getCcBcShow"

#define MAIN_MATERAL_ALL        @"firstMaterial/clickFirstMaterial"
#define MAIN_MATTERILA          @"secondMaterial/getSecondMaterial"
#define MAIN_MATERAL_Third      @"secondMaterial/getThirdMaterialBySecondMaterial"

#define MAIN_CCPERSONSHOW       @"ccShow/getUgc"
#define MAIN_BCPERSON_SHOW      @"bcShow/getBcShow"
#define Main_QINIUTOKENURL      @"common/getUptoken"
#define MainCCSAVEURL           @"ccShow/save"
#define MainCCPERSONFINDURL     @"ccShow/find"
#define MainCCPERSONDELETEURL   @"ccShow/delete"
#define MAIN_BC_ADD             @"bcShow/saveBcShowImgs"
#define MAIN_BC_EDIT_DELETE     @"bcShow/delete"
#define MAIN_BC_EDIT_DELETE_IMG @"bcShow/deleteImg"
#define MAIN_BC_EDIT            @"bcShow/editBcShowImgs"

#define MAIN_STORY_DELETE       @"bcShow/deleteMyStory"
#define MAIN_STORY_SAVE         @"bcShow/saveMyStory"
#define MAIN_STORY_EDIT         @"bcShow/editMyStory"

#define MAIN_AD_DETAIL          @"adv/jumpAdv"

#define COLLECTION_IMAGE        @"collect/confirmCollect"
#define COLLECTION_CANCEL       @"collect/cancelCollect"


@implementation ASMainRequestManager
static  ASMainRequestManager *defaultCenterInstance = nil;

+(ASMainRequestManager*)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}

-(void)requestMainAdWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{

    [super requestWithPath:MAINADURL
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

-(void)requestMainMaterialWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    
    [super requestWithPath:MAINMATERIAL
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

-(void)requestMainBCCCWithParam:(NSMutableDictionary*)param
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                 withHttpMethod:(kHTTPMethod)httpMethod
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAINBCCCURL
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


-(void)requestMaterialMainAllWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAIN_MATERAL_ALL
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

-(void)requestMaterialMainWithParam:(NSMutableDictionary*)param
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                 withHttpMethod:(kHTTPMethod)httpMethod
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAIN_MATTERILA
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

-(void)requestMaterialMainThirdWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAIN_MATERAL_Third
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

-(void)requestCCShowMainThirdWithParam:(NSMutableDictionary*)param
                       withIndicatorView:(UIView*)view
                     withCancelRequestID:(NSString*)requestID
                          withHttpMethod:(kHTTPMethod)httpMethod
                         onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                         onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAIN_CCPERSONSHOW
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

-(void)requestBCShowMainThirdWithParam:(NSMutableDictionary*)param
                     withIndicatorView:(UIView*)view
                   withCancelRequestID:(NSString*)requestID
                        withHttpMethod:(kHTTPMethod)httpMethod
                       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                       onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MAIN_BCPERSON_SHOW
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

-(void)requestQiniuTokenWithParam:(NSMutableDictionary*)param
                withIndicatorView:(UIView*)view
              withCancelRequestID:(NSString*)requestID
                   withHttpMethod:(kHTTPMethod)httpMethod
                  onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{

    [super requestWithPath:Main_QINIUTOKENURL
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

-(void)requestCCSaveWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MainCCSAVEURL
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

-(void)requestCCPersonShowWithParam:(NSMutableDictionary*)param
                  withIndicatorView:(UIView*)view
                withCancelRequestID:(NSString*)requestID
                     withHttpMethod:(kHTTPMethod)httpMethod
                    onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                    onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MainCCPERSONFINDURL
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

-(void)requestDeleteCCPersonShowWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock
{
    [super requestWithPath:MainCCPERSONDELETEURL
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

-(void)requestBCSaveWithParam:(NSMutableDictionary*)param
            withIndicatorView:(UIView*)view
          withCancelRequestID:(NSString*)requestID
               withHttpMethod:(kHTTPMethod)httpMethod
              onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
              onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {

    [super requestWithPath:MAIN_BC_ADD
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

-(void)requestBCDeleteWithParam:(NSMutableDictionary*)param
              withIndicatorView:(UIView*)view
            withCancelRequestID:(NSString*)requestID
                 withHttpMethod:(kHTTPMethod)httpMethod
                onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:MAIN_BC_EDIT_DELETE
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
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:MAIN_BC_EDIT_DELETE_IMG
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
                     onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    
    [super requestWithPath:MAIN_BC_EDIT
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

-(void)requestBCStoryImageDeleteWithParam:(NSMutableDictionary*)param
                        withIndicatorView:(UIView*)view
                      withCancelRequestID:(NSString*)requestID
                           withHttpMethod:(kHTTPMethod)httpMethod
                          onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
                          onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:MAIN_STORY_DELETE
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
 *  商家show我的故事保存      bcShow/saveMyStory
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
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{
    [super requestWithPath:MAIN_STORY_SAVE
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
 *  商家show我的故事编辑1      bcShow/editMyStory
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
                   onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock{

    [super requestWithPath:MAIN_STORY_EDIT
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
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:MAIN_AD_DETAIL
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
                onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:COLLECTION_IMAGE
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
                  onRequestFailed:(void(^)(MKNetworkOperation *operation ,NSError *error ))onFailedBlock {
    [super requestWithPath:COLLECTION_CANCEL
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
 *  获取缓存数据
 *
 *  @return 
 */
- (NSMutableDictionary *)getLocalCache
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    if ([DATA_CATHE hasObjectInCacheByKey:MainAsCcImageKey]) {
        NSMutableArray * carbeautyArr = [NSMutableArray array];
        [carbeautyArr addObjectsFromArray:[DATA_CATHE getCachedObjectByKey:MainAsCcImageKey]];
        [dic setObject:carbeautyArr forKey:MainAsCcImageKey];
    }
    if ([DATA_CATHE hasObjectInCacheByKey:MainAsBcImageKey]) {
        NSMutableArray * carbeautyArr = [NSMutableArray array];
        [carbeautyArr addObjectsFromArray:[DATA_CATHE getCachedObjectByKey:MainAsBcImageKey]];
        [dic setObject:carbeautyArr forKey:MainAsBcImageKey];
    }
    if ([DATA_CATHE hasObjectInCacheByKey:MainMaterialImageKey]) {
        NSMutableArray * carkeepupArr = [NSMutableArray array];
        [carkeepupArr addObjectsFromArray:[DATA_CATHE getCachedObjectByKey:MainMaterialImageKey]];
        [dic setObject:carkeepupArr forKey:MainMaterialImageKey];
    }

    if ([DATA_CATHE hasObjectInCacheByKey:MainAdImgKEY]) {
        NSMutableArray * circleImgArr = [NSMutableArray array];
        [circleImgArr addObjectsFromArray:[DATA_CATHE getCachedObjectByKey:MainAdImgKEY]];
        [dic setObject:circleImgArr forKey:MainAdImgKEY];
    }
    return dic;
}

@end
