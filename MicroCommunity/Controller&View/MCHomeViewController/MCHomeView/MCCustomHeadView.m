//
//  MCCustomHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCustomHeadView.h"

@interface MCCustomHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@end

@implementation MCCustomHeadView


- (IBAction)pub_searchAction:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(customNavViewClickWithIndex:)]) {
        [_delegate customNavViewClickWithIndex:sender.tag];
    }
}

- (void)setTitleWithString:(NSString *)title {

    _titleLable.text = title;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
