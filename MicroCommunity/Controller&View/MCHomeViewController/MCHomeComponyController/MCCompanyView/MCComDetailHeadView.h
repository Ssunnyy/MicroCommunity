//
//  MCComDetailHeadView.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCComDetailHeadViewDelegate <NSObject>

- (void) headViewClickAtIndex:(NSInteger) index;

@end

@interface MCComDetailHeadView : UIView

@property (nonatomic, assign) id <MCComDetailHeadViewDelegate> delgate;

@end
