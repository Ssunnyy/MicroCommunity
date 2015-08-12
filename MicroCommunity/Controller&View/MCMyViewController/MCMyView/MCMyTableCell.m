//
//  MCMyTableCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyTableCell.h"

@interface MCMyTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end

@implementation MCMyTableCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configMyCellWithMCMyCellModel:(MCMyCellModel *)model isShowCount:(BOOL)show{
    
    _headImage.image = [UIImage imageNamed:model.myHeadPic];
    _nickName.text = model.myNickName;
    _desLab.hidden = !show;
    _desLab.text = model.myCount;
    self.tag = model.myId;
}

@end
