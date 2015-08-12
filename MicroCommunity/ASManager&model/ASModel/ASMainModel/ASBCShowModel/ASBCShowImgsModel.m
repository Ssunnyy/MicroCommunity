//
//  ASBCShowImgsModel.m
//  ITotem
//
//  Created by adims on 15/3/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASBCShowImgsModel.h"

@implementation ASBCShowImgsModel

- (NSDictionary *)attributeMapDictionary {

    return @{
             @"bcShowImgsId":@"bcShowImgsId",
             @"cover":@"cover",
             @"des":@"description",
             @"ids":@"id",
             @"img":@"img",
             @"updateTime":@"updateTime",
             @"uploadTime":@"uploadTime",
             @"collect":@"collect"
             };
}

@end
