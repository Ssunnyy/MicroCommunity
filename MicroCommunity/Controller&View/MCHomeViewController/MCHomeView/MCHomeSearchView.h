//
//  MCHomeSearchView.h
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCHomeSearchView;

@protocol MCHomeSearchViewDelegate <NSObject>

@optional

// 搜索完成
-(void) searchBarView:(MCHomeSearchView *)searchBarView inputCompleted:(NSString *)searchText;

// 搜索取消
- (void) searchBarViewCancel:(MCHomeSearchView *)searchBarView;

// 搜索取消选择城市
- (void) chooseCityBtnClick;

@end


@interface MCHomeSearchView : UIView

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, assign) id<MCHomeSearchViewDelegate> delegate;
@property (nonatomic, assign) BOOL backChange;

//  设置城市
- (void) setCityWithString:(NSString *) city;
//  设置搜索placeholder
- (void)setSearchVWithBtnPlace:(NSString *)textPlaceHolder;
//  隐藏左侧的城市变返回按钮
- (void) backBtnChange;
//  隐藏左侧的按钮
- (void)leftViewHiden;

- (void) resignTextView;
//  修改右侧buttonTitle
- (void) changeRightBtnTitle:(NSString *)title;
@end
