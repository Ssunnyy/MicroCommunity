//
//  MCMyMessageModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCMyMessageModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *messageDate;

@end
