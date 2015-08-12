//
//  MCCompanyCommentView.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyCommentView.h"

@interface MCCompanyCommentView ()<UITextViewDelegate>

{
    float keyHeight;
}

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *placehoder;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *senderBtn;

@end

@implementation MCCompanyCommentView

- (void)awakeFromNib {
    
    _textView.delegate = self;
    [_bottomView makeCornerRadius:10];
    [_bottomView setBorderWidth:1 andBorderColor:RGBACOLOR(237, 237, 237, 1)];
    [_textView setBorderWidth:1 andBorderColor:RGBACOLOR(237, 237, 237, 0.8)];
    
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
    
    self.hidden = YES;
    [self hidenSelf];
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
    keyHeight = height;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.frametop = SCREEN_HEIGHT;
}

#pragma  mark  --  UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _placehoder.hidden = YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        _placehoder.hidden = YES;
    }else{
        _placehoder.hidden = NO;
    }
}
- (IBAction)sendAction:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)]) {
        [_delegate sendMessage:_textView.text];
    }
    [_textView resignFirstResponder];
}

- (void) hidenSelf {

    
    MCCompanyCommentView *weak = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        weak.frametop = SCREEN_HEIGHT;
    }];
    
    [self clear];
}

- (void) showSelf {

    MCCompanyCommentView *weak = self;
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        weak.framebottom = SCREEN_HEIGHT - keyHeight;
    }];
    
}

- (void) clear {

    _textView.text = @"";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void) removeKeyboardLison {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
