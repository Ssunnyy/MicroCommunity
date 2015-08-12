//
//  MCTalkPariseModel.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkPariseModel.h"

@implementation MCTalkPariseModel

- (NSDictionary *)attributeMapDictionary {
    
    return @{
             @"nickName":@"nickName",
             @"headImage":@"headImage",
             @"comment":@"comment",
             @"pariseCount":@"pariseCount",
             @"date":@"date",
             @"isParise":@"isParise"
             };
}
@end
