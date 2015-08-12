//
//  MCProductSearchHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCProductSearchHeadView.h"

@interface MCProductSearchHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productNum;


@end

@implementation MCProductSearchHeadView

- (void)setProductName:(NSString *)name andProductNmu:(NSString *)productNum {

    _productName.text = name;
    _productNum.text = productNum;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
