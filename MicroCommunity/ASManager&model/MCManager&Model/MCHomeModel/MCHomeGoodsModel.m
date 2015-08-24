//
//  MCHomeGoodsModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeGoodsModel.h"

@implementation MCHomeGoodsModel

- (NSDictionary *)attributeMapDictionary {

    return @{
             @"c_id":@"c_id",
             @"collect_status":@"collect_status",
             @"goods_add_time":@"goods_add_time",
             @"goods_company_id":@"goods_company_id",
             @"goods_id":@"goods_id",
             @"goods_message":@"goods_message",
             @"goods_money":@"goods_money",
             @"goods_name":@"goods_name",
             @"goods_price":@"goods_price",
             @"goods_user_id":@"goods_user_id",
             @"p_id":@"p_id",
             @"pay_type":@"pay_type",
             @"read_status":@"read_status",
             @"status":@"status",
             @"type_id":@"type_id",
             };
    
}

@end
