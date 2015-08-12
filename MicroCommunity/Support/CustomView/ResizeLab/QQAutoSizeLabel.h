//
//  QQAutoSizeLabel.h
//  Test
//
//  Created by mac  on 14-6-28.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQAutoSizeLabel : UIView

@property (nonatomic, copy) void (^hotTagClickBlock)(NSUInteger currentIndex);
@property (nonatomic, copy) void (^hotTagNameBlock)(NSString *tagName);
@property (nonatomic, copy) void (^containViewHeightBlock)(float height);

-(void)setHotViewWithArray:(NSArray*)resultArray andSampleLabelFont:(CGFloat)fontSize height:(CGFloat)labelHeight;

- (CGFloat) containHeight;

- (void) setSelectAtIndex:(NSInteger)index;
@end
