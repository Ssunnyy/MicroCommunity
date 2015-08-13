//
//  MCIMFriendBottomView.h
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCIMFriendBottomViewDelegate <NSObject>

- (void) clickAtIndex:(NSInteger) index;

@end

@interface MCIMFriendBottomView : UITableViewCell

@property (nonatomic ,assign) id <MCIMFriendBottomViewDelegate> delegate;

//  改为两个button
- (void) changeToTwoBtnWithType:(NSInteger) type;

@end
