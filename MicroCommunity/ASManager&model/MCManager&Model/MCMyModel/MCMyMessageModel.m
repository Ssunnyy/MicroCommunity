//
//  MCMyMessageModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyMessageModel.h"

@implementation MCMyMessageModel

- (NSDictionary *)attributeMapDictionary {
    
    return @{
             @"messageId":@"messageId",
             @"message":@"message",
             @"messageDate":@"messageDate",
             };
}

@end
