//
//  MCLoginViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCBundlingViewController.h"
#import "MCRegisViewController.h"

@interface MCBundlingViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation MCBundlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self setNavigationBarStatus];
    
    // Do any additional setup after loading the view from its nib.
}
/**
 *  初始化界面
 */
- (void) initView {

    [_topView makeCornerRadius:10];
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"绑定"];
    
}
/**
 *  登陆事件
 */
- (IBAction)loginAction:(id)sender {
    
    
    
}
/**
 *  清楚数据
 */
- (IBAction)clearInfo:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            _phoneTextView.text = @"";
        }
            break;
        case 101:
        {
            _passwordTextField.text = @"";
        }
            break;
        default:
            break;
    }
}

/**
 *  注册
 */
- (void)rightBarButtonClick:(UIButton *)button {

    MCRegisViewController *regis = [[MCRegisViewController alloc] init];
    regis.type = 1;
    [self.navigationController pushViewController:regis animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
