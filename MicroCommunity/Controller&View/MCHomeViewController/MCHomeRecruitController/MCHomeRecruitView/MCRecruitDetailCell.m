//
//  MCCompanyCommentCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitDetailCell.h"

@interface MCRecruitDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *nickNam;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cityId;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;

@property (weak, nonatomic) IBOutlet UILabel *recruitName;
@property (weak, nonatomic) IBOutlet UILabel *recruitPrice;
@property (weak, nonatomic) IBOutlet UILabel *recruitData;
@property (weak, nonatomic) IBOutlet UILabel *seeCount;

@property (weak, nonatomic) IBOutlet UILabel *educLab;
@property (weak, nonatomic) IBOutlet UILabel *workYear;


@end

@implementation MCRecruitDetailCell

- (void)awakeFromNib {
    // Initialization code
    [_headImage makeCircleView];
}

- (void)configCellWithMCCompanyCommentModel:(MCRecruitModel *)model {

    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.image]
                  placeholderImage:ImageNamed(default_head)];
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(default_iconImag)];
    
    _nickNam.text = model.nickname;
    _name.text = model.username;
    _cityId.text = model.city_id;
    _phoneNum.text = model.phone;
    _recruitData.text = model.job_time;
    _seeCount.text = model.job_view_number;
    _recruitPrice.text = [NSString stringWithFormat:@"￥%@/月",model.job_salary];
    _recruitName.text = model.job_title;
    _educLab.text = model.education;
    _workYear.text = [NSString stringWithFormat:@"%@ 年",model.job_year];
    _like.text = model.strong_demo;
    _detailLab.text = model.job_content;
    
    
    CGSize likeheight = [model.strong_demo calculateSize:CGSizeMake(self.like.frame.size.width, FLT_MAX) font:self.like.font];
    
    if (likeheight.height > 17) {
        _view1Height.constant = _view1Height.constant - 17 + likeheight.height;
    }
    
    CGSize intrHeight = [model.job_content calculateSize:CGSizeMake(self.detailLab.frame.size.width, FLT_MAX) font:self.detailLab.font];
    
    if (intrHeight.height > 67) {
        _view2Height.constant = _view2Height.constant - 67 + intrHeight.height;
    }
    

    __weak MCRecruitDetailCell *weak = self;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [weak layoutIfNeeded];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
