//
//  MCHomeSearchResultControllerViewController.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"
typedef enum {
    customeSearchc,// 没有搜索框
    otherSearchc //   有搜索框
}SearchTypes;

@interface MCRecruitController : BaseViewController

@property (nonatomic, assign) SearchTypes type;
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, strong) NSString *keyWorld;
@property (nonatomic, strong) NSString *category_id;


@end
