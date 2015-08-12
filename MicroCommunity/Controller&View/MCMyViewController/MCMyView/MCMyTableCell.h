//
//  MCMyTableCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyCellModel.h"
@interface MCMyTableCell : UITableViewCell

- (void) configMyCellWithMCMyCellModel:(MCMyCellModel *) model isShowCount:(BOOL) show;

@end
