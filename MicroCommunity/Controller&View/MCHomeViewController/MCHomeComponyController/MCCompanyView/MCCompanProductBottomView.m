//
//  MCCompanProductBottomView.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanProductBottomView.h"

@interface MCCompanProductBottomView ()

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userPhone;

@property (weak, nonatomic) IBOutlet UIButton *companyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLeft;

@end

@implementation MCCompanProductBottomView

- (void)awakeFromNib {
    float width = 120;
    if (iPhone6) {
        width = 130;
    }else if (iPhone6Plus){
        width = 150;
    }
    _firstBtnWidth.constant = width;
    _buttonWidth.constant = ( SCREEN_WIDTH - width ) / 3;
}


// 200 联系人 201 企业详情 202 通话 203 咨询
- (IBAction)btnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBtnClickAtIndex:)]) {
        [_delegate bottomBtnClickAtIndex:sender.tag];
    }
}

- (void)configUserInfoWithUerName:(NSString *)userName andConnect:(NSString *)telephone {

    _userName.text = userName;
    _userPhone.text = telephone;
}

- (void)hidenCompanyBtn {

    _companyBtn.hidden = YES;
    _buttonWidth.constant = ( SCREEN_WIDTH - _firstBtnWidth.constant ) / 2;
    _phoneLeft.constant = - _buttonWidth.constant;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
