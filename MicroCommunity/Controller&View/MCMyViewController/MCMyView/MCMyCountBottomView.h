//
//  MCMyCountBottomView.h
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyCountBottomViewDelegate <NSObject>

//  200 充值  201申请退款
- (void) buttonClickAtIndex:(NSInteger) index;

@end

@interface MCMyCountBottomView : UITableViewCell

@property(nonatomic, assign) id <MCMyCountBottomViewDelegate> delegate;

@end
