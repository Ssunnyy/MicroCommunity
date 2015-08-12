//
//  MCCompanyServerModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCCompanyServerModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *serverName;
@property (nonatomic, strong) NSString *serverId;
@property (nonatomic, strong) NSString *serverPrice;
@property (nonatomic, strong) NSString *serverIntro;
@property (nonatomic, strong) NSString *serverPic;
@end
