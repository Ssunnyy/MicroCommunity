//
//  MCRecruitMainCell1.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCImGroupRoomCell.h"

@interface MCImGroupRoomCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@end

@implementation MCImGroupRoomCell

- (void)awakeFromNib {
    
    [_headImage makeCircleView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)headImageClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(groupHeadImageClickAtIndex:)]) {
        [_delegate groupHeadImageClickAtIndex:sender.tag];
    }
}

- (void)setBtnTag:(NSInteger)tag {
    
    _headBtn.tag = tag + 2000;
}


@end
