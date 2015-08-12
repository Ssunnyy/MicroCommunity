//
//  BaseViewController.h
//  iTotemFrame
//
//  Created by Lisa on 14-10-23.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBarView.h"
typedef enum
{
    UIButtonStylePerson,//主页左侧按钮
    UIButtonStyleModelBack,//模态视图（返回）
    UIButtonStyleRight,//右侧按钮
    UIButtonStyleRegister,//注册按钮
    UIButtonStyleQuestion,//问题按钮
    UIButtonStyleBack,//返回
    UIButtonStyleShare,//分享
} UIButtonStyle;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NavigationBarView *navigationBarView;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIButton * imageButton;
@property (nonatomic, strong) UIButton * titleButton;

//显示导航栏
-(void)loadNavigationBar;
//隐藏导航栏--- 默认是带导航栏的
-(void)hideNavBar;
//设置导航栏上的title
-(void)setNavigationBarTitle:(NSString *)title;
//左边导航栏上的按钮关联的方法
- (void)leftBarButtonClick:(id)sender;
//导航上带搜索框
- (void)setNavBarWithSeach:(NSString *)searchText withObject:(BaseViewController *)object;
//导航上标题图片
- (void)setNavBarTitleImage:(UIImage *)img
;
//右边导航栏上的按钮关联的触发方法
-(void)rightBarButtonClick:(UIButton *)button;
/**
 *  设置导航栏上的按钮
 *
 *  @param style     分为左边按钮 右边按钮
 *  @param image     normal 状态下的image
 *  @param highImage 高亮状态下的image
 */
-(void)setButtonStyle:(UIButtonStyle)style andImage:(UIImage *)image highImage:(UIImage *)highImage;

/**
 *  设置导航栏上的按钮
 *
 *  @param style    分为左边按钮 右边按钮
 *  @param title     显示的文本
 *  @param textColor 文本的显示颜色
 *  @param font      文本的字体大小
 */
-(void)setButtonStyle:(UIButtonStyle)style andTitle:(NSString *)title textColor:(UIColor*)textColor font:(UIFont *)font;

/**
 *  导航右侧的按钮是否可点击
 *
 *  @param isEnable yes 可点击 no 不可点击
 */

- (void)navBtnEnable:(BOOL)isEnable;

/**
 *  导航的是否显示背景图
 */
- (void)navlineViewIsHidden:(BOOL)isHidden;

/**
 *  导航的背景透明
 */
- (void)navBGAlpha;

/**
 *
 *
 *  获取用户类型
 */

- (BOOL)getUserTypeIsBc;

/****************键盘事件************************/
//如果开启此功能 则VieController 会自动监听键盘弹起事件 自动将编辑中的view拖动到可见区域
-(void)enableKeyboardManger;    /*default enabled*/
//禁用自动托起功能
-(void)disableKeyboardManager;

-(BOOL) isEnableKeyboardManger;

//结束编辑退出软键盘
-(void) endEditing;
//键盘弹起通知
- (void)keyboardWillShow:(NSNotification *)notification;
//键盘退出通知
- (void)keyboardWillHide:(NSNotification *)notification;

@end
