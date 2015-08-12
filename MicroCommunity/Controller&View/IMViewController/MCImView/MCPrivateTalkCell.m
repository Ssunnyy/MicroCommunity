//
//  MCRecruitMainCell1.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCPrivateTalkCell.h"

@interface MCPrivateTalkCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *lastMessage;
@property (weak, nonatomic) IBOutlet UIView *messageCountView;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLab;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@end

@implementation MCPrivateTalkCell

- (void)awakeFromNib {
    
    [_headImage makeCircleView];
    [_messageCountView makeCircleView];
    [_messageCountView setBorderWidth:1 andBorderColor:[UIColor whiteColor]];
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
    
    _headBtn.tag = tag + 3000;
}

@end
