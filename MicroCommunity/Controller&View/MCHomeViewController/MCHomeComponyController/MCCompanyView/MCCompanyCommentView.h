//
//  MCCompanyCommentView.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCompanyCommentViewDelegate <NSObject>

- (void) sendMessage:(NSString *) meessage;

@end

@interface MCCompanyCommentView : UIView

@property (nonatomic,assign) id <MCCompanyCommentViewDelegate> delegate;

- (void) clear;
- (void) hidenSelf;
- (void) showSelf;
- (void) removeKeyboardLison;
@end
