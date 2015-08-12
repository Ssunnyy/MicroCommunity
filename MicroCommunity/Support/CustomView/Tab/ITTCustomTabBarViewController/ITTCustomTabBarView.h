//
//  CustomTabBar.h
//  iTotemFrame
//
//  Created by lian jie on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTXibView.h"
#import "ITTHiddenTabBarViewController.h"

@class ITTCustomTabBarView;
@protocol  ITTCustomTabBarViewDelegate<NSObject>

@optional

-(void)hideTabBarWithIsHide:(BOOL)isHide andTabView:(ITTCustomTabBarView *)tabView;

@end


@interface ITTCustomTabBarView : ITTXibView
{
    
//    ITTHiddenTabBarViewController *_tabBarController;
    
}

@property(nonatomic,weak)id<ITTCustomTabBarViewDelegate>tabBarDelagate;

@property (weak, nonatomic) IBOutlet UILabel *goutongNumber;

@property (nonatomic,assign) ITTHiddenTabBarViewController *tabBarController;
@property (nonatomic,retain) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, retain) IBOutlet UIButton *tab1Btn;
@property (nonatomic, retain) IBOutlet UIButton *tab2Btn;
@property (nonatomic, retain) IBOutlet UIButton *tab3Btn;
@property (nonatomic, retain) IBOutlet UIButton *tab4Btn;
@property (retain, nonatomic) IBOutlet UIButton *tab5Btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1ConstraintsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2ConstraintsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn4ConstraintsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn5ConstraintsWidth;

+ (ITTCustomTabBarView*)viewFromNib;
- (IBAction)onTabBtnClicked:(id)sender;
- (void)selectTabAtIndex:(NSInteger)index;
//判断是否隐藏
-(void)hideTabBarOrNot:(BOOL)isHide;


@end


