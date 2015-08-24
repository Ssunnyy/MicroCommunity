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
             @"comment_content":@"comment_content",
             @"comment_head_image":@"comment_head_image",
             @"comment_id":@"comment_id",
             @"comment_time":@"comment_time",
             @"comment_talk_id":@"comment_talk_id",
             @"comment_nickname":@"comment_nickname",
             @"comment_uid":@"comment_uid",
             @"status":@"status",
             @"isParise":@"isParise"
             };
    
}
@end
