//
//  MCCompanyCommentModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyCommentModel.h"

@implementation MCCompanyCommentModel

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
