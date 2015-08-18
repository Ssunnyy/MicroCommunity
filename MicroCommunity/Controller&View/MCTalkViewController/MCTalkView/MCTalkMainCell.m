//
//  MCTalkMainCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkMainCell.h"

@interface MCTalkMainCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *peopleAndUpdate;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation MCTalkMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithMCTalkMainModel:(MCTalkMainModel *)modle {

    [_headImage sd_setImageWithURL:[NSURL URLWithString:modle.bar_image] placeholderImage:ImageNamed(@"")];
    _titleLab.text = modle.bar_title;
    _contenLab.text = modle.bar_content;
    _peopleAndUpdate.text = [NSString stringWithFormat:@"参与人数：%@/今日更新：%@",modle.bar_people_number,modle.bar_number];
    _timeLab.text = [[modle.creat_time componentsSeparatedByString:@" "]objectAtIndex:0];
}

@end
