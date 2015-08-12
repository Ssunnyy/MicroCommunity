//
//  ASCCImageShowModel.m
//  ITotem
//
//  Created by adims on 15/3/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASCCImageShowModel.h"

@implementation ASCCImageShowModel

- (NSDictionary *)attributeMapDictionary {

    return @{
             @"imageUrl":@"imageUrl",
             @"appUserId":@"appUserId",
             @"des":@"description",
             @"ids":@"id",
             @"showImg":@"showImg",
             @"uplodaTime":@"uplodaTime",
             @"user":@"user",
             @"collect":@"collect"
             };
}

@end
