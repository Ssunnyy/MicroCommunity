//
//  MCMyFriendHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyFriendHeadView.h"

@interface MCMyFriendHeadView ()

@property (weak, nonatomic) IBOutlet UIButton *newsfriendBtn;

@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *newsFriendCount;

@end

@implementation MCMyFriendHeadView

- (void)awakeFromNib {

    _btnWidth.constant = SCREEN_WIDTH / 3;
    [_countView makeCircleView];
    
}

- (IBAction)changeBtn:(UIButton *)sender {

    switch (sender.tag) {
        case 300:
        {
            [_newsfriendBtn setTitleColor:RGBACOLOR(104, 188, 99,1) forState:UIControlStateNormal];
            [_friendBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            [_phoneBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            _lineLeft.constant = 0;
        }
            break;
        case 301:
        {
            [_newsfriendBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            [_friendBtn setTitleColor:RGBACOLOR(104, 188, 99,1) forState:UIControlStateNormal];
            [_phoneBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            _lineLeft.constant = SCREEN_WIDTH / 3;
        }
            break;
        case 302:
        {
            [_newsfriendBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            [_friendBtn setTitleColor:RGBCOLOR(58, 58, 58) forState:UIControlStateNormal];
            [_phoneBtn setTitleColor:RGBACOLOR(104, 188, 99,1) forState:UIControlStateNormal];
            _lineLeft.constant = SCREEN_WIDTH / 3 * 2;
        }
            break;
        default:
            break;
    }
    
    __weak MCMyFriendHeadView *weak = self;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [weak layoutIfNeeded];
    }];
    
    if (_delegate  && [_delegate respondsToSelector:@selector(btnClickAtIndex:)]) {
        [_delegate btnClickAtIndex:sender.tag];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
