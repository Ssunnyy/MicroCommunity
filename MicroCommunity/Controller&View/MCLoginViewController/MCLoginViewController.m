//
//  MCLoginViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCLoginViewController.h"
#import "MCRegisViewController.h"

@interface MCLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logBottomHeight;
@end

@implementation MCLoginViewController


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    _passwordTextField.text = @"";
    [AppDelegate HideTabBar];
}

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
    [_logBtn makeCornerRadius:10];
    if (iPhone6) {
        _lineHeight.constant = 55;
    }else if (iPhone6Plus) {
        _lineHeight.constant = 65;
    }else if (is35InchScreen()) {
        _logBottomHeight.constant = 0;
    }
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"登陆"];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"注册" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    
}
/**
 *  登陆事件
 */
- (IBAction)loginAction:(id)sender {
    
    if (![CommonHelp isvalidateMobile:_phoneTextView.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    if (_passwordTextField.text.length < 8 || _passwordTextField.text.length > 20) {
        [ITTPromptView showMessage:@"密码长度在8~20位之间"];
        return;
    }
    __weak MCLoginViewController *weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safeString:_phoneTextView.text ForKey:@"phone"];
    [dic safeString:_passwordTextField.text ForKey:@"password"];
    
    
    [[MCUserManager shareManager] requestLoginWithParam:dic withIndicatorView:self.view withCancelRequestID:@"Login" onRequestFinish:^(MKNetworkOperation *operation) {
        if ([operation isSuccees]) {
            
            [ITTPromptView showMessage:@"登录成功"];
        
            MCUserModel *model = [[MCUserModel alloc]initWithDataDic:operation.resultDic];
            model.password = weakSelf.passwordTextField.text;
            model.image = [NSString stringWithFormat:@"%@%@",Main_URL,model.image];
            [[MCUserManager shareManager]safeAccountToLocal:model];
            [[MCUserManager shareManager] setAutoLogin:YES];
            [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:0];
            
        }else{
            [ITTPromptView showMessage:@"登录失败"];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        
        [ITTPromptView showMessage:@"请重新登录"];
        
    } doSaveAccount:^UserModel *{
        UserModel * model = [[UserModel alloc]init];
        model.password = weakSelf.passwordTextField.text;
        model.mobile = weakSelf.phoneTextView.text;
        return model;
    }];
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
 *  忘记密码
 */
- (IBAction)fogetPassAction:(id)sender {
    
    MCRegisViewController *regis = [[MCRegisViewController alloc] initWithNibName:@"MCRegisViewController" bundle:nil];
    regis.type = LoginEnterFoget;
    [self.navigationController pushViewController:regis animated:YES];
    
}
/**
 *  三方登陆
 */
- (IBAction)otherLoginAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 200:
        {
            ///////////////  qq  登陆  ///////////
        }
            break;
        case 201:
        {
            ///////////////  微信  登陆  ///////////
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

    MCRegisViewController *regis = [[MCRegisViewController alloc] initWithNibName:@"MCRegisViewController" bundle:nil];
    regis.type = LoginEnterRegist;
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
