//
//  MCSendMessageView.h
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCSendMessageView;

@protocol MCSendMessageViewDelegate <NSObject>

- (void) sendMessage:(NSString *) message;

@end

@interface MCSendMessageView : UIView

@property (nonatomic ,assign) id <MCSendMessageViewDelegate> delegate;

//  移除键盘通知
- (void) removeKeyboardLison ;

- (void) cleafData;
@end
