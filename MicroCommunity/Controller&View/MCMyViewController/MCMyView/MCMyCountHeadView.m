//
//  MCMyCountHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountHeadView.h"

@interface MCMyCountHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *addMoney;
@property (weak, nonatomic) IBOutlet UILabel *reduceMoney;
@property (weak, nonatomic) IBOutlet UILabel *money;

@end

@implementation MCMyCountHeadView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
