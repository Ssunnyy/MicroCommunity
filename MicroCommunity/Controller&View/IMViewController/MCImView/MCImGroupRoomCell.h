//
//  MCRecruitMainCell1.h
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCImGroupRoomCellDelegate <NSObject>
//  群组头像点击
- (void) groupHeadImageClickAtIndex:(NSInteger) index;

@end

@interface MCImGroupRoomCell : UITableViewCell

@property (nonatomic, assign) id <MCImGroupRoomCellDelegate> delegate;

- (void) setBtnTag:(NSInteger) tag;

@end
