//
//  MCMyCountCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountCells.h"

@interface MCMyCountCells ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLine;

@end

@implementation MCMyCountCells

- (void)awakeFromNib {
    // Initialization code
    
    [_bgView setBorderWidth:1 andBorderColor:RGBCOLOR(237, 237, 237)];
    if (iPhone6) {
        _leftLine.constant = _rightLine.constant = 130;
    }else if (iPhone6Plus){
        _leftLine.constant = _rightLine.constant = 150;
    }
    
    
}

- (void)configCellWithMCMycountModle:(MCMycountModle *)model {

    _name.text = model.content;
    _count.text = model.money;
    _date.text = model.date;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
