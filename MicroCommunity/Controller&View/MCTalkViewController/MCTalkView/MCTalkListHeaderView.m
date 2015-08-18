//
//  MCTalkListHeaderView.m
//  MicroCommunity
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListHeaderView.h"

@interface MCTalkListHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *people_updateLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tinLabLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@end

@implementation MCTalkListHeaderView

- (void)awakeFromNib {
    // Initialization code
    
    _btnWidth.constant = SCREEN_WIDTH / 2;
    if (iPhone6) {
        _topViewHeight.constant = 155;
    }else if (iPhone6Plus) {
        _topViewHeight.constant = 170;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)new_hotAction:(UIButton *)sender {
    
    __weak MCTalkListHeaderView *weak = self;
    
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

- (void)configHeadWithMCTalkMainModel:(MCTalkMainModel *)model {

    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.bar_image]placeholderImage:ImageNamed(@"")];
    _people_updateLab.text = [NSString stringWithFormat:@"参与人数：%@/今日更新：%@",model.bar_people_number,model.bar_number];
}

@end
