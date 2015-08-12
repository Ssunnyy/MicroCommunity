//
//  SearchBarView.m
//  Parking
//
//  Created by qiuyan on 14-11-18.
//
//

#import "SearchBarView.h"

@implementation SearchBarView

- (id)initWithIsNav:(BOOL)isNav
{
    self = [super init];
    if (self) {
        isSearchNav = isNav;
        searchV = [[UIView alloc] init];
        self.autoresizesSubviews = YES;
        self.backgroundColor = [UIColor clearColor];
        bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"sosuokuang.png"];

        _searchImg = [[UIImageView alloc] init];
        _searchImg.image = ImageNamed(@"icon_search_.png");
        
        _textField = [[UITextField alloc] init];
        self.textField.returnKeyType = UIReturnKeySearch;
        _textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
        self.textField.delegate = self;
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.textColor = RGBCOLOR(143, 143, 148);
        [self.textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventAllEditingEvents];
        
        clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [clearBtn setBackgroundImage:ImageNamed(@"guanbi") forState:UIControlStateNormal];
        [clearBtn setBackgroundImage:ImageNamed(@"guanbi") forState:UIControlStateHighlighted];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.backgroundColor = [UIColor clearColor];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
        [self.cancelBtn setTitleColor:RGBCOLOR(143, 143, 148) forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:RGBCOLOR(143, 143, 148) forState:UIControlStateHighlighted];
        
        [self addSubview:searchV];
        [searchV addSubview:bgImageView];
        [searchV addSubview:_textField];
        [searchV addSubview:clearBtn];
//        [self addSubview:self.cancelBtn];
    }
    return self;
}

- (void)textChanged:(UITextField*)textField
{
    if ([textField.text isEqualToString:@""]) {
        _textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    }
    if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarView:textDidChangedWithText:)]) {
        [_searchDelegate searchBarView:self textDidChangedWithText:textField.text];
    }
}

- (void)setSearchVWithBtnPlace:(NSString *)textPlaceHolder
{
    //搜索框的背景，搜索图片，textfield 清空按钮的容器view
    UIView *superview = self;
    [searchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.left).offset(0); //without with
        make.right.equalTo(superview.right).offset(-50); //without with
        make.height.equalTo (superview.height);
        make.centerY.mas_equalTo(superview.mas_centerY);
    }];
    
    int padding = 0;
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchV.top).offset(padding); //with with
        make.left.equalTo(searchV.left).offset(padding); //without with
        make.right.equalTo(searchV.right).offset(-padding);
        make.height.equalTo(searchV.height).offset(-padding);
    }];
    
    //搜索文本框
    placeHolder = textPlaceHolder;
    self.textField.placeholder = textPlaceHolder;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchV.left).offset(8); //without with
        make.right.equalTo(searchV.right).offset(-35); //without with
        make.height.equalTo(searchV.height).offset(0);
        make.centerY.mas_equalTo(searchV.mas_centerY).offset(0);
    }];
    
    if (isSearchNav) {
        float fontSize;
        int searchLeft;
        if (iPhone6Plus) {
            fontSize = 20;
            searchLeft = 90;
        }else if(iPhone6){
            fontSize = 18;
            searchLeft = 80;
        }else{
            fontSize = 18;
            searchLeft = 60;
        }
        [self.textField setValue:RGBCOLOR(222, 221, 222) forKeyPath:@"_placeholderLabel.textColor"];
        [self.textField setValue:[UIFont systemFontOfSize:fontSize] forKeyPath:@"_placeholderLabel.font"];
        [_searchImg updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(searchLeft);
        }];
    }else{
        [self.textField setValue:RGBCOLOR(143, 143, 148) forKeyPath:@"_placeholderLabel.textColor"];
        [self.textField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textField.right).offset(1); //without with
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.centerY.mas_equalTo(searchV.mas_centerY);
    }];
    
    self.cancelBtn.hidden = YES;
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchV.right).offset(6); //without with
        make.height.equalTo(@25);
        make.width.equalTo(@40);
        make.centerY.mas_equalTo(superview.mas_centerY);
    }];
}

- (void)clearText
{
   _textField.text = @"";
}

#pragma 取消 情况 按钮事件
- (void)cancelBtnClick:(id)sender
{
    _textField.text = @"";
    [_textField resignFirstResponder];
    _textField.placeholder = placeHolder;
    self.cancelBtn.hidden = YES;
    if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarViewCancel:)]) {
        [_searchDelegate searchBarViewCancel:self];
    }
}

- (void)clearBtnClick:(id)sender
{
    _textField.text = @"";
    if(_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarViewdidClearText:)])
    {
        [_searchDelegate searchBarViewdidClearText:self];
    }
}

#pragma mark -- textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.cancelBtn.hidden = NO;
    self.textField.placeholder = @"";
    if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarViewDidBeginEditing:)]) {
        [_searchDelegate searchBarViewDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        textField.enablesReturnKeyAutomatically = NO; //这里设置为无文字就灰色可点
    }
    [self.textField resignFirstResponder];
    if(_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarViewDidEndEditing:)])
    {
        [_searchDelegate searchBarViewDidEndEditing:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *searchText = [_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarView: inputCompleted:)])
    {
        [_searchDelegate searchBarView:self inputCompleted:searchText];
        self.cancelBtn.hidden = YES;
//        self.textField.text = @"";
    }
    [self.textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (_searchDelegate && [_searchDelegate respondsToSelector:@selector(searchBarView:textChanged:)]) {
        [_searchDelegate searchBarView:self textChanged:string];
    }
    
    return YES;
}
-(void)hidenKeyboard
{
    [_textField resignFirstResponder];
//    self.cancelBtn.hidden = YES;
}
@end
