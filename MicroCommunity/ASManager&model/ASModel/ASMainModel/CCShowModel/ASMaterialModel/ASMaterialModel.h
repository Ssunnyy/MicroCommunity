//
//  ASMaterialModel.h
//  ITotem
//
//  Created by adims on 15/3/12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "ASCollectModel.h"

@interface ASMaterialModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *isCollection;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *ids;            //  当前的id
@property (nonatomic, strong) NSString *materialImg;
@property (nonatomic, strong) NSString *materialPreviewImg;
@property (nonatomic, strong) NSString *materialName;
@property (nonatomic, strong) NSString *showOrder;
@property (nonatomic, strong) NSString *firstMaterialId;//  一级的id
@property (nonatomic, strong) ASCollectModel *collect;

@end

