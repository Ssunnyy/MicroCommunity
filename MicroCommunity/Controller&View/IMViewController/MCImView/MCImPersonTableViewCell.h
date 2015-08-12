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

@interface MCImPersonTableViewCell : UITableViewCell

@property (nonatomic, assign) id <MCImPersonTableViewCellDelegate> delegate;

- (void) setBtnTag:(NSInteger) tag;

@end
