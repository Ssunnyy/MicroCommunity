//
//  ASCollectModel.h
//  ITotem
//
//  Created by adims on 15/4/8.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface ASCollectModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *appUserId;
@property (nonatomic, strong) NSString *collectSource;
@property (nonatomic, strong) NSString *collectType;
@property (nonatomic, strong) NSString *collectedId;
@property (nonatomic, strong) NSString *ids;

@end
