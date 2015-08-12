//
//  MCTalkListModel.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListModel.h"

@implementation MCTalkListModel

- (NSDictionary *)attributeMapDictionary {
    
    return @{
             @"nickName":@"nickName",
             @"title":@"title",
             @"date":@"date",
             @"headImage":@"headImage",
             @"praiseCount":@"praiseCount",
             @"commentCount":@"commentCount",
             @"content":@"content",
             @"images":@"images"
             };
}

@end
