//
//  CustomTabBar.m
//  iTotemFrame
//
//  Created by lian jie on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define  checkPhoneNum   if ([KXXFPublicManager GetPhoneNum] == nil) {\
[[[UIAlertView alloc] initWithTitle:@"提示" message:@"您还未注册用户，无法进入，请先参加竞猜答题，最后填入手机号完成注册。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];\
return;\
}

#import "ITTCustomTabBarView.h"

@implementation ITTCustomTabBarView
@synthesize tabBarController = _tabBarController;
@synthesize tab1Btn = _tab1Btn;
@synthesize tab2Btn = _tab2Btn;
@synthesize tab3Btn = _tab3Btn;
@synthesize tab4Btn = _tab4Btn;
@synthesize tab5Btn = _tab5Btn;

+ (ITTCustomTabBarView*)viewFromNib{
    return [ITTCustomTabBarView loadFromXib];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _selectedImageView.image = ImageNamed(@"vBg+.png");
    [_tab3Btn setImage:ImageNamed(@"vSelect.png") forState:UIControlStateNormal];
    [_tab3Btn setImage:ImageNamed(@"vSelect.png") forState:UIControlStateHighlighted];
    [_tab3Btn setImage:ImageNamed(@"vSelect.png") forState:UIControlStateSelected];
    
    CGFloat width = SCREEN_WIDTH / 4 ;
    _btn1ConstraintsWidth.constant = width;
    _btn2ConstraintsWidth.constant = width;
    _btn4ConstraintsWidth.constant = width;
    _btn5ConstraintsWidth.constant = width;
    _goutongNumber.layer.masksToBounds = YES;
    _goutongNumber.layer.cornerRadius = 10;
    _goutongNumber.backgroundColor = [UIColor redColor];
    
}

- (void)selectTabAtIndex:(NSInteger)index
{
    _tab1Btn.selected = NO;
    _tab2Btn.selected = NO;
    _tab3Btn.selected = NO;
    _tab4Btn.selected = NO;
    _tab5Btn.selected = NO;
    _selectedImageView.image = ImageNamed(@"vBg-.png");//vDefout.png
    [_tab3Btn setImage:ImageNamed(@"vDefout.png") forState:UIControlStateNormal];
    [_tab3Btn setImage:ImageNamed(@"vDefout.png") forState:UIControlStateHighlighted];
    [_tab3Btn setImage:ImageNamed(@"vDefout.png") forState:UIControlStateDisabled];
    
    switch (index) {
        case 0:{
            _tab1Btn.selected = YES;
            _tab2Btn.selected = NO;
            _tab3Btn.selected = NO;
            _tab4Btn.selected = NO;
            _tab5Btn.selected = NO;
            break;
        }
        case 1:{
            _tab1Btn.selected = NO;
            _tab2Btn.selected = YES;
            _tab3Btn.selected = NO;
            _tab4Btn.selected = NO;
            _tab5Btn.selected = NO;
            break;
        }
        case 2:{
            _tab1Btn.selected = NO;
            _tab2Btn.selected = NO;
            _tab3Btn.selected = NO;
            _tab4Btn.selected = YES;
            _tab5Btn.selected = NO;
            break;
        }
        case 3:{
            _tab1Btn.selected = NO;
            _tab2Btn.selected = NO;
            _tab3Btn.selected = NO;
            _tab4Btn.selected = NO;
            _tab5Btn.selected = YES;
            break;
        }
        default:
            break;
    }
}

- (IBAction)onTabBtnClicked:(id)sender {
    UIButton *bth = (UIButton *)sender;
    [self selectTabAtIndex:bth.tag];
    if (_tabBarController && [_tabBarController respondsToSelector:@selector(setSelectedTabIndex:)]) {
        [_tabBarController setSelectedTabIndex:bth.tag];
        [self.superview bringSubviewToFront:self];
    }
}

//判断是否隐藏
-(void)hideTabBarOrNot:(BOOL)isHide
{
    if (self.tabBarDelagate && [self.tabBarDelagate respondsToSelector:@selector(hideTabBarWithIsHide: andTabView:)]) {
        [_tabBarDelagate hideTabBarWithIsHide:isHide andTabView:self];
    }
}

@end
