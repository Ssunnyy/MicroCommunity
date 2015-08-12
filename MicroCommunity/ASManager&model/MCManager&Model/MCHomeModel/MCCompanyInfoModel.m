//
//  MCCompanyInfoModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyInfoModel.h"

@implementation MCCompanyInfoModel

- (NSDictionary *)attributeMapDictionary {

    return @{
             @"companyName":@"companyName",
             @"cid":@"cid",
             @"userName":@"userName",
             @"phoneNum":@"phoneNum",
             @"address":@"address",
             @"companyIntro":@"companyIntro",
             @"erweiMaUrl":@"erweiMaUrl",
             };
}

@end
