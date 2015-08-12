//
//  MCMyGoldHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyGoldHeadViewDelegate <NSObject>

- (void) sendGoldToOther;

@end

@interface MCMyGoldHeadView : UITableViewCell

@property (nonatomic, assign) id <MCMyGoldHeadViewDelegate> delegate;

@end
