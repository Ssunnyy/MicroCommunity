//
//  ASNewShowTableViewCell.m
//  ITotem
//
//  Created by adims on 15/3/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASNewShowTableViewCell.h"

@implementation ASNewShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self changeFramWithIphone];
    
}

#pragma  --  mark  通过model 设置cell内容
- (void) changeFramWithIphone{

    if (iPhone6Plus) {
        _bgImageHeight.constant = 333;
    } else if (iPhone6) {
        //  修改头像背景大小
        _headTopViewHeight.constant = 71;
        _headTopViewWidth.constant = 71;
        _headBgViewHeight.constant = 71;
        _headBgViewWidth.constant = 71;
        
        _headBgView.framewidth = 71;
        _headBgView.frameheight = 71;
        _headTopView.framewidth = 71;
        _headTopView.frameheight = 71;
        _headImageView.frameheight = 71 - 8;
        _headImageView.framewidth = 71 - 8;
        
        _bgImageHeight.constant = 278;
        _sexHorizontalSize.constant = 7;
        _sexVerticalSize.constant = 20;
        _name_head_height.constant = -10;
    } else {
        
        //  修改头像背景大小
        _headTopViewHeight.constant = 71;
        _headTopViewWidth.constant = 71;
        _headBgViewHeight.constant = 71;
        _headBgViewWidth.constant = 71;
        
        _headBgView.framewidth = 71;
        _headBgView.frameheight = 71;
        _headTopView.framewidth = 71;
        _headTopView.frameheight = 71;
        _headImageView.frameheight = 71 - 8;
        _headImageView.framewidth = 71 - 8;
        
        _bgImageHeight.constant = 278;
        _sexHorizontalSize.constant = -20;
        _sexVerticalSize.constant = 20;
        _name_head_height.constant = -10;
    }
    
    //设置头像圆角
    
    [_headBgView makeCircleView];
    [_headImageView makeCircleView];
    [_headTopView makeCircleView];
    
    _nickNameLab.text = @"";
    _contentLab.text = @"";
    
}


- (void)setContentCell:(ASMainBCCCModel *)model
{
    if ([model.user.gender isEqualToString:@"0"]) {//男
        _sexImageView.image = [UIImage imageNamed:@"boy_"];
        [_nickNameLab contentTest:model.user.nickname];
        if (model.loverNickname != nil && ![model.loverNickname isKindOfClass:[NSNull class]]) {
            if (model.loverNickname.length > 0) {
                _nickNameLab.text = [NSString stringWithFormat:@"%@&%@",model.user.nickname,model.loverNickname];
                _sexImageView.image = [UIImage imageNamed:@"fuqi"];
            }
        }
    }else{
        
        [_nickNameLab contentTest:model.user.nickname];
        _sexImageView.image = [UIImage imageNamed:@"Girls_icon_"];
        
        if (model.loverNickname != nil && ![model.loverNickname isKindOfClass:[NSNull class]]) {
            if (model.loverNickname.length > 0) {
                _nickNameLab.text = [NSString stringWithFormat:@"%@&%@",model.user.nickname,model.loverNickname];
                _sexImageView.image = [UIImage imageNamed:@"fuqi"];
            }
        }
    }
    
    if ([model.collected isEqualToString:@"1"]) {
        _collectionLab.textColor = BaseColor;
        _zanImageView.image = ImageNamed(@"shoucang_huang_icon_.png");
    }else {
        _collectionLab.textColor = [UIColor whiteColor];
        _zanImageView.image = ImageNamed(@"xingx.png");
    }
    _collectionLab.text = model.collectNum;
    if ([model.collectNum isEqualToString:@"0"] || [model.collectNum isKindOfClass:[NSNull class]] || model.collectNum == nil) {
        _collectionLab.hidden = YES;
        _zanImageView.hidden = YES;
    }
    
    self.contentLab.text = model.user.personalSign;
    
    [self.headImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.user.headImg] andPlaceholderImage:ImageNamed(@"huazhuang_bg_.png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!_headImageView.image) {
            _headImageView.image = ImageNamed(@"huazhuang_bg_.png");
        }
    }];
    [self.bgImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.user.backImg] andPlaceholderImage:ImageNamed(@"main_default.png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!_bgImageView.image) {
            _bgImageView.image = ImageNamed(@"main_default.png");
        }
    }];
    
}

/**
 *点击进入个人中心
*/
- (IBAction)enterPersonCenter:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(enterCenter:)]) {
        [_delegate enterCenter:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
