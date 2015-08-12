//
//  UserModel.m
//  YiXin
//
//  Created by keke on 14/12/1.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(NSDictionary *)attributeMapDictionary
{
    return @{
             @"backImg":@"backImg",
             @"city":@"city",
             @"distance":@"distance",
             @"cityId":@"cityId",
             @"citycn":@"citycn",
             @"createTime":@"createTime",
             @"gender":@"gender",
             @"headImg":@"headImg",
             @"userId":@"id",
             @"lastLoginTime":@"lastLoginTime",
             @"mobile":@"mobile",
             @"modifiedTime":@"modifiedTime",
             @"nickname":@"nickname",
             @"openGps":@"openGps",
             @"openPush":@"openPush",
             @"openShow":@"openShow",
             @"password":@"password",
             @"personalSign":@"personalSign",
             @"referralId":@"referralId",
             @"showIndex":@"showIndex",
             @"showOrder":@"showOrder",
             @"type":@"type",
             @"token":@"token",
             @"authStatus":@"authStatus",
             @"bcNum":@"bcNum",
             @"ccNum":@"ccNum",
             @"picNum":@"picNum",
             @"waitCommentNum":@"waitCommentNum",
             @"waitConfirmNum":@"waitConfirmNum",
             @"waitPayNum":@"waitPayNum",
             @"waitServiceNum":@"waitServiceNum",
             @"shouhouNum":@"shouhouNum",
             @"rongToken":@"rongToken",
             @"loverNickname":@"loverNickname",
             @"marryDate":@"marryDate"
             };
}
@end
