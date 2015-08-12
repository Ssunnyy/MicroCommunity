//
//  MCSerachResultCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCSerachResultCell.h"

@interface MCSerachResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *componyName;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation MCSerachResultCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)shopBtnClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(inType:AtIndex:)]) {
        [_delegate inType:sender.tag AtIndex:self.tag];
    }
}


@end
