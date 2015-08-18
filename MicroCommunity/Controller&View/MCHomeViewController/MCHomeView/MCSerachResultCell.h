//
//  MCSerachResultCell.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCHomeSearchModel.h"

@protocol MCSerachResultCellDelegate <NSObject>
//  100商品详情
//  101公司产品列表
//  102联系
- (void) inType:(NSInteger) type AtIndex:(NSInteger) index;
@end

@interface MCSerachResultCell : UITableViewCell

@property (nonatomic, assign) id <MCSerachResultCellDelegate> delegate;

- (void) configCellWithMCHomeSearchModel:(MCHomeSearchModel*) model;

@end
