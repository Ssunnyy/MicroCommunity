//
//  MCProdectHeadTableViewCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCProductModel.h"
#import "MCSendMessageView.h"
#import "MCHomeZhaoPingModel.h"

@interface MCProdectHeadTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *senderView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (nonatomic, strong) MCSendMessageView *sender ;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;



- (void) configCellWithMCProductModel:(MCProductModel *) model;
- (void) configCellWithMCHomeZhaoPingModel:(MCHomeZhaoPingModel *) model;


@end
