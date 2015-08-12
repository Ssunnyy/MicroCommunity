//
//  MCCityTableViewCell.m
//  RATreeView
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 Rafal Augustyniak. All rights reserved.
//

#import "MCCityTableViewCell.h"


@interface MCCityTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;


@end

@implementation MCCityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCillWithCity:(RADataObject *)city{
    
    _cityLab.text = city.name;
}

- (void)hidenLine:(BOOL)hiden {
    
    if (hiden) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else {
        self.contentView.backgroundColor = [UIColor colorWithRed:245 green:245 blue:245 alpha:1];
    }
    _lineLab.hidden = hiden;
    _jiantouBtn.hidden = hiden;
}

@end
