//
//  MCRecruitMainCell1.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyNewFriendCell.h"

@interface MCMyNewFriendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIButton *receiveBtns;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickTop;
@end

@implementation MCMyNewFriendCell

- (void)awakeFromNib {
    
    [_headImage makeCircleView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)headImageClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(headImageClickAtIndex:)]) {
        [_delegate headImageClickAtIndex:sender.tag];
    }
    if (sender.tag >= 3000) {
        sender.enabled = NO;
    }
}
- (void)setBtnTag:(NSInteger)tag {

    _headBtn.tag = tag + 1000;
    _receiveBtns.tag = tag + 2000;
    _addBtn.tag = tag + 3000;
}

- (void)configCellWithType:(NSInteger)type {

    switch (type) {
        case 0:
        {
            _receiveBtns.hidden = NO;
            _addBtn.hidden = YES;
            _nickTop.constant = 8;
            _city.hidden = NO;
        }
            break;
        case 1:
        {
            _receiveBtns.hidden = YES;
            _addBtn.hidden = YES;
            _city.hidden = YES;
            _nickTop.constant = 20;
        }
            break;
        case 2:
        {
            
            _receiveBtns.hidden = YES;
            _addBtn.hidden = NO;
            _nickTop.constant = 8;
            _city.hidden = NO;
        }
            break;
        case 3:
        {
            
            _receiveBtns.hidden = YES;
            _addBtn.hidden = YES;
            _nickTop.constant = 8;
            _city.hidden = NO;
        }
            break;
        default:
            break;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
}

@end
