//
//  ASLoginViewController.h
//  ITotem
//
//  Created by qiuyan on 15-3-20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

typedef enum
{
    LoginEnterTypeMy,//从我的进入
    LoginEnterTypeOther,//其他页面进入
} LoginEnterType;


@interface ASLoginViewController : BaseViewController

@property (nonatomic, assign) LoginEnterType enterType;
@property (nonatomic, assign) UIViewController *currentController;


@end
