//
//  MCMyHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyHeadView.h"

@interface MCMyHeadView ()


@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIButton *goldBtn;
@property (weak, nonatomic) IBOutlet UILabel *cityID;

@end

@implementation MCMyHeadView

- (void)awakeFromNib {
    // Initialization code
    
    [_headView makeCircleView];
    [_shopBtn makeCircleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)currentUerIsBusniss:(BOOL)isBussniss {

    _shopBtn.hidden = !isBussniss;
}

- (void)configHeadWithMCUserModel:(MCUserModel *)model {

    [_bgImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(default_iconImag)];
    [_headView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(default_head)];
    _nickName.text = model.username;
    
    if ([model.user_type isEqualToString:@"2"]) {
        _shopBtn.hidden = NO;
    }else {
        _shopBtn.hidden = YES;
    }
    
    [_goldBtn setTitle:[NSString stringWithFormat:@"金豆:%ld",[model.gold_number integerValue]] forState:UIControlStateNormal];
    _cityID.text = [NSString stringWithFormat:@"小城ID:%@",model.phone];
    
}
- (IBAction)shopBtnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(busnissBtnClickWithTag:)]) {
        [_delegate busnissBtnClickWithTag:sender.tag];
    }
}

@end
