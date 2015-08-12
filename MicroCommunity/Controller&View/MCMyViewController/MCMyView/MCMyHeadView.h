//
//  MCMyHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyHeadViewDelegate <NSObject>

- (void) busnissBtnClickWithTag:(NSInteger) tag;

@end

@interface MCMyHeadView : UITableViewCell

@property (nonatomic,assign) id <MCMyHeadViewDelegate> delegate;

- (void) currentUerIsBusniss:(BOOL) isBussniss;

@end
