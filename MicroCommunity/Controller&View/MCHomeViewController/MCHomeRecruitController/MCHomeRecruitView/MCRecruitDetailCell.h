//
//  MCCompanyCommentCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRecruitModel.h"


@interface MCRecruitDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *like;//   特长
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3Height;


@property (weak, nonatomic) IBOutlet UIView *bottomView;

- (void) configCellWithMCCompanyCommentModel:(MCRecruitModel *) model;

@end
