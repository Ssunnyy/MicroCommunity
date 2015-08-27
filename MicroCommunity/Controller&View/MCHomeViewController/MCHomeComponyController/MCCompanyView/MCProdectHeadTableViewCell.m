//
//  MCProdectHeadTableViewCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCProdectHeadTableViewCell.h"



@interface MCProdectHeadTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPric;
@property (weak, nonatomic) IBOutlet UILabel *pubDate;
@property (weak, nonatomic) IBOutlet UILabel *seeCount;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;


@end

@implementation MCProdectHeadTableViewCell

- (void)awakeFromNib {
    
    _sender = [[[NSBundle mainBundle] loadNibNamed:@"MCSendMessageView" owner:self options:nil]lastObject];
    _sender.framebottom = 64;
    _sender.framewidth = SCREEN_WIDTH;
    [self.senderView addSubview:_sender];
    
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithMCProductModel:(MCProductModel *)model {

    _productName.text = model.goods_name;
    _productPric.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    _pubDate.text = model.goods_add_time;
    _seeCount.text = model.goods_view_number;
    _addressLab.text = model.address;
    _descriptionLab.text = model.goods_message;
    
    CGSize introHeight = [model.goods_message calculateSize:CGSizeMake(self.descriptionLab.frame.size.width, FLT_MAX) font:self.descriptionLab.font];
    
    if (introHeight.height > 29) {
        _desViewHeight.constant = 120 - 29 + introHeight.height - 30;
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}

- (void) configCellWithMCHomeZhaoPingModel:(MCHomeZhaoPingModel *) model {

    _productName.text = model.zhaopin_title;
    _productPric.text = [NSString stringWithFormat:@"%@ / 月",model.zhaopin_money];
    _pubDate.text = model.zhaopin_time;
    _seeCount.text = [NSString stringWithFormat:@"%ld",[model.view_number integerValue]];
    _addressLab.text = model.address;
    _descriptionLab.text = model.zhaopin_content;
    
    CGSize introHeight = [model.zhaopin_content calculateSize:CGSizeMake(self.descriptionLab.frame.size.width, FLT_MAX) font:self.descriptionLab.font];
    
    if (introHeight.height > 29) {
        _desViewHeight.constant = 120 - 29 + introHeight.height - 30;
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
}

@end
