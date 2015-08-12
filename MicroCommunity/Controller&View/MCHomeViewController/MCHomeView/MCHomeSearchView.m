//
//  MCHomeSearchView.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeSearchView.h"

@interface MCHomeSearchView ()

@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomArrow;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewWidth;


@end

@implementation MCHomeSearchView

- (void)awakeFromNib {

    [self.searchView makeCornerRadius:5];
    if (iPhone6) {
        self.searchViewWidth.constant = 240;
    } else if (iPhone6Plus) {
        self.searchViewWidth.constant = 280;
    }
}


/**
 *  选择城市
 */
- (IBAction)cityBtnClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(chooseCityBtnClick)]) {
        [_delegate chooseCityBtnClick];
    }
}
/**
 *  删除搜索信息
 */
- (IBAction)deleteBtnClick:(id)sender {
    
    self.searchTextField.text = @"";
}
/**
 *  搜索点击事件
 */
- (IBAction)searchBtnClick:(id)sender {
    
    [self.searchTextField resignFirstResponder];
    
    NSString *strUrl = [self.searchTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    if ([_delegate respondsToSelector:@selector(searchBarView:inputCompleted:)]) {
        [_delegate searchBarView:self inputCompleted:strUrl];
    }
}

//  设置城市
- (void) setCityWithString:(NSString *) city {
    self.cityLab.text = city;
    
}
//  设置搜索placeholder
- (void)setSearchVWithBtnPlace:(NSString *)textPlaceHolder {

    self.searchTextField.placeholder = textPlaceHolder;
}

- (void)backBtnChange{
    
    [self.leftBtn setImage:[UIImage imageNamed:@"back_icon_.png"] forState:UIControlStateNormal];
    self.bottomArrow.hidden = YES;
    self.cityLab.hidden = YES;
}

- (void)leftViewHiden{
    
    self.leftBtn.hidden = YES;
    self.bottomArrow.hidden = YES;
    self.cityLab.hidden = YES;
}


- (void) resignTextView {

    [_searchTextField resignFirstResponder];
    
}
- (void)changeRightBtnTitle:(NSString *)title {

    [_rightBtn setTitle:title forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
