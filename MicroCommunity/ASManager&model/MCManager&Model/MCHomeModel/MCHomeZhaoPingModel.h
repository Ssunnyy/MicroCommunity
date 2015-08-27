//
//  MCHomeZhaoPingModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"  
/**
 * 招聘列表
 */

@interface MCHomeZhaoPingModel : ITTBaseModelObject


@property (nonatomic, strong) NSString *seller_id;
@property (nonatomic, strong) NSString *seller_image;
@property (nonatomic, strong) NSString *zhaopin_content;
@property (nonatomic, strong) NSString *zhaopin_id;
@property (nonatomic, strong) NSString *zhaopin_money;
@property (nonatomic, strong) NSString *zhaopin_time;
@property (nonatomic, strong) NSString *zhaopin_title;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *linkman;
@property (nonatomic, strong) NSString *linkphone;
@property (nonatomic, strong) NSString *view_number;
@property (nonatomic, strong) NSString *zhaopin_huan_id;
@property (nonatomic, strong) NSString *zhaopin_seller_id;



@end
