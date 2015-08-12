//
//  MCTalkListCell.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTalkListModel.h"

#import "QFriendPicView.h"

@protocol MCTalkListCellDelegate <NSObject>

- (void) share_comment_praiseAtIndex:(NSInteger) index;

@end

@interface MCTalkListCell : UITableViewCell

@property (nonatomic, assign) id<MCTalkListCellDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *pickView;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *contentLabView;

@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *praiseCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewHeight;


@property (nonatomic, retain) QFriendPicView *picV;// 图片显示

- (void) setCellWithTalkListModel:(MCTalkListModel *) model AtIndex:(NSInteger) index;

@end
