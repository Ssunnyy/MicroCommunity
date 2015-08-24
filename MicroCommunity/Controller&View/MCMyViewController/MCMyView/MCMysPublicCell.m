//
//  MCSerachResultCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMysPublicCell.h"

@interface MCMysPublicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDes;
@property (weak, nonatomic) IBOutlet UILabel *productMondy;
@property (weak, nonatomic) IBOutlet UILabel *productcostMoney; //  竟
@property (weak, nonatomic) IBOutlet UILabel *productaddMondy;  //  元

@property (weak, nonatomic) IBOutlet UILabel *hiden1;
@property (weak, nonatomic) IBOutlet UILabel *hiden2;
@property (weak, nonatomic) IBOutlet UILabel *hiden3;
@property (weak, nonatomic) IBOutlet UILabel *hdien4;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end

@implementation MCMysPublicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)shopBtnClick:(UIButton *)sender {
    
    if (sender.tag == 101) {
        sender.selected = !sender.selected;
    }
    
    if ([_delegate respondsToSelector:@selector(inType:AtIndex:)]) {
        [_delegate inType:sender.tag AtIndex:self.tag];
    }
}

- (void) hidien:(BOOL) hiden {

    _hiden1.hidden = hiden;
    _hiden2.hidden = hiden;
    _hiden3.hidden = hiden;
    _hdien4.hidden = hiden;
    _productcostMoney.hidden = hiden;
    _productaddMondy.hidden = hiden;
    
}

- (void)setUpCellWithModel:(MCMyPublicModel *)modle andeIndex:(NSInteger)tag {

//    [_headImage sd_setImageWithURL:[NSURL URLWithString:modle.headImage] placeholderImage:ImageNamed(@"")];
    
    [_productName setTitle:modle.goods_name forState:UIControlStateNormal];;
    _productDes.text = modle.goods_message;
    _productMondy.text = modle.goods_price;
    _productcostMoney.text = modle.goods_sum_money;
    _productaddMondy.text = modle.goods_money;
    _chooseBtn.selected = modle.isChoose;
    self.tag = tag;
    
    if ([modle.status isEqualToString:@"0"]) {
        _messageBtn.selected = NO;
        [_messageBtn setTitle:@"发布中" forState:UIControlStateNormal];
        
    }else if([modle.status isEqualToString:@"1"]){
        _messageBtn.selected = YES;
        [_messageBtn setTitle:@"已失效" forState:UIControlStateSelected];
    } else if([modle.status isEqualToString:@"2"]){
        _messageBtn.selected = YES;
        [_messageBtn setTitle:@"已关闭" forState:UIControlStateSelected];
    }
}
@end
