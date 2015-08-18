//
//  MCSendMessageView.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCSendMessageView.h"

@interface MCSendMessageView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *contentField;


@end

@implementation MCSendMessageView

- (void)awakeFromNib {

    _contentField.delegate = self;
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
    self.framebottom = SCREEN_HEIGHT;
}

- (IBAction)sendAction:(id)sender {
    
    if (_contentField.text.length <= 0) {
        [ITTPromptView showMessage:@"评论内容不能为空"];
        return;
    }
    [_contentField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)]) {
        [_delegate sendMessage:_contentField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void) removeKeyboardLison {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cleafData {

    _contentField.text = @"";
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
