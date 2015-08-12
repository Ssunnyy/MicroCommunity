//
//  MCImPersonHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCImPersonHeadView.h"

@interface MCImPersonHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *cityId;

@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *xingzuoLab;
@property (weak, nonatomic) IBOutlet UILabel *collegeLab;
@property (weak, nonatomic) IBOutlet UILabel *jobLab;
@property (weak, nonatomic) IBOutlet UILabel *likeMove;
@property (weak, nonatomic) IBOutlet UILabel *likeBookl;
@property (weak, nonatomic) IBOutlet UILabel *like;

@end

@implementation MCImPersonHeadView

- (void)awakeFromNib {
    // Initialization code
    [_headImage makeCircleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
