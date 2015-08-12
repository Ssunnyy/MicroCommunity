//
//  ASBCShowImgsModel.h
//  ITotem
//
//  Created by adims on 15/3/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "ASCollectModel.h"


@interface ASBCShowImgsModel : ITTBaseModelObject

@property (nonatomic, strong) NSString*bcShowImgsId;
@property (nonatomic, strong) NSString*cover;
@property (nonatomic, strong) NSString*des;
@property (nonatomic, strong) NSString*ids;
@property (nonatomic, strong) NSString*img;
@property (nonatomic, strong) NSString*updateTime;
@property (nonatomic, strong) NSString*uploadTime;

@property (nonatomic, strong) ASCollectModel *collect;//收藏
@end
