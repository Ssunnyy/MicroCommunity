//
//  MCTalkListHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListHeadView.h"

@interface MCTalkListHeadView()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *people_updateLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tinLabLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@end

@implementation MCTalkListHeadView


- (void)awakeFromNib {
    
    _btnWidth.constant = SCREEN_WIDTH / 2;
    
//    float height = 180;
//    if (iPhone6) {
//        height = 212;
//    }else if (iPhone6Plus){
//        height = 234;
//    }
//    self.frameheight = height;
    
}


- (IBAction)new_hotAction:(UIButton *)sender {
    
    __weak MCTalkListHeadView *weak = self;
    
    switch (sender.tag) {
        case 100:
        {
            _tinLabLeft.constant = 0;
        }
            break;
        case 101:
        {
            _tinLabLeft.constant = SCREEN_WIDTH / 2;

        }
            break;
        default:
            break;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [weak layoutIfNeeded];
    }];
    
    if ([_delegate respondsToSelector:@selector(selectTabAtIndex:)]) {
        [_delegate selectTabAtIndex:sender.tag];
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
