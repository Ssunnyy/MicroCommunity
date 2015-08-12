//
//  MCCompanyBottomView.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCompanyBottomViewDelegate <NSObject>

- (void) btnClickAtIndex:(NSInteger) index;

@end

@interface MCCompanyBottomView : UIView

@property (nonatomic, assign) id <MCCompanyBottomViewDelegate> delegate;

@end
