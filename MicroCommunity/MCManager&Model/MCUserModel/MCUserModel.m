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
            @"phone":@"phone",
            @"user_id":@"user_id",
            @"password":@"password",
            @"token":@"token",
            @"add_time":@"add_time",
            @"age":@"age",
            @"area_id":@"area_id",
            @"c_id":@"c_id",
            @"city_id":@"city_id",
            @"hobby":@"hobby",
            @"image":@"image",
            @"like_book":@"like_book",
            @"like_movie":@"like_movie",
            @"marry_status":@"marry_status",
            @"nickname":@"nickname",
            @"p_id":@"p_id",
            @"profession":@"profession",
            @"sex":@"sex",
            @"town_id":@"town_id",
            @"username":@"username",
            
    };
}

@end
