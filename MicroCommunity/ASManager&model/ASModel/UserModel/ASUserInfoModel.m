//
//  ASUserInfoModel.m
//  ITotem
//
//  Created by adims on 15/4/2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASUserInfoModel.h"

@implementation ASUserInfoModel

- (NSDictionary *)attributeMapDictionary {

    return @{
            @"headImg":@"headImg",
            @"cityId":@"cityId",
            @"nickName":@"nickname",
            @"personalSign":@"personalSign",
            @"gender":@"gender",
            @"backImg":@"backImg",
            @"mobile":@"mobile",
            @"loverNickname":@"loverNickname",
            @"marryDate":@"marryDate",
            @"jobId":@"jobId",
            @"bornYear":@"bornYear",
            @"workYear":@"workYear",
            @"serviceDoor":@"serviceDoor",
            @"serviceRemote":@"serviceRemote",
            @"serviceLanguage":@"serviceLanguage",
            @"other":@"other",
            @"realname":@"realname",
            @"user":@"user",
            @"praiseNum":@"praiseNum",
            @"hasContentNum":@"hasContentNum",
            @"badReviewNum":@"praiseNum",
            };
}

@end
