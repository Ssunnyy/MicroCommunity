//
//  MCHomeCityModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCHomeCityModel : ITTBaseModelObject
@property (nonatomic, strong) NSString *agency_id;
@property (nonatomic, strong) NSString *parent_id;
@property (nonatomic, strong) NSString *region_id;
@property (nonatomic, strong) NSString *region_name;
@property (nonatomic, strong) NSString *region_type;
@property (nonatomic, strong) NSMutableArray *_child;


@end
