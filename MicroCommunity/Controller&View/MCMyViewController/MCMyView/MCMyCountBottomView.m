//
//  MCMyCountBottomView.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountBottomView.h"

@implementation MCMyCountBottomView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)button:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClickAtIndex:)]) {
        [_delegate buttonClickAtIndex:sender.tag];
    }
}

@end
