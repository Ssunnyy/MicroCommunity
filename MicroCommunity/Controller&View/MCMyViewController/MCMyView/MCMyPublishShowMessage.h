//
//  MCMyPublishShowMessage.h
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyPublishShowMessageDelegate <NSObject>

- (void) sureOrCancel:(NSInteger) index;

@end

@interface MCMyPublishShowMessage : UITableViewCell

@property (nonatomic, assign) id <MCMyPublishShowMessageDelegate> delegate;

- (void) changeMessage:(NSString *) message;

- (void) hidenMessage;
- (void) showMessage;

@end
