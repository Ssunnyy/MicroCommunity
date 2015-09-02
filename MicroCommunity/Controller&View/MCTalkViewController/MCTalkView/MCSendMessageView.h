//
//  MCSendMessage.h
//  MicroCommunity
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MCSendMessageViewDelegate <NSObject>

- (void) sendMessage:(NSString *) message;

@end

@interface MCSendMessageView : UITableViewCell

@property (nonatomic ,assign) id <MCSendMessageViewDelegate> delegate;

//  移除键盘通知
- (void) removeKeyboardLison ;

//  添加键盘通知
- (void) addKeyboardLison ;

- (void) cleafData;

@end
