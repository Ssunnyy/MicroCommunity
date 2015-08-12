//
//  MCRecruitMainCell1.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCImPersonTableViewCell.h"

@interface MCImPersonTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@end

@implementation MCImPersonTableViewCell

- (void)awakeFromNib {
    
    [_headImage makeCircleView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)headImageClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(headImageClickAtIndex:)]) {
        [_delegate headImageClickAtIndex:sender.tag];
    }
}

- (void)setBtnTag:(NSInteger)tag {

    _headBtn.tag = tag + 1000;
}
@end
