//
//  NavigationBarView.m
//  iTotemFrame
//
//  Created by qiuyan on 14-10-9.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//

#import "NavigationBarView.h"

@implementation NavigationBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
//    self.alpha = 0.9f;
    if (iPhone6Plus) {
        [self setTitleFontSize:23];
    }else if (iPhone6){
        [self setTitleFontSize:22];
    }
}

///标题字体大小
- (void)setTitleFontSize:(float)size
{
    self.titleLab.font = UIBoldFontSize(size);
}

-(void)setNavigationBarTitle:(NSString *)title
{
    [self.titleLab setText:title];
}

//导航的标题（图片）
- (void)setNavBarWithImgTitle:(UIImage *)imgTitle
{
    UIImageView *img = [[UIImageView alloc] init];
    img.image = imgTitle;
    [self addSubview:img];
    
    int top;
    if (ISLESS_IOS7) {
        top = 8;
    }else{
        top = 30;
    }
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(top);
        make.centerX.equalTo(self.mas_centerX);
        if (iPhone6Plus) {
            make.width.equalTo(90);
            make.height.equalTo(28);
        }else{
            make.width.equalTo(81);
            make.height.equalTo(25);
        }
    }];
}

@end
