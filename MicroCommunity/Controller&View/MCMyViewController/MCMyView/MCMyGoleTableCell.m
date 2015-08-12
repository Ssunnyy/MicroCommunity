//
//  MCMyGoleTableCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyGoleTableCell.h"

@interface MCMyGoleTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation MCMyGoleTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithMCMyGoldModel:(MCMyGoldModel *)modle {
    
    _name.text = modle.title;
    _count.text = modle.gold;
    _date.text = modle.detailDate;
}

@end
