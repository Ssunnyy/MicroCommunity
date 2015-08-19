//
//  ITTBaseManager.m
//  YiXin
//
//  Created by keke on 14/11/20.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "ITTBaseRequestManager.h"
#import "MBProgressHUD.h"

@interface ITTBaseRequestManager ()
@property (nonatomic , strong) UIActivityIndicatorView * activityView;
@property(nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic, strong) UIView *alphaV;
@property (nonatomic, strong) UIView *superView;

@end

@implementation ITTBaseRequestManager
@synthesize reqestsDic = _reqestsDic;
static ITTBaseRequestManager *defaultCenterInstance = nil;
+(ITTBaseRequestManager*)shareManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultCenterInstance = [[self alloc] init];
        });
    }
    return defaultCenterInstance;
}

- (id)init
{
    self = [super init];
	if (self) {
//        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	}
	return self;
}


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
{
    //对url进行操作
    NSString* finalPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //绑定ID
    [self setReqestUrl:path withID:requestID];


    ITTMKNetWorkOperation * operation;
    if (useSSL) {
        operation = (ITTMKNetWorkOperation*)[engine operationWithPath:finalPath params:param httpMethod:[self getHTTPMethod:httpMethod] ssl:YES];
        operation.shouldContinueWithInvalidCertificate =YES;
    }else
    {
        operation = (ITTMKNetWorkOperation*)[engine operationWithPath:finalPath params:param httpMethod:[self getHTTPMethod:httpMethod]];
    }
    if (files) {
        for (NSData* data in files) {
            [operation addData:data forKey:@"image"];
        }
    }
    if (view) {
        if (!_alphaV) {
            _alphaV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _alphaV.backgroundColor = [UIColor clearColor];
            [view addSubview:_alphaV];
        }
    self.superView = view;
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    self.hud.alpha = 0.7;
    self.hud.userInteractionEnabled = NO;
    self.hud.labelFont=[UIFont boldSystemFontOfSize:15];
    self.hud.yOffset=-10;
    self.hud.labelText = @"努力加载中";
        
        // YES代表需要蒙版效果
//        self.hud.dimBackground = YES;
//        if (!_activityView) {
//            _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        }
//        _activityView.frame = CGRectMake(view.framewidth/2-25, view.frameheight/2-25, 50, 50);
//        [_activityView setHidesWhenStopped:YES];
//        [_activityView setColor:[UIColor grayColor]];
//        [view addSubview:_activityView];
//        [_activityView startAnimating];
    }
//    YXBaseOperation * operation = (YXBaseOperation*)[_engine operationWithPath:finalPath params:param httpMethod:[self getHTTPMethod:httpMethod]];
//    YXBaseOperation * operation = [_netWorkEngine operationWithPath:finalPath params:param httpMethod:[self getHTTPMethod:httpMethod] ssl:YES];

    __weak ITTBaseRequestManager * weakself = self;

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
    {
//        [MBProgressHUD hideHUDForView:view animated:NO];
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        [_alphaV removeFromSuperview];
        _alphaV = nil;
        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache %@", [completedOperation responseString]);
        }
        else {
            DLog(@"Data from server %@", [completedOperation responseString]);
        }

        if (completedOperation) {
            onFinishedBlock(completedOperation);
        }

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
//        [MBProgressHUD hideHUDForView:view animated:NO];
        [_alphaV removeFromSuperview];
        _alphaV = nil;
//        if (weakself.activityView) {
//            if(weakself.activityView.isAnimating)
//            {
//                [weakself.activityView stopAnimating];
//            }
//        }
        if (completedOperation && error) {
            onFailedBlock(completedOperation,error);
            [MBProgressHUD hideAllHUDsForView:view animated:YES];

//            [MBProgressHUD hideHUDForView:view animated:NO];
//            [_alphaV removeFromSuperview];
//            _alphaV = nil;
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:error.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
    }];
    [engine enqueueOperation:operation];
}

-(void)setReqestUrl:(NSString*)path withID:(NSString*)reqestID
{
    [self.reqestsDic safeString:path ForKey:reqestID];
}

-(NSString*)getHTTPMethod:(kHTTPMethod)method
{
    switch (method) {
        case kHTTPMethodGet:
            return @"GET";
            break;
        case kHTTPMethodPost:
            return @"POST";
            break;
        case kHTTPMethodDelete:
            return @"DELETE";
            break;
        case kHTTPMethodPut:
            return @"PUT";
            break;
        default:
            return @"GET";
            break;
    }
}
-(void)cancelRequestWithID:(NSString*)requestID finishCancel:(void(^)(void))cacelBlock;
{
    __weak ITTBaseRequestManager * weakself = self;
    [ITTMKNetworkEngine cancelOperationsMatchingBlock:^BOOL (MKNetworkOperation* op) {
        BOOL isReadyToCancel = [[op.readonlyRequest.URL absoluteString] rangeOfString:[weakself.reqestsDic objectForKey:requestID]].location != NSNotFound;
        return isReadyToCancel;
    }];
    [MBProgressHUD hideAllHUDsForView:self.superView animated:YES];
    [self.hud removeFromSuperview];
    [_alphaV removeFromSuperview];
    if (cacelBlock) {
        cacelBlock();
    }
}
-(void)cancelAllRequestWithEngine:(ITTMKNetworkEngine *)engine withCancelBlock:(void(^)(void))cacelBlock
{
    
    
    [MBProgressHUD hideAllHUDsForView:self.superView animated:YES];
    [engine cancelAllOperations];
    [self.hud removeFromSuperview];
    [_alphaV removeFromSuperview];
    if (cacelBlock) {
        cacelBlock();
    }
}

-(NSMutableDictionary*)getUrlBody:(NSMutableDictionary*)dic
{
    NSMutableDictionary* finaldic = [NSMutableDictionary dictionaryWithDictionary:dic];
    return finaldic;
}

@end
