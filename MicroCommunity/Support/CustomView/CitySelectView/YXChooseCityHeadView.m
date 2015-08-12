//
//  YXChooseCityHeadView.m
//  YiXin
//
//  Created by qiuyan on 14-12-2.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "YXChooseCityHeadView.h"

@implementation YXChooseCityHeadView

- (id)init
{
    self = [super init];
    if (self) {
        [self setUpSearchBar];
    }
    return self;
}

- (void)setUpSearchBar
{
    _searchView = [[SearchBarView alloc] initWithIsNav:NO];
    [self addSubview:_searchView];
    
    int searchH;
    int searchW;
    int topSpace;
    if (iPhone6Plus) {
        searchH = 42;
        searchW = 384;
        topSpace = 18;
    }else if(iPhone6){
        searchH = 37;
        searchW = 395;
        topSpace = 11;
    }else{
        searchH = 35;
        searchW = 350;
        topSpace = 11;
    }
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(topSpace);
        make.width.equalTo(searchW);
        make.height.equalTo(searchH); //can pass array of views
        make.centerX.equalTo(self.mas_centerX).offset(25);
    }];
    [_searchView setSearchVWithBtnPlace:@"   输入城市名,拼音首字母..."];
    
//    [_searchView.setUps];
}


@end
