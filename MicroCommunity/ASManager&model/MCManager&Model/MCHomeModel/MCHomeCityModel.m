//
//  MCHomeCityModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeCityModel.h"

@implementation MCHomeCityModel

- (NSDictionary *)attributeMapDictionary {
    return @{
             @"agency_id":@"agency_id",
             @"parent_id":@"parent_id",
             @"region_id":@"region_id",
             @"region_name":@"region_name",
             @"region_type":@"region_type",
             @"_child":@"_child",
             };
    
}

@end
