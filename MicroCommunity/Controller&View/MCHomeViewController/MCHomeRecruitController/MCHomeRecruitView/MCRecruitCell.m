//
//  MCRecruitCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitCell.h"

@interface MCRecruitCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@end

@implementation MCRecruitCell

- (void)awakeFromNib {
    
    _btnWidth.constant = SCREEN_WIDTH / 2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 300:
        {
            _btn1.selected = YES;
            _btn2.selected = NO;
            _labLeft.constant = 0;
        }
            break;
        case 301:
        {
            _btn1.selected = NO;
            _btn2.selected = YES;
            _labLeft.constant = SCREEN_WIDTH / 2;
        }
            break;
        default:
            break;
    }
    __weak MCRecruitCell *weak = self;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [weak layoutIfNeeded];
    }];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectAtIndex:)]) {
        [_delegate selectAtIndex:sender.tag];
    }
    
}

- (void) configCurrenTitle:(NSString *)title1 andRightBtn:(NSString *) title2 {

    [_btn1 setTitle:title1 forState:UIControlStateNormal];
    [_btn2 setTitle:title2 forState:UIControlStateNormal];
}

@end
