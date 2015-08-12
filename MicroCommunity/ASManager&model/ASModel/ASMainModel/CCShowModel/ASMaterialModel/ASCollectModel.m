//
//  ASCollectModel.m
//  ITotem
//
//  Created by adims on 15/4/8.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASCollectModel.h"

@implementation ASCollectModel

- (NSDictionary *)attributeMapDictionary {

    return @{
             @"appUserId":@"appUserId",
             @"collectSource":@"collectSource",
             @"collectType":@"collectType",
             @"collectedId":@"collectedId",
             @"ids":@"id",
             };
    
}

@end
