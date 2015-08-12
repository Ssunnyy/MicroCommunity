//
//  ASMainShopTableViewCell.h
//  ITotem
//
//  Created by qiuyan on 15-3-4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMainBCCCModel.h"

typedef enum {
    MainUse,
    serachUse
}useType;

@class ASMainShopTableViewCell;

@protocol ASBCCenterDelegate <NSObject>

- (void)enterCenterBC:(ASMainShopTableViewCell *)cell;

@end

@interface ASMainShopTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *distaneBaseView;

@property (nonatomic, assign) useType useType;

@property (nonatomic, assign) id<ASBCCenterDelegate>bcdelegate;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (void)setContentCell:(ASMainBCCCModel *)model;

@end
