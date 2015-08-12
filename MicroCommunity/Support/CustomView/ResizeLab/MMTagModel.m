//
//  MMTagModel.m
//  Mimi
//
//  Created by wangjiangjiao on 14-6-5.
//
//

#import "MMTagModel.h"

@implementation MMTagModel

- (NSDictionary *)attributeMapDictionary
{
    return @{
             @"tagID": @"id",
             @"tagName":@"name"
             };
}

@end
