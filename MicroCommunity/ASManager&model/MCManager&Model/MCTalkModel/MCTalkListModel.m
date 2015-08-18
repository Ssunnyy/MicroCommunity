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
             @"bar_id":@"bar_id",
             @"comment_number":@"comment_number",
             @"content":@"content",
             @"head_image":@"head_image",
             @"praise_number":@"praise_number",
             @"status":@"status",
             @"talk_id":@"talk_id",
             @"talk_image":@"talk_image",
             @"talk_nickname":@"talk_nickname",
             @"talk_time":@"talk_time",
             @"talk_uid":@"talk_uid",
             @"images":@"images",
             };
}

@end
