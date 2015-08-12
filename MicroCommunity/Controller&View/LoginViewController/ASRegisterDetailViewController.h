//
//  ASRegisterDetailViewController.h
//  ITotem
//
//  Created by qiuyan on 15-3-20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@interface ASRegisterDetailViewController : BaseViewController

/**
 *  用户类型
 */
@property (nonatomic, assign) ASPersonType userType;
/**
 *  手机号码
 */
@property (nonatomic, strong) NSString *phoneStr;
@end
