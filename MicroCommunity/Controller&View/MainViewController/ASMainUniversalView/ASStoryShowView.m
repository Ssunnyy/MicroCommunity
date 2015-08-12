//
//  ASStoryShowView.m
//  ITotem
//
//  Created by qiuyan on 15-3-12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASStoryShowView.h"

@interface ASStoryShowView ()
{
    IBOutlet UIButton *arrowBtn;
}
/**
 *  当前显示的页数
 */
@property (nonatomic, strong) IBOutlet UILabel *pageNum;
/**
 *  描述的内容
 */
@property (nonatomic, strong) IBOutlet UILabel *descriptionLab;
/**
 *  描述文字lab的宽和高
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *decriptionLabWidth;
/**
 *  页数的bottom
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *pageLabBottom;

@end


@implementation ASStoryShowView

- (void)awakeFromNib
{
    UIButton *unfoldBtn = (UIButton *)[self viewWithTag:161];
    
    if (iPhone6Plus) {
        _decriptionLabWidth.constant = 330;
        _pageLabBottom.constant = 12;
    }else if(iPhone6){
        _decriptionLabWidth.constant = 300;
    }else{
        _decriptionLabWidth.constant = 249;
    }
    CGSize size = [_descriptionLab.text calculateSize:CGSizeMake(_decriptionLabWidth.constant, 200000) font:UIFontSize(16)];
    if (size.height <= 20) {
        unfoldBtn.hidden = YES;
    }else{
        unfoldBtn.hidden = NO;
    }
}

- (void)changeNum:(NSString *)num
{
    self.pageNum.text = num;
}

- (void) setContent:(NSString *)contetn {

    [_descriptionLab contentTest:contetn];
}

- (IBAction)labAnimationClick:(id)sender
{
    UIImageView *imgV = (UIImageView *)[self viewWithTag:150];
    //判断lab是展开还是合上
    if (_descriptionLab.frameheight > 20) {///展开
        arrowBtn.selected = NO;
        [UIView animateWithDuration:.3f animations:^{
            _descriptionLab.frameheight = 20;
            _descriptionLab.framebottom = 73;
            imgV.framebottom = 70;
        }];
    }else{
        arrowBtn.selected = YES;
        CGSize size = [_descriptionLab.text calculateSize:CGSizeMake(_decriptionLabWidth.constant, 200000) font:UIFontSize(16)];
        [UIView animateWithDuration:.3f animations:^{
            _descriptionLab.frameheight = size.height;
            _descriptionLab.framebottom = 73;
            imgV.frametop = _descriptionLab.frametop + 4;
        }];
    }
}

@end
