//
//  MCHomeRecruitModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

/**
 *  求职Model
 */

@interface MCHomeRecruitModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *job_category_id;
@property (nonatomic, strong) NSString *job_id;
@property (nonatomic, strong) NSString *job_status;
@property (nonatomic, strong) NSString *job_time;
@property (nonatomic, strong) NSString *job_title;
@property (nonatomic, strong) NSString *job_year;
@property (nonatomic, strong) NSString *region_name;
@property (nonatomic, strong) NSString *sex;

@end
