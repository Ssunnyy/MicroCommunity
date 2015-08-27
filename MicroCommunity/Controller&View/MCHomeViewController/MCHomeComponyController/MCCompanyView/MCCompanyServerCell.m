//
//  MCCompanyServerCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyServerCell.h"

@interface MCCompanyServerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImaege;
@property (weak, nonatomic) IBOutlet UILabel *serverName;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;


@end

@implementation MCCompanyServerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configCellWithMCProductModel:(MCProductModel *)model {

    [_headImaege sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:ImageNamed(default_head)];
    _serverName.text = model.goods_name;
    _priceLab.text = model.goods_price;
    _contentLab.text = model.goods_message;
    
}

- (void)configCellWithMCMyCollectProductModel:(MCMyCollectProductModel *)model {

    [_headImaege sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:ImageNamed(default_head)];
    _serverName.text = model.goods_name;
    
    if ([model.goods_price floatValue] > 10000) {
        _priceLab.text = [NSString stringWithFormat:@"%f万元",[model.goods_price floatValue] / 10000];
    } else {
        _priceLab.text = [NSString stringWithFormat:@"%@元",model.goods_price];
    }
    _contentLab.text = model.goods_message;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
