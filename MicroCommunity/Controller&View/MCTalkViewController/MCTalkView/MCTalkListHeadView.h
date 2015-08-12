//
//  MCTalkListHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTalkListHeadViewDelegate <NSObject>

//  100最新  101最热
- (void) selectTabAtIndex:(NSInteger) index;

@end

@interface MCTalkListHeadView : UIView

@property (nonatomic, assign) id <MCTalkListHeadViewDelegate> delegate;

@end
