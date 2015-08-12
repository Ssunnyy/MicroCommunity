//
//  MCHomeViewCell.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCHomeViewCellDelegate <NSObject>

- (void) btnClickAtIndex:(NSInteger) index;

@end

@interface MCHomeViewCell : UITableViewCell

@property (nonatomic, assign) id <MCHomeViewCellDelegate> delegate;

- (void)setContentCell:(NSArray *)modelArr andIndex:(NSInteger)index;
@end
