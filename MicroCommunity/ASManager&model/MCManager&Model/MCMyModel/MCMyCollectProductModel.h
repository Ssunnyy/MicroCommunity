//
//  MCMyCollectProductModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCMyCollectProductModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *c_id;
@property(nonatomic, strong)  NSString *collect_goods_id;
@property (nonatomic, strong) NSString *collect_status;
@property(nonatomic, strong)  NSString *collect_time;
@property (nonatomic, strong) NSString *collect_user_id;
@property(nonatomic, strong)  NSString *goods_add_time;
@property (nonatomic, strong) NSString *goods_collect_id;
@property(nonatomic, strong)  NSString *goods_company_id;
@property (nonatomic, strong) NSString *goods_id;
@property(nonatomic, strong)  NSString *goods_image;
@property (nonatomic, strong) NSString *goods_message;
@property(nonatomic, strong)  NSString *goods_money;
@property (nonatomic, strong) NSString *goods_name;
@property(nonatomic, strong)  NSString *goods_price;
@property (nonatomic, strong) NSString *goods_user_id;
@property(nonatomic, strong)  NSString *is_collect;
@property (nonatomic, strong) NSString *p_id;
@property(nonatomic, strong)  NSString *pay_type;
@property(nonatomic, strong)  NSString *read_status;
@property(nonatomic, strong)  NSString *status;
@property(nonatomic, strong)  NSString *type_id;

@end
