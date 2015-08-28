//
//  MCUserModel.h
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCUserModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *birthday_day;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *city_status;
@property (nonatomic, strong) NSString *constellation_name;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *gold_number;
@property (nonatomic, strong) NSString *hobby;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *like_book;
@property (nonatomic, strong) NSString *like_movie;
@property (nonatomic, strong) NSString *live_area_id;
@property (nonatomic, strong) NSString *live_city_id;
@property (nonatomic, strong) NSString *live_province_id;
@property (nonatomic, strong) NSString *marry_status;
@property (nonatomic, strong) NSString *native_area_id;
@property (nonatomic, strong) NSString *native_city_id;
@property (nonatomic, strong) NSString *native_province_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *profession;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *user_type;// 0未提交  1待审核  2审核通过
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *seller_id;


@end
