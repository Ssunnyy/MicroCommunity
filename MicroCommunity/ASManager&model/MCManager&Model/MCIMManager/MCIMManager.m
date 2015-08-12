//
//  MCIMManager.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMManager.h"

@implementation MCIMManager

static MCIMManager *defaultCenterInstance = nil;

/**
 *  @brief  创建MCIMManager的manager
 **/

+ (MCIMManager *)shareManager
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
