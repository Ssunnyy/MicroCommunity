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

//    [_headImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:ImageNamed(default_head)];
//    [_bgImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:ImageNamed(@"")];
//    
//    _nickNam.text = @"";
//    _name.text = @"";
//    _cityId.text = @"";
//    _phoneNum.text = @"";
//    _recruitData.text = @"";
//    _seeCount.text = @"";
//    
//    _educLab.text = @"";
//    _workYear.text = @"";
    _like.text = model.likeStirng;
    _detailLab.text = model.detail;
    
    
    CGSize likeheight = [model.likeStirng calculateSize:CGSizeMake(self.like.frame.size.width, FLT_MAX) font:self.like.font];
    
    if (likeheight.height > 17) {
        _view2Height.constant = _view2Height.constant - 17 + likeheight.height;
    }
    
    CGSize intrHeight = [model.detail calculateSize:CGSizeMake(self.detailLab.frame.size.width, FLT_MAX) font:self.detailLab.font];
    
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
