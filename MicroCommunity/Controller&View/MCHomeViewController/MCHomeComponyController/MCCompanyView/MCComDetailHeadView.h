//
//  TableViewCell.h
//  MicroCommunity
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCHomeSearchModel;

@protocol MCComDetailHeadViewDelegate <NSObject>

- (void) headViewClickAtIndex:(NSInteger) index;

@end

@interface MCComDetailHeadView : UITableViewCell

@property (nonatomic, assign) id <MCComDetailHeadViewDelegate> delgate;

- (void) configHeadWithMCHomeSearchModel:(MCHomeSearchModel *) model;

@end
