//
//  MCIMSelectUserCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRemindLookModel.h"

@protocol MCIMSelectUserCellDelegate <NSObject>

- (void) chooseBtnClick:(NSIndexPath*)chooseIndexPath andChoose:(BOOL)isChoose;

@end

@interface QQButton : UIButton
@property (nonatomic,retain)NSIndexPath * indexPath;
@end

@interface MCIMSelectUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet QQButton *selectBtn;

@property (nonatomic, assign) id <MCIMSelectUserCellDelegate> delegate;

- (void)setContentCell:(QRemindLookModel *)model andChooseArray:(NSArray *) choose;

@end
