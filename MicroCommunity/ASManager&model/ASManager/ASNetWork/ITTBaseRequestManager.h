//
//  ITTBaseManager.h
//  YiXin
//
//  Created by keke on 14/11/20.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBaseEngine.h"
#import "ITTMKNetworkOperation.h"
#import "YXBaseOperation.h"



typedef enum
{
    kHTTPMethodPost,
    kHTTPMethodGet,
    kHTTPMethodDelete,
    kHTTPMethodPut,
}kHTTPMethod;

@interface ITTBaseRequestManager : NSObject
{
    
}
@property(nonatomic,strong)NSMutableDictionary * reqestsDic;
+(ITTBaseRequestManager*)shareManager;

-(void)requestWithPath:(NSString*)path
             useEngine:(ITTMKNetworkEngine*)engine
             withFiles:(NSMutableArray*)files
             withParam:(NSMutableDictionary*)param
          withIndicatorView:(UIView*)view
        withCancelRequestID:(NSString*)requestID
            withMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSL
            onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
            onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

-(void)cancelRequestWithID:(NSString*)requestID finishCancel:(void(^)(void))cacelBlock;

-(void)cancelAllRequestWithEngine:(ITTMKNetworkEngine *)engine withCancelBlock:(void(^)(void))cacelBlock;

-(NSMutableDictionary*)getUrlBody:(NSMutableDictionary*)dic;

-(void)setReqestUrl:(NSString*)path withID:(NSString*)reqestID;

-(NSString*)getHTTPMethod:(kHTTPMethod)method;


@end
