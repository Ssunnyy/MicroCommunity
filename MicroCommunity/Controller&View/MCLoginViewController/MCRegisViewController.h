//
//  MCRegisViewController.h
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

typedef enum
{
    LoginEnterRegist,//注册
    LoginEnterFoget,//忘记密码
    LoginEnterChange,//修改密码
} LoginEnterType;

@interface MCRegisViewController : BaseViewController

@property (nonatomic,assign) LoginEnterType type; // 1 注册 2忘记密码

@end
