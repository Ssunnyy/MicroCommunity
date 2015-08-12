//
//  MCCompanyBottomView.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyBottomView.h"

@interface MCCompanyBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *brn3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@end

@implementation MCCompanyBottomView

- (void)awakeFromNib {

    _btnWidth.constant = SCREEN_WIDTH / 3;
    
}

- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
        {
            [_btn1 setBackgroundColor:RGBCOLOR(58, 58, 58)];
            [_btn2 setBackgroundColor:RGBCOLOR(104, 188, 99)];
            [_brn3 setBackgroundColor:RGBCOLOR(104, 188, 99)];
        }
            break;
        case 101:
        {
            [_btn1 setBackgroundColor:RGBCOLOR(104, 188, 99)];
            [_btn2 setBackgroundColor:RGBCOLOR(58, 58, 58)];
            [_brn3 setBackgroundColor:RGBCOLOR(104, 188, 99)];
        }
            break;
        case 102:
        {
            [_btn1 setBackgroundColor:RGBCOLOR(104, 188, 99)];
            [_btn2 setBackgroundColor:RGBCOLOR(104, 188, 99)];
            [_brn3 setBackgroundColor:RGBCOLOR(58, 58, 58)];
        }
            break;
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(btnClickAtIndex:)]) {
        [_delegate btnClickAtIndex:sender.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
