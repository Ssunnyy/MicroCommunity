//
//  MCCompanyIntroCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCompanyInfoModel.h"

@interface MCCompanyIntroCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *componyIntro;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userInfoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

- (void) configCellWithInfoModel:(MCCompanyInfoModel *) model;

@end
