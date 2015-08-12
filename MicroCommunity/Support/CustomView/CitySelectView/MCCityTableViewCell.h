//
//  MCCityTableViewCell.h
//  RATreeView
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 Rafal Augustyniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RADataObject.h"
@interface MCCityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeftWidth;

@property (weak, nonatomic) IBOutlet UIButton *chooseSelect;
@property (weak, nonatomic) IBOutlet UIButton *jiantouBtn;


- (void) configCillWithCity:(RADataObject *)city;
- (void) hidenLine:(BOOL) hiden;
@end
