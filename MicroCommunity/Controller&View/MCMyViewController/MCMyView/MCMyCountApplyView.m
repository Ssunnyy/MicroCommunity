//
//  MCMyCountApplyView.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountApplyView.h"

@interface MCMyCountApplyView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *payCount;


@end

@implementation MCMyCountApplyView

- (void)awakeFromNib {
    
    _money.delegate = self;
    _userName.delegate = self;
    _payCount.delegate = self;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    self.framebottom = SCREEN_HEIGHT - height;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.frametop = (SCREEN_HEIGHT - self.frameheight) / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)oKOrCancel:(UIButton *)sender {
    [self hidenApply];
    if (sender.tag == 301) {
        if (_delegate && [_delegate respondsToSelector:@selector(myCountApplyClick: andMoney:andName:andPay:)]) {
            [_delegate myCountApplyClick:sender.tag andMoney:_money.text andName:_userName.text andPay:_payCount.text];
        }
    }else {
        [self resignFirstResponde];
    }
}

- (void) showApply{
    
    __weak MCMyCountApplyView *weak = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak.hidden = NO;
    }];
    
}

- (void) hidenApply{
    
    __weak MCMyCountApplyView *weak = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak.hidden = YES;
    }];
    
}

- (void) resignFirstResponde {

    [_payCount resignFirstResponder];
    [_money resignFirstResponder];
    [_userName resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void) removeKeyboardLison {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
