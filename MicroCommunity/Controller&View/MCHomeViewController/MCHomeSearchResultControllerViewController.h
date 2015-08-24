//
//  MCHomeSearchResultControllerViewController.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"
typedef enum {
    customeSearch,// 没有搜索框
    otherSearch //   有搜索框
}SearchType;

@interface MCHomeSearchResultControllerViewController : BaseViewController

@property (nonatomic, assign) SearchType type;
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, strong) NSString *keyWorld;
@property (nonatomic, strong) NSString *category_id;
@end
