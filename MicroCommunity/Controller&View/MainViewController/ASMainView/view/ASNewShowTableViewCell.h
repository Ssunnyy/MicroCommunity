//
//  ASNewShowTableViewCell.h
//  ITotem
//
//  Created by adims on 15/3/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMainBCCCModel.h"
@class ASNewShowTableViewCell;

@protocol ASCCCenterDelegate <NSObject>

- (void)enterCenter:(ASNewShowTableViewCell *)cell;

@end


@interface ASNewShowTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIView *headTopView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;//删除按钮

//  背景图片高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageHeight;
//  阴影宽高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBgViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBgViewHeight;
//  阴影顶部view宽高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTopViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTopViewHeight;

//  底部文字杯具高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHeight;
//  性别位置
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexHorizontalSize;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexVerticalSize;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *name_head_height;
@property (weak, nonatomic) IBOutlet UILabel *collectionLab;

//  背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

//  性别
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//  昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
//  简介
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *zanImageView;

@property (nonatomic, assign) id<ASCCCenterDelegate>delegate;

//  通过model 设置cell内容
- (void)setContentCell:(ASMainBCCCModel *)model;
@end
