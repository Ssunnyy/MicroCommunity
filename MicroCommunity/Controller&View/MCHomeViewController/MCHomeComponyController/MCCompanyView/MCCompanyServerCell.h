//
//  MCCompanyServerCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProductModel.h"
#import "MCMyCollectProductModel.h"
@interface MCCompanyServerCell : UITableViewCell


- (void) configCellWithMCProductModel:(MCProductModel *) model;

- (void) configCellWithMCMyCollectProductModel:(MCMyCollectProductModel *)model;

@end
