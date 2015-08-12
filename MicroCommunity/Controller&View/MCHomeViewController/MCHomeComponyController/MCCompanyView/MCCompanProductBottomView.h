//
//  MCCompanProductBottomView.h
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCompanProductBottomViewDelegate <NSObject>

- (void) bottomBtnClickAtIndex:(NSInteger) index;

@end


@interface MCCompanProductBottomView : UIView

@property (nonatomic, assign) id <MCCompanProductBottomViewDelegate> delegate;

- (void) configUserInfoWithUerName:(NSString *) userName andConnect:(NSString *) telephone;

//  三个button
- (void) hidenCompanyBtn;
@end
