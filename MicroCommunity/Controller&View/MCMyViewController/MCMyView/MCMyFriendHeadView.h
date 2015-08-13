//
//  MCMyFriendHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyFriendHeadViewDelegate <NSObject>

- (void) btnClickAtIndex:(NSInteger) index;

@end

@interface MCMyFriendHeadView : UITableViewCell

@property (nonatomic, assign) id <MCMyFriendHeadViewDelegate> delegate;

@end
