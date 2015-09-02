//
//  TableViewCell.m
//  MicroCommunity
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCComDetailHeadView.h"

#import "MCHomeSearchModel.h"


@interface MCComDetailHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tinLabLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@end

@implementation MCComDetailHeadView

- (void)awakeFromNib {
    
    _btnWidth.constant = SCREEN_WIDTH / 3;
    [_messageView makeCircleView];
}

- (IBAction)btnClick:(UIButton *)sender {
    
    __weak MCComDetailHeadView *weak = self;
    switch (sender.tag) {
        case 100:
        {
            _tinLabLeft.constant = 0;
            _btn1.selected = YES;
            _btn2.selected = NO;
            _btn3.selected = NO;
        }
            break;
        case 101:
        {
            _tinLabLeft.constant = SCREEN_WIDTH / 3;
            _btn1.selected = NO;
            _btn2.selected = YES;
            _btn3.selected = NO;
        }
            break;
        case 102:
        {
            _tinLabLeft.constant = SCREEN_WIDTH / 3 * 2;
            _btn1.selected = NO;
            _btn2.selected = NO;
            _btn3.selected = YES;
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
    
    
    if (_delgate && [_delgate respondsToSelector:@selector(headViewClickAtIndex:)]) {
        [_delgate headViewClickAtIndex:sender.tag];
    }
}

- (void) configHeadWithMCHomeSearchModel:(MCHomeSearchModel *) model {
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.seller_image] placeholderImage:ImageNamed(default_iconImag)];
    if ([model.comment_number intValue] > 99) {
        _messageLab.text = @"99";
    }else{
        _messageLab.text = [NSString stringWithFormat:@"%d",[model.comment_number intValue]];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
