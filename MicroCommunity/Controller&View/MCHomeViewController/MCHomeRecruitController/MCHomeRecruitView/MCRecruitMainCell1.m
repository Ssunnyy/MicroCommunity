//
//  MCRecruitMainCell1.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitMainCell1.h"

@interface MCRecruitMainCell1 ()
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *city;
@end

@implementation MCRecruitMainCell1

- (void)awakeFromNib {
    
    [_headImage makeCircleView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellWithMCHomeRecruitModel:(MCHomeRecruitModel *)model {

    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:ImageNamed(default_head)];
    _titleLab.text = model.job_title;
    _dataLab.text = model.job_time;
    _contenLab.text = [NSString stringWithFormat:@"%@ %@ %@年工作经验",model.age,model.education,model.job_year];
    _city.text = model.region_name;
    
    if ([model.sex isEqualToString:@"男"]) {
        [_sexImage setImage:ImageNamed(@"sex_male.png")];
    } else {
        [_sexImage setImage:ImageNamed(@"sex_famale.png")];
    }
}


@end
