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
             @"isParise":@"isParise",
             
             @"goods_comment_content":@"goods_comment_content",
             @"goods_comment_time":@"goods_comment_time",
             @"image":@"image",
             @"nickname":@"nickname",
             
             @"comment_content":@"comment_content",
             @"comment_time":@"comment_time",
             
             };
}

@end
