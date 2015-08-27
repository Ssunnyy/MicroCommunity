//
//  MCRecruitModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitModel.h"

@implementation MCRecruitModel

- (NSDictionary *)attributeMapDictionary {

    return  @{
              @"city_id":@"city_id",
              @"education":@"education",
              @"education_image":@"education_image",
              @"image":@"image",
              @"job_content":@"job_content",
              @"job_id":@"job_id",
              @"job_salary":@"job_salary",
              @"job_time":@"job_time",
              @"job_title":@"job_title",
              @"job_view_number":@"job_view_number",
              @"job_year":@"job_year",
              @"nickname":@"nickname",
              @"phone":@"phone",
              @"strong_demo":@"strong_demo",
              @"user_id":@"user_id",
              @"username":@"username",
              };
    
}

@end
