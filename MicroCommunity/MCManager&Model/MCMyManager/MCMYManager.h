//
//  MCMYManager.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

@interface MCMYManager : YXBaseRequestManager

/**
 *  @brief  我的mamager
 **/

+ (MCMYManager *)shareManager;

@end
