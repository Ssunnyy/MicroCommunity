//
//  ASMaterialModel.m
//  ITotem
//
//  Created by adims on 15/3/12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMaterialModel.h"

@implementation ASMaterialModel

- (NSDictionary *)attributeMapDictionary {
    return @{
             @"ids":@"id",
             @"materialImg":@"materialImg",
             @"materialName":@"materialName",
             @"showOrder":@"showOrder",
             @"index":@"index",
             @"image":@"image",
             @"materialPreviewImg":@"materialPreviewImg",
             @"isCollection":@"isCollection",
             @"firstMaterialId":@"firstMaterialId",
             @"collect":@"collect",
             @"pic":@"pic"
             };
}

@end
