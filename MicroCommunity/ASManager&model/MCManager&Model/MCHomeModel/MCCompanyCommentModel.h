//
//  MCCompanyCommentModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCCompanyCommentModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *pariseCount;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *isParise;//是不是评论过



@property (nonatomic, strong) NSString *goods_comment_content;
@property (nonatomic, strong) NSString *goods_comment_time;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *comment_content;
@property (nonatomic, strong) NSString *comment_time;


@end
