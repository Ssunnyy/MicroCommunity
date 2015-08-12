//
//  MCCompanyCommentCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCompanyCommentModel.h"

@protocol MCCompanyCommentCellDelegate <NSObject>

- (void) pariseAtIndex:(NSInteger) index;

@end

@interface MCCompanyCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (nonatomic, assign) id <MCCompanyCommentCellDelegate> delegate;

/// 设置点赞btn tag
- (void) setPariseBtnTag:(NSInteger) index;

- (void) configCellWithMCCompanyCommentModel:(MCCompanyCommentModel *) model;

@end
