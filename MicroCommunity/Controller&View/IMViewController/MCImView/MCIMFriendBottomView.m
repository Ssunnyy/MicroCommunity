//
//  MCIMFriendBottomView.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMFriendBottomView.h"

@interface MCIMFriendBottomView ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@end

@implementation MCIMFriendBottomView

- (void)awakeFromNib {
    
    _btnWidth.constant = SCREEN_WIDTH / 3;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (IBAction)btnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickAtIndex:)]) {
        [_delegate clickAtIndex:sender.tag];
    }
}

- (void)changeToTwoBtn {

    _btnWidth.constant = SCREEN_WIDTH / 2;
    [_firstBtn setTitle:@"清楚记录" forState:UIControlStateNormal];
    [_secondBtn setTitle:@"删除好友" forState:UIControlStateNormal];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}

@end
