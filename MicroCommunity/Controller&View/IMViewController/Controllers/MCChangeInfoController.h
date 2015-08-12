//
//  MCChangeInfoController.h
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@protocol MCChangeInfoControllerDelegate <NSObject>

- (void) getCurrenContent:(NSString *) content;

@end

@interface MCChangeInfoController : BaseViewController

@property (nonatomic,assign) id<MCChangeInfoControllerDelegate> delegate;

@property (nonatomic, strong)  NSString *currentTitle;
@property (nonatomic, strong) NSString *currenContent;

@end
