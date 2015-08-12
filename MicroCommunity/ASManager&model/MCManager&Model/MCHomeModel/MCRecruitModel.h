//
//  MCRecruitModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCRecruitModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *recruitId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *recruitCityId;
@property (nonatomic, strong) NSString *recruitPhone;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *bgImage;

@property (nonatomic, strong) NSString *recruitName;
@property (nonatomic, strong) NSString *recruitPrice;
@property (nonatomic, strong) NSString *recruitDate;
@property (nonatomic, strong) NSString *seeCount;

@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *workYear;
@property (nonatomic, strong) NSString *likeStirng;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *educationImages;

@end
