//
//  MCTalkListHeaderView.h
//  MicroCommunity
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTalkMainModel.h"

@protocol MCTalkListHeaderViewDelegate <NSObject>

//  100最新  101最热
- (void) selectTabAtIndex:(NSInteger) index;

@end

@interface MCTalkListHeaderView : UITableViewCell

@property (nonatomic, assign) id <MCTalkListHeaderViewDelegate> delegate;

- (void) configHeadWithMCTalkMainModel:(MCTalkMainModel *) model;

@end
