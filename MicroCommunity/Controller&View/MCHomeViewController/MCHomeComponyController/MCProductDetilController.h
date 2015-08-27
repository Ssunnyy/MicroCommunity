//
//  MCProductDetilController.h
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"
#import "MCHomeSearchModel.h"
#import "MCHomeZhaoPingModel.h"

typedef enum {
    zhaopingType,// 招聘
    productType//   产品
}inType;

@interface MCProductDetilController : BaseViewController

@property (nonatomic, strong) MCHomeSearchModel *searchModel;
@property (nonatomic, strong) MCHomeZhaoPingModel *zhaopinModel;

@property (nonatomic, assign) inType  type;

@end
