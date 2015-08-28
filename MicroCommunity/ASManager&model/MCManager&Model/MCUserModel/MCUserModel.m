//
//  MCUserModel.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

#import "MCUserModel.h"

@implementation MCUserModel

- (NSDictionary *)attributeMapDictionary {
    
    return @{
            @"user_id":@"user_id",
            @"phone":@"phone",
            @"password":@"password",
            @"token":@"token",
            @"add_time":@"add_time",
            @"age":@"age",
            @"birthday_day":@"birthday_day",
            @"city_id":@"city_id",
            @"city_status":@"city_status",
            @"constellation_name":@"constellation_name",
            @"education":@"education",
            @"gold_number":@"gold_number",
            @"hobby":@"hobby",
            @"image":@"image",
            @"like_book":@"like_book",
            @"like_movie":@"like_movie",
            @"live_area_id":@"live_area_id",
            @"live_city_id":@"live_city_id",
            @"live_province_id":@"live_province_id",
            @"marry_status":@"marry_status",
            @"native_area_id":@"native_area_id",
            @"native_city_id":@"native_city_id",
            @"native_province_id":@"native_province_id",
            @"nickname":@"nickname",
            @"profession":@"profession",
            @"sex":@"sex",
            @"status":@"status",
            @"type":@"type",
            @"user_type":@"user_type",
            @"username":@"username",
            @"seller_id":@"seller_id"
    };
}

@end
