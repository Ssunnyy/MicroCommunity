//
//  MCTalkCommentCell.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCTalkPariseModel.h"

@protocol MCTalkCommentCellDelegate <NSObject>

- (void) zanBtnClickAtIndex:(NSInteger) index;

@end

@interface MCTalkCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@property (nonatomic ,assign) id <MCTalkCommentCellDelegate> delegate;

- (void) setUpCellWithMCTalkPariseModel:(MCTalkPariseModel *) model;

@end
