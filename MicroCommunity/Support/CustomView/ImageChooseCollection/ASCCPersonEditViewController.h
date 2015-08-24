//
//  ASCCPersonEditViewController.h
//  aisuo
//
//  Created by adims on 15/3/12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#pragma  mark --  个人show编辑页面


typedef enum {

    CCShowPerson,
    BCShow
    
}TypeShow;

#import "BaseViewController.h"

@interface ASCCPersonEditViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property (nonatomic,strong) NSString *titls;
@property (nonatomic,strong) NSString *bar_id;
@property (nonatomic,assign) TypeShow type;


 @end
