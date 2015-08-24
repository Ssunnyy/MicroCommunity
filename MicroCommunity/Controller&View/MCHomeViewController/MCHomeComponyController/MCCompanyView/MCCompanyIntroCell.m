//
//  MCCompanyIntroCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyIntroCell.h"

@interface MCCompanyIntroCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMa;

@end

@implementation MCCompanyIntroCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configCellWithInfoModel:(MCHomeSearchModel *)model {

    _userName.text = model.linkman;
    _phoneNum.text = model.linkphone;
    _address.text = model.address;
    _componyIntro.text = model.seller_content;
//    [_erWeiMa sd_setImageWithURL:[NSURL URLWithString:model.erweiMaUrl] placeholderImage:ImageNamed(@"erweiMa.png")];
    
    CGSize introHeight = [model.seller_content calculateSize:CGSizeMake(self.componyIntro.frame.size.width, FLT_MAX) font:self.componyIntro.font];
    
    if (introHeight.height > 29) {
        _introViewHeight.constant = 120 - 29 + introHeight.height - 30;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
