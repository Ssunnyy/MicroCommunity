//
//  MCRecruitMainCell1.h
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCImPersonTableViewCellDelegate <NSObject>

- (void) headImageClickAtIndex:(NSInteger) index;

@end

@interface MCMyNewFriendCell : UITableViewCell

@property (nonatomic, assign) id <MCImPersonTableViewCellDelegate> delegate;


- (void) setBtnTag:(NSInteger) tag;


//  0 新朋友  1 好友  2  手机通讯录  3搜索显示试图
- (void) configCellWithType:(NSInteger) type;

@end
