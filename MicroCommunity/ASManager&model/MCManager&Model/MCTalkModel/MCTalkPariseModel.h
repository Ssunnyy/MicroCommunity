//
//  MCTalkPariseModel.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCTalkPariseModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *isParise;//是不是评论过

@property (nonatomic, strong) NSString *comment_content;
@property (nonatomic, strong) NSString *comment_head_image;
@property (nonatomic, strong) NSString *comment_id;
@property (nonatomic, strong) NSString *comment_nickname;
@property (nonatomic, strong) NSString *comment_talk_id;
@property (nonatomic, strong) NSString *comment_time;
@property (nonatomic, strong) NSString *comment_uid;
@property (nonatomic, strong) NSString *status;

@end
