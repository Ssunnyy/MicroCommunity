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


@end
