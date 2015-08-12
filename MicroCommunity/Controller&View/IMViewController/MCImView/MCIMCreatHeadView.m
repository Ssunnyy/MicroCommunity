//
//  MCIMCreatHeadView.m
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMCreatHeadView.h"

@implementation MCIMCreatHeadView

- (void)awakeFromNib {
    [_headImages makeCornerRadius:5];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 *  400小组头像 401聊天室名称 402 进入聊天 403删除群组  405 添加好友
 */

- (IBAction)btnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(currentBtnClickAtIndex:)]) {
        [_delegate currentBtnClickAtIndex:sender.tag];
    }
}

- (void) configCellWith:(id)model andIsSelf:(BOOL)isSelf {
    
    if (!self) {
        _deleteTalkBtn.hidden = YES;
        _talkDescription.editable = NO;
        _talkDescription.userInteractionEnabled = NO;
        _headBtn.hidden = YES;
        _changeNameBtn.enabled = NO;
        _moreImage.hidden = YES;
    }
    
    float left = 10;
    float top = 15;
    
    [self.firendScrollView removeAllSubviews];
    
    for (int i = 0;  i < 10 ; i ++) {
        if (i != 9) {
            UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(left + (50 + 10 ) *i, top, 50, 50)];
            userImage.image = [UIImage imageNamed:@"result_head.png"];
            [userImage makeCornerRadius:5];
            UILabel *nickName = [[UILabel alloc]initWithFrame:CGRectMake(left + (50 + 10 ) *i, userImage.framebottom, 50, 30)];
            nickName.font = [UIFont systemFontOfSize:13];
            nickName.backgroundColor = [UIColor clearColor];
            nickName.tintColor = RGBACOLOR(58, 58, 58, 1);
            nickName.text = @"艾米莉";
            [_firendScrollView addSubview:userImage];
            [_firendScrollView addSubview:nickName];
        }else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(left + (50 + 10 ) *i, top, 50, 50);
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_add4.png"] forState:UIControlStateNormal];
            btn.tag = 405;
            [btn addTarget: self  action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_firendScrollView addSubview:btn];
        }
    }
    _firendScrollView.contentSize = CGSizeMake(20 + 10 * (60), 100);
}


- (void)setHeadImage:(UIImage *)image {

    self.headImages.image = image;
}

- (UIImage *)getHeadImage{

    return self.headImages.image;
}



@end
