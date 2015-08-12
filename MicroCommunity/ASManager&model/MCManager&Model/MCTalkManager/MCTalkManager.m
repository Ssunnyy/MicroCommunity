//
//  MCTalkManager.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkManager.h"

@implementation MCTalkManager

static MCTalkManager *defaultCenterInstance = nil;

/**
 *  @brief  创建MCTalkManager的manager
 **/

+ (MCTalkManager *)shareManager
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
