//
//  AppDelegate.h
//  ITotem
//
//  Created by qiuyan on 15-3-2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTCustomTabBarView.h"

@class BaseViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) ITTHiddenTabBarViewController *tabbarController;
@property (nonatomic, strong) ITTCustomTabBarView *customTabBarView;

+ (AppDelegate*)GetAppDelegate;

/**
 *  不显示tab
 */
+ (void)HideTabBar;

/**
 *  显示tab
 */
+ (void)DisplayTabBar;

- (void)customTabBarViewselectTabAtIndex:(NSInteger)index;

- (void)getCurrentController:(BaseViewController *)controller;

@end
