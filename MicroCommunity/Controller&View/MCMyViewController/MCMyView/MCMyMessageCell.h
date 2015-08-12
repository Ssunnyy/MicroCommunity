//
//  MCMyMessageCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyMessageModel.h"

@interface MCMyMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contenLab;

- (void) configCellWithMCMyMessageModel:(MCMyMessageModel *) model;

@end
