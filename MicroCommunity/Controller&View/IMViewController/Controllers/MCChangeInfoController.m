//
//  MCChangeInfoController.m
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCChangeInfoController.h"

@interface MCChangeInfoController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation MCChangeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [_textView makeCornerRadius:10];
    [self setNavigationBarTitle:_currentTitle];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"确定" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    self.textView.text = self.currenContent;
}

- (void)rightBarButtonClick:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(getCurrenContent:)]) {
        [_delegate getCurrenContent:_textView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
