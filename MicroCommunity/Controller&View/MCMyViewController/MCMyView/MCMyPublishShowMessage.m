//
//  MCMyPublishShowMessage.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyPublishShowMessage.h"

@interface MCMyPublishShowMessage ()


@property (weak, nonatomic) IBOutlet UILabel *messageLab;

@end

@implementation MCMyPublishShowMessage

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeMessage:(NSString *)message {
    _messageLab.text = message;
}
- (IBAction)btnClick:(UIButton *)sender {
    
    [self hidenMessage];
    if (_delegate && [_delegate respondsToSelector:@selector(sureOrCancel:)] ) {
        [_delegate sureOrCancel:sender.tag];
    }
}

- (void) showMessage{
    
    __weak MCMyPublishShowMessage *weak = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak.hidden = NO;
    }];
    
}

- (void) hidenMessage{
    
    __weak MCMyPublishShowMessage *weak = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak.hidden = YES;
    }];
    
}

@end
