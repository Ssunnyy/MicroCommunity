//
//  DataEnvironment.m
//  iTotemFrame
//
//  Copyright 2010 itotem. All rights reserved.
//


#import "ITTDataEnvironment.h"
#import "ITTDataCacheManager.h"
#import "ITTNetworkTrafficManager.h"
#import "ITTObjectSingleton.h"
#import "Reachability.h"


@interface ITTDataEnvironment()
- (void)restore;
- (void)registerMemoryWarningNotification;
@end
@implementation ITTDataEnvironment

#define REQUEST_DOMAIN @""// default env


ITTOBJECT_SINGLETON_BOILERPLATE(ITTDataEnvironment, sharedDataEnvironment)
#pragma mark - lifecycle methods
- (id)init
{
    self = [super init];
	if ( self) {
		[self restore];
        [self registerMemoryWarningNotification];
	}
	return self;
}

-(void)clearNetworkData
{
    [[ITTDataCacheManager sharedManager] clearAllCache];
}

#pragma mark - public methods

- (void)clearCacheData
{
    //clear cache data if needed
}

#pragma mark - private methods

- (void)restore
{
    _urlRequestHost = REQUEST_DOMAIN;
}

- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearCacheData)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];    
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCacheData)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif        
}

- (void)restoreReachability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateDidChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [self updateNetwordStatus:reachability.currentReachabilityStatus];
    [reachability startNotifier];
}

- (void)updateNetwordStatus:(NetworkStatus)status
{
    switch (status)
    {
        case ReachableViaWiFi:
            _netType = @"wifi";
            break;
        case ReachableViaWWAN:
            _netType = @"3g";
            break;
        case NotReachable:
            _netType = @"unavailable";
            break;
        default:
            _netType = @"unknown";
            break;
    }
}

- (void)networkStateDidChanged:(Reachability*)reachability
{
    ITTDINFO(@"networkStateDidChanged");
    [self updateNetwordStatus:reachability.currentReachabilityStatus];
}

@end