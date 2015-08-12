//
//  ASCCImageShowModel.h
//  ITotem
//
//  Created by adims on 15/3/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "ASCollectModel.h"

@interface ASCCImageShowModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *appUserId;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *showImg;
@property (nonatomic, strong) NSString *uplodaTime;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) ASCollectModel *collect;
@property (nonatomic, assign) BOOL isFirst;

@end
