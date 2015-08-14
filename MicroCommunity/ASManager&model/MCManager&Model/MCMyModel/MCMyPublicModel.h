//
//  MCMyPublicModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCMyPublicModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *headImage;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *des;
@property(nonatomic, strong) NSString *money;
@property(nonatomic, strong) NSString *totalMoney;
@property(nonatomic, strong) NSString *addMoney;
@property (nonatomic, strong) NSString *type;// 0 1 2发布中 已失效 已关闭
@property(nonatomic, assign) BOOL isChoose;

@end
