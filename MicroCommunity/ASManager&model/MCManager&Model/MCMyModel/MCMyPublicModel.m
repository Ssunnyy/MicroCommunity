//
//  MCMyPublicModel.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyPublicModel.h"

@implementation MCMyPublicModel

- (NSDictionary *)attributeMapDictionary {
    
    return @{
             @"type":@"type",
             @"headImage":@"headImage",
             @"title":@"title",
             @"des":@"des",
             @"money":@"money",
             @"totalMoney":@"totalMoney",
             @"addMoney":@"addMoney",
             
             @"goods_id":@"goods_id",
             @"goods_image":@"goods_image",
             @"goods_message":@"goods_message",
             @"goods_money":@"goods_money",
             @"goods_name":@"goods_name",
             @"goods_price":@"goods_price",
             @"goods_sum_money":@"goods_sum_money",
             @"status":@"status"
             };
    
}

@end
