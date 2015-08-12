//
//  MCTalkListCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListCell.h"

@interface MCTalkListCell ()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *pariseBtn;

@end

@implementation MCTalkListCell

- (void)awakeFromNib {
    // Initialization code

    [_headImage makeCircleView];
}


//  300 分享 301评论 302点赞
- (IBAction)share_comment_praiseAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(share_comment_praiseAtIndex:)]) {
        [_delegate share_comment_praiseAtIndex:sender.tag];
    }
    
}

- (void) setCellWithTalkListModel:(MCTalkListModel *) model AtIndex:(NSInteger) index {

//    _nickName.text = model.nickName;
//    _dateLab.text = model.date;
    _contentLab.text = model.content;
//    _commentCount.text = model.commentCount;
//    _praiseCount.text = model.praiseCount;
    
    
    CGSize introHeight = [model.content calculateSize:CGSizeMake(self.contentLab.frame.size.width, FLT_MAX) font:self.contentLab.font];
    
    if (introHeight.height > 35) {
        self.contentViewHeight.constant = introHeight.height + 15;
    }
    if ([model.content isEqualToString:@""] || model.content == nil) {
        self.contentViewHeight.constant = 0;
    }

    int rowNum = ceilf(model.images.count/3.0);
    self.pickViewHeight.constant = rowNum * PictureWidth + rowNum * 8 ;
    
    _picV = [[QFriendPicView alloc] initWithFrame:CGRectMake(68, 1, 213, self.pickViewHeight.constant - 1)];
    [_picV setPicView:model.images];
    
    [_pickView addSubview:_picV];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
    self.shareBtn.tag =  6000 + index * 3;
    self.commentBtn.tag = 6001 + index * 3;
    self.pariseBtn.tag = 6002 + index * 3;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
