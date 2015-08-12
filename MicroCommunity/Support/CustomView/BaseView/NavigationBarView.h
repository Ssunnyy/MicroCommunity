//
//  NavigationBarView.h
//  iTotemFrame
//
//  Created by qiuyan on 14-10-9.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarView.h"

@interface NavigationBarView : UIView

@property (nonatomic, strong) IBOutlet UIView *lineView;
@property (nonatomic, strong) IBOutlet UILabel *titleLab;
@property (nonatomic, strong) SearchBarView *searchNav;

//设置标题
-(void) setNavigationBarTitle:(NSString *) title;
//设置搜索框
- (void)setNavigationBarSeachView:(NSString *)text;
//导航的标题（图片）
- (void)setNavBarWithImgTitle:(UIImage *)imgTitle;

@end
