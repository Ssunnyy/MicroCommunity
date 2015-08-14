//
//  MCMyCountApplyView.h
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyCountApplyViewDelegate <NSObject>

- (void) myCountApplyClick:(NSInteger) index andMoney:(NSString *)money andName:(NSString *)name andPay:(NSString *) pay;

@end

@interface MCMyCountApplyView : UITableViewCell

@property (nonatomic, assign) id <MCMyCountApplyViewDelegate> delegate;

- (void) showApply;
- (void) hidenApply;
- (void) removeKeyboardLison;
@end
