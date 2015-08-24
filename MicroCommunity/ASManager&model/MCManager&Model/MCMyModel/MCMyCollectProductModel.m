//
//  MCMyCollectProductModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCollectProductModel.h"

@implementation MCMyCollectProductModel

- (NSDictionary *)attributeMapDictionary {
    return @{   @"c_id":@"c_id",
                @"collect_goods_id":@"collect_goods_id",
                @"collect_status":@"collect_status",
                @"collect_time":@"collect_time",
                @"collect_user_id":@"collect_user_id",
                @"goods_add_time":@"goods_add_time",
                @"goods_collect_id":@"goods_collect_id",
                @"goods_company_id":@"goods_company_id",
                @"goods_id":@"goods_id",
                @"goods_image":@"goods_image",
                @"goods_message":@"goods_message",
                @"goods_money":@"goods_money",
                @"goods_name":@"goods_name",
                @"goods_price":@"goods_price",
                @"goods_user_id":@"goods_user_id",
                @"is_collect":@"is_collect",
                @"p_id":@"p_id",
                @"pay_type":@"pay_type",
                @"read_status":@"read_status",
                @"status":@"status",
                @"type_id":@"type_id",
       };
}

@end
