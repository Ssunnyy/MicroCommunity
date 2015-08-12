//
//  ITTHiddenTabBarViewController.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 4/1/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ITTHiddenTabBarViewController : UITabBarController{
}

- (void)showOriginalTabBar;
- (void)hideOriginalTabBar;
- (void)setSelectedTabIndex:(NSUInteger)selectedIndex;
@end
