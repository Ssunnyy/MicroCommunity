//
//  ASBCStoryModel.m
//  ITotem
//
//  Created by adims on 15/3/16.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASBCStoryModel.h"

@implementation ASBCStoryModel

- (NSDictionary *)attributeMapDictionary {
    return @{
             @"appUserId":@"appUserId",
             @"desc":@"description",
             @"ids":@"id",
             @"storyImg":@"storyImg",
             @"collect":@"collect"
             };
}

@end
