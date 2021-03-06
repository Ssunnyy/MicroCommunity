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
@property (nonatomic, strong) NSString *area_id;
@property (nonatomic, strong) NSString *c_id;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *hobby;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *like_book;
@property (nonatomic, strong) NSString *like_movie;
@property (nonatomic, strong) NSString *marry_status;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *p_id;
@property (nonatomic, strong) NSString *profession;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *town_id;
@property (nonatomic, strong) NSString *username;



@end
