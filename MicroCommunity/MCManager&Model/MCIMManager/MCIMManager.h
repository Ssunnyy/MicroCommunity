//
//  MCIMManager.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "YXBaseRequestManager.h"

@interface MCIMManager : YXBaseRequestManager

/**
 *  @brief  创建MCIMManager的manager
 **/
+ (MCIMManager *)shareManager;

@end
