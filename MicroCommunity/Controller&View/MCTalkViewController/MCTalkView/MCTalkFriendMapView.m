//
//  MCTalkFriendMapView.m
//  MicroCommunity
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkFriendMapView.h"

@interface MCTalkFriendMapView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;


@end

@implementation MCTalkFriendMapView

- (void)awakeFromNib {
    // Initialization code
    [_headImage makeCircleView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
