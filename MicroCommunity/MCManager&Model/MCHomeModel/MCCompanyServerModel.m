//
//  MCCompanyServerModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyServerModel.h"

@implementation MCCompanyServerModel


- (NSDictionary *)attributeMapDictionary {
    return @{
             @"serverName":@"serverName",
             @"serverId":@"serverId",
             @"serverPrice":@"serverPrice",
             @"serverIntro":@"serverIntro",
             @"serverPic":@"serverPic"
             };
    
}
@end
