//
//  MCRecruitMainCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitMainCell.h"

@interface MCRecruitMainCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end

@implementation MCRecruitMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configCellWithMCHomeZhaoPingModel:(MCHomeZhaoPingModel *)model {

    [_headView sd_setImageWithURL:[NSURL URLWithString:model.seller_image] placeholderImage:ImageNamed(default_head)];
    _titleLab.text = model.zhaopin_title;
    _dataLab.text = model.zhaopin_time;
    _priceLab.text = model.zhaopin_money;
    _contenLab.text = model.zhaopin_content;
    
}

@end
