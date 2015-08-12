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

//    _productName.text = model.productName;
//    _productPric.text = model.productPrice;
//    _pubDate.text = model.productDate;
//    _seeCount.text = model.productSeeCount;
//    _addressLab.text = model.productAddress;
    _descriptionLab.text = model.productIntro;
    
    CGSize introHeight = [model.productIntro calculateSize:CGSizeMake(self.descriptionLab.frame.size.width, FLT_MAX) font:self.descriptionLab.font];
    
    if (introHeight.height > 29) {
        _desViewHeight.constant = 120 - 29 + introHeight.height - 30;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];

}

@end
