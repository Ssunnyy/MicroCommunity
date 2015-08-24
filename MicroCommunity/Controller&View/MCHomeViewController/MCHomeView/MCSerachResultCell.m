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

- (void)configCellWithMCHomeSearchModel:(MCHomeSearchModel *)model withType:(NSInteger)type{

    if (type == 0) {
        [_headImage sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:ImageNamed(default_head)];
    }else if(type == 1){
        [_headImage sd_setImageWithURL:[NSURL URLWithString:model.seller_image] placeholderImage:ImageNamed(default_head)];
    }
    [_componyName setTitle:model.seller_name forState:UIControlStateNormal];
    _shopName.text = model.goods_name;
    if ([model.distance floatValue] > 1000) {
        _distance.text = [NSString stringWithFormat:@"%.2fkm",[model.distance floatValue] / 1000.0];
    }else {
        _distance.text = [NSString stringWithFormat:@"%@m",model.distance];
    }
    _location.text = model.address;
}

@end
