//
//  YXBaseRequestManager.h
//  YiXin
//
//  Created by keke on 14/12/6.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "ITTBaseRequestManager.h"

#define PAGE_SIZE_NUBMER       20

//  默认图
#define default_Mater @"materDefault(1000)"
#define default_Main  @"main_default"
#define default_head  @"main_head"



//https://localhost:8443/yixiuge/test/1/01

//#define HostURL @"192.168.1.143:8888"
//#define OrderUrl @"http://192.168.1.143:8888"

//
//#define HostURL @"192.168.1.26:8080"
//#define OrderUrl @"http://192.168.1.26:8080"
//
//#define HostURL @"192.168.1.82:8080"
//#define OrderUrl @"http://192.168.1.82:8080"

#define LastUserId @"lastUserid"
//  测试外网地址

#define HostURL @"mcommunity.bjqttd.com/json.php/home/index"
#define OrderUrl @"http://app.ionly.net"

////  上线地址
//#define HostURL @"api.ionly.net"
//#define OrderUrl @"http://api.ionly.net"
//
//#define HostURL @"api.ionly.net"
//#define OrderUrl @"http://api.ionly.net"


@interface YXBaseRequestManager : ITTBaseRequestManager

-(void)requestWithPath:(NSString*)path
          withParamDic:(NSMutableDictionary*)param
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
withPostORDeleteMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

-(void)requestWithPath:(NSString*)path
          withParamArr:(NSMutableArray*)param
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
            withMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

-(void)requestWithPath:(NSString*)path
          withParamDic:(NSMutableDictionary*)param
           updateFiles:(NSMutableArray*)files
     withIndicatorView:(UIView*)view
   withCancelRequestID:(NSString*)requestID
withPostORDeleteMethod:(kHTTPMethod)httpMethod
             authToken:(NSString*)token
                 isSSL:(BOOL)useSSl
       onRequestFinish:(void(^)(MKNetworkOperation *operation))onFinishedBlock
       onRequestFailed:(void(^)(MKNetworkOperation *operation,NSError * error))onFailedBlock;

-(void)cancelRequestWithID:(NSString*)requestID finishCancel:(void(^)(void))cacelBlock;
-(void)cancelAllRequest;

@end
