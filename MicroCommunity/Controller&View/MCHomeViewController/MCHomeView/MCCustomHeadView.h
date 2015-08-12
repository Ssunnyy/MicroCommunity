//
//  MCCustomHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCustomHeadViewDelegate <NSObject>

/*
    100 返回 101 发布 102搜索
 */

- (void) customNavViewClickWithIndex:(NSInteger) index;

@end

@interface MCCustomHeadView : UIView

@property (nonatomic, assign) id <MCCustomHeadViewDelegate> delegate;

- (void) setTitleWithString:(NSString *) title;

@end
