//
//  MCCreatTalkGroupController.h
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@protocol MCCreatTalkGroupControllerDelegate <NSObject>

- (void)aite:(NSArray *)aiteArr;

@end

@interface MCCreatTalkGroupController : BaseViewController

@property (nonatomic, retain) NSMutableArray *chooseArr;
@property (nonatomic, retain) NSMutableArray *exitArr;//前一个页面已经存在的

@property (assign, nonatomic) id<MCCreatTalkGroupControllerDelegate>qremindDelegate;

@end
