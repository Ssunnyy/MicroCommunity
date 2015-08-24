//
//  MCCompanyServerCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCompanyServerModel.h"
#import "MCMyCollectProductModel.h"
@interface MCCompanyServerCell : UITableViewCell


- (void) configCellWithMCCompanyServerModel:(MCCompanyServerModel *) model;

- (void) configCellWithMCMyCollectProductModel:(MCMyCollectProductModel *)model;

@end
