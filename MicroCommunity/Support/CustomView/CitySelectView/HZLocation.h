//
//  HZLocation.m
//  areapicker
//
//  Created by Cloud Dai on 15-8-17.
//  Copyright (c) 2015年 clouddai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZLocation : NSObject

@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *stateId;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *districtId;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
