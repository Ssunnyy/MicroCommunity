//
//  MCTalkCommentCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkCommentCell.h"

@interface MCTalkCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *pariseLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UIButton *pariseBtn;





@end

@implementation MCTalkCommentCell


- (IBAction)pariseBtnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(zanBtnClickAtIndex:)]) {
        [_delegate zanBtnClickAtIndex:sender.tag];
    }
    
}

- (void)awakeFromNib {
    // Initialization code

    [_headImage makeCircleView];
}

- (void)setUpCellWithMCTalkPariseModel:(MCTalkPariseModel *)model {

    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.comment_head_image] placeholderImage:ImageNamed(default_head)];
    _nickName.text = model.comment_nickname;
    _dataLab.text = [NSDate timeStringWithInterval:[model.comment_time doubleValue]];
    
    _commentLab.text = model.comment_content;
    CGSize introHeight = [model.comment_content calculateSize:CGSizeMake(self.commentLab.frame.size.width, FLT_MAX) font:self.commentLab.font];
    
    if (introHeight.height > 32) {
        self.commentHeight.constant = introHeight.height + 40;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
