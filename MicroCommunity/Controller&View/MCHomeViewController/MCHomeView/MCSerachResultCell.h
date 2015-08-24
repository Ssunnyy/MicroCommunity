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
// 0 首页搜搜 1 我的收藏
- (void) configCellWithMCHomeSearchModel:(MCHomeSearchModel*) model withType:(NSInteger) type;

@end
