//
//  ASLocationViewController.h
//  ITotem
//
//  Created by qiuyan on 15-4-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"
#import "ASCityModel.h"

@protocol ASLocationDelegate <NSObject>

- (void)getLocation:(ASCityModel *)model;

@end

@interface ASLocationViewController : BaseViewController

@property (nonatomic, assign) id<ASLocationDelegate>delegate;


@end
