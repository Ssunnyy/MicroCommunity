//
//  MCProductCityChooseController.h
//  MicroCommunity
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@protocol MCProductCityChooseControllerDelegate <NSObject>

- (void) chooseCitys:(NSArray *) citys;

@end

@interface MCProductCityChooseController : BaseViewController

@property (nonatomic,assign) id <MCProductCityChooseControllerDelegate> delegate;

@end
