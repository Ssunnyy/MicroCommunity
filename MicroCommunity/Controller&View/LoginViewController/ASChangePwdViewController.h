//
//  ASChangePwdViewController.h
//  ITotem
//
//  Created by qiuyan on 15-3-21.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@interface ASChangePwdViewController : BaseViewController

@property (nonatomic , assign) int type; // 1.表示个人账号修改密密 2.表示个人支付密码修改
@property (nonatomic , strong) NSString *pawePass;
@property (nonatomic , strong) NSString *currentTitle;
@end
