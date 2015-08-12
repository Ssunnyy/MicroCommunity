//
//  ASCityCell.m
//  ITotem
//
//  Created by qiuyan on 15-4-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASCityCell.h"


@interface ASCityCell ()
{

    __weak IBOutlet NSLayoutConstraint *lineViewHeight;
}
@property (nonatomic, strong) IBOutlet UILabel *cityLab;
@property (nonatomic, strong) IBOutlet UIImageView *locationImg;

@end

@implementation ASCityCell

- (void)awakeFromNib
{
    lineViewHeight.constant = 0.5;
}

- (void)setContentCell:(ASCityModel *)model
{
    self.cityLab.text = model.cityCn;
}

- (void)setLocationimgShow
{
    _locationImg.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
