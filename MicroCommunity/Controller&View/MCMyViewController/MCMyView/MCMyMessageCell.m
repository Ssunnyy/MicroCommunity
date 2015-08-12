//
//  MCMyMessageCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyMessageCell.h"

@interface MCMyMessageCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@end

@implementation MCMyMessageCell

- (void)awakeFromNib {
    
    [_bgView makeCornerRadius:10];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithMCMyMessageModel:(MCMyMessageModel *)model {

    _contenLab.text = model.message;
//    _dataLab.text = model.messageDate;
    
}

@end
