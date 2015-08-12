//
//  MCUserSearchCell.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCUserSearchCell.h"
#import "ZHPickView.h"

@interface MCUserSearchCell ()<ZHPickViewDelegate>

@property (nonatomic, strong) ZHPickView *pickview;

@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *hunLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak, nonatomic) IBOutlet UILabel *xingZuo;

@end

@implementation MCUserSearchCell

- (void)awakeFromNib {
    // Initialization code
}
/*
 *   300性别 301婚姻 302年龄 303文化 304星座
 */
- (IBAction)chooseBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 300:
        {
            NSArray *array=@[@"不限",@"男",@"女"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 400;
        }
            break;
        case 301:
        {
            NSArray *array=@[@"不限",@"已婚",@"未婚"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 401;
        }
            break;
        case 302:
        {
            NSArray *array=@[@"不限",@"18岁以下",@"18岁-22岁",@"23岁-26岁",@"27岁-35岁",@"35岁以上"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 402;
        }
            break;
        case 303:
        {
            NSArray *array=@[@"不限",@"小学",@"初中",@"高中及大专",@"大专",@"本科",@"硕士及以上"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 403;
        }
            break;
        case 304:
        {
            NSArray *array=@[@"不限",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天枰座",@"天蝎座",@"射手座",@"魔蝎座",@"水瓶座",@"双鱼座"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 404;
        }
            break;
        default:
            break;
    }
    
    _pickview.delegate=self;
    [_pickview show];
}
// 400 401
- (IBAction)okBtnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchConditionSex:AndHunYin:AndAge:AndCollege:AndConstellation:AndTag:)]) {
        [_delegate searchConditionSex:_sexLab.text AndHunYin:_hunLab.text AndAge:_ageLab.text AndCollege:_college.text AndConstellation:_xingZuo.text AndTag:sender.tag];
    }
    
}

#pragma  mark  --  ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    switch (pickView.tag) {
        case 400:
        {
            _sexLab.text = resultString;
        }
            break;
        case 401:
        {
            _hunLab.text = resultString;
        }
            break;
        case 402:
        {
            _ageLab.text = resultString;
        }
            break;
        case 403:
        {
            _college.text = resultString;
        }
            break;
        case 404:
        {
            _xingZuo.text = resultString;
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reset {


    _sexLab.text = @"不限";

    _hunLab.text = @"不限";

    _ageLab.text = @"不限";

    _college.text = @"不限";

    _xingZuo.text = @"不限";
 
}
@end
