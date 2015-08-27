//
//  MCProductModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCProductModel.h"

@implementation MCProductModel


- (NSDictionary *)attributeMapDictionary {
    return @{
             @"address":@"address",
             @"goods_add_time":@"goods_add_time",
             @"goods_comment_number":@"goods_comment_number",
             @"goods_company_id":@"goods_company_id",
             @"goods_id":@"goods_id",
             @"goods_image":@"goods_image",
             @"goods_message":@"goods_message",
             @"goods_name":@"goods_name",
             @"goods_praise_number":@"goods_praise_number",
             @"goods_price":@"goods_price",
             @"goods_view_number":@"goods_view_number",
             @"linkman":@"linkman",
             @"linkphone":@"linkphone",
             @"is_goods_collect":@"is_goods_collect",
             
             @"c_id":@"c_id",
             @"collect_status":@"collect_status",
             @"goods_huanxin_id":@"goods_huanxin_id",
             @"goods_money":@"goods_money",
             @"goods_user_id":@"goods_user_id",
             @"pay_type":@"pay_type",
             @"read_status":@"read_status",
             @"status":@"status",
             @"type_id":@"type_id",
             };
    
}

@end
