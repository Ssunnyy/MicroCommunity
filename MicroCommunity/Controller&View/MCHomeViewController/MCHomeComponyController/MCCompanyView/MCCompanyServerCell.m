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

- (void)configCellWithMCCompanyServerModel:(MCCompanyServerModel *)model {

    [_headImaege sd_setImageWithURL:[NSURL URLWithString:model.serverPic] placeholderImage:ImageNamed(@"")];
    _serverName.text = model.serverName;
    _priceLab.text = model.serverPic;
    _contentLab.text = model.serverIntro;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
