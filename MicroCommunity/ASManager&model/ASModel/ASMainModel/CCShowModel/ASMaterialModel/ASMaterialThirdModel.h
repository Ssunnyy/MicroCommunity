//
//  ASMaterialThirdModel.h
//  ITotem
//
//  Created by adims on 15/3/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "ASCollectModel.h"

@interface ASMaterialThirdModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *appUserId;
@property (nonatomic, strong) ASCollectModel *collect;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *favCount;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *materialImg;
@property (nonatomic, strong) NSString *materialPreviewImg;
@property (nonatomic, strong) NSString *materialName;
@property (nonatomic, strong) NSString *secondMaterial;
@property (nonatomic, strong) NSString *secondMaterialId;
@property (nonatomic, strong) NSString *showOrder;
@property (nonatomic, strong) NSString *uploadTime;
@property (nonatomic, strong) NSString *uploadType;
@end
