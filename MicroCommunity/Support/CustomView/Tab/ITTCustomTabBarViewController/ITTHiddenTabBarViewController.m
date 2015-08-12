//
//  ITTHiddenTabBarViewController.m
//  iTotemFrame
//
//  Created by jack 廉洁 on 4/1/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "ITTHiddenTabBarViewController.h"
//#import "AppDelegate.h"
@interface ITTHiddenTabBarViewController()
- (void)hideOriginalTabBar;
@end
@implementation ITTHiddenTabBarViewController
- (void)hideOriginalTabBar{
    UIView *contentView;
	if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
		contentView = [self.view.subviews objectAtIndex:1];
	}
	else {
		contentView = [self.view.subviews objectAtIndex:0];
	}
	contentView.frameheight = SCREEN_HEIGHT;
//	for(UIView *view in self.view.subviews){
//		if([view isKindOfClass:[UITabBar class]]){
//			view.alpha = 0;
//			break;
//		}
//	}
}

- (void)showOriginalTabBar{
    UIView *contentView;
	if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
		contentView = [self.view.subviews objectAtIndex:1];
	}
	else {
		contentView = [self.view.subviews objectAtIndex:0];
	}
	contentView.frameheight = SCREEN_HEIGHT;
//	for(UIView *view in self.view.subviews){
//		if([view isKindOfClass:[UITabBar class]]){
//			view.alpha = 0;
//			break;
//		}
//	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(UIView *view in self.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){
			view.alpha = 0;
			break;
		}
	}
    [self showOriginalTabBar];
}

- (void)setSelectedTabIndex:(NSUInteger)selectedIndex
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.layer addAnimation:transition forKey:nil];
    [self setSelectedIndex:selectedIndex];
}


@end
