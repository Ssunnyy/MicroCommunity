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
             @"productName":@"productName",
             @"productId":@"productId",
             @"productPrice":@"productPrice",
             @"productIntro":@"productIntro",
             @"productPic":@"productPic",
             @"productSeeCount":@"productSeeCount",
             @"productAddress":@"productAddress",
             @"productCommentCount":@"productCommentCount",
             @"productDate":@"productDate"
             };
    
}

@end
