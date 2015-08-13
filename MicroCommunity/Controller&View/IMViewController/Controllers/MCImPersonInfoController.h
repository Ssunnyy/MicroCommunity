//
//  MCImPersonInfoController.h
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    customeIn,
    friendIn,
    receiveFriendIn,
}intType;

@interface MCImPersonInfoController : BaseViewController

@property (nonatomic , strong) NSString *titleName;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic, assign) intType type; //  从那种控制器进入

@end
