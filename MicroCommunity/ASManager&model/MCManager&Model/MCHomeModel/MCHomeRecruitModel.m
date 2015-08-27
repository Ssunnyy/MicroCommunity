//
//  MCHomeRecruitModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeRecruitModel.h"

@implementation MCHomeRecruitModel


- (NSDictionary *)attributeMapDictionary{
    return @{
             @"age":@"age",
             @"education":@"education",
             @"image":@"image",
             @"job_category_id":@"job_category_id",
             @"job_id":@"job_id",
             @"job_status":@"job_status",
             @"job_time":@"job_time",
             @"job_title":@"job_title",
             @"job_year":@"job_year",
             @"region_name":@"region_name",
             @"sex":@"sex",
             };
    
}

@end
