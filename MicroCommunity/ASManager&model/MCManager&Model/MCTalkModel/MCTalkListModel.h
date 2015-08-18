//
//  MCTalkListModel.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCTalkListModel : ITTBaseModelObject


@property (nonatomic, strong) NSString *bar_id;
@property (nonatomic, strong) NSString *comment_number;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *head_image;
@property (nonatomic, strong) NSString *praise_number;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *talk_id;
@property (nonatomic, strong) NSString *talk_image;
@property (nonatomic, strong) NSString *talk_nickname;
@property (nonatomic, strong) NSString *talk_time;
@property (nonatomic, strong) NSString *talk_uid;


@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *praiseCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSMutableArray *images;

@end
