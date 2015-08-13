//
//  ASLoginViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASLoginViewController.h"
#import "ASRegisterViewController.h"
#import "ASResetPassViewController.h"
#import "UserManager.h"
#import "UserModel.h"
#import "ASMainRequestManager.h"

@interface ASLoginViewController ()
/**
 *  logo距离上面的间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoTop;
/**
 *  电话文本框距屏幕左侧间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *phoneLeft;
/**
 *  密码距离屏幕左侧间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *pwdLeft;
/**
 *  密码文本框的宽
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *pwdWidth;
//页面逻辑
/**
 *  手机号码
 */
@property (nonatomic, strong) IBOutlet UITextField *phoneTextF;
/**
 *  密码
 */
@property (nonatomic, strong) IBOutlet UITextField *pwdTextF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fogetBtnRight;
@end

@implementation ASLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setNavigationBarStatus];
    [self enableKeyboardManger];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate HideTabBar];
    _pwdTextF.text = @"";
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UserManager shareManager] cancelAllRequest];
    [self disableKeyboardManager];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)setUpViews
{
    self.view.backgroundColor = BaseColor;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (iPhone6Plus) {
        self.pwdWidth.constant = 200;
        self.phoneLeft.constant = 90;
        self.pwdLeft.constant = 90;
        self.fogetBtnRight.constant = 40;
        self.logoTop.constant = 100;
    }else if (iPhone6){
        self.pwdWidth.constant = 155;
        self.phoneLeft.constant = 100;
        self.pwdLeft.constant = 100;
        self.fogetBtnRight.constant = 60;
    }
    if (is35InchScreen()) {
        self.logoTop.constant = 40;
    }
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    if (_enterType != LoginEnterTypeMy) {
        [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_btn.png") highImage:ImageNamed(@"back_btn_s.png")];
    }
    [self navlineViewIsHidden:YES];
    [self navBGAlpha];
}

#pragma mark -- 导航按钮左侧的点击事件
- (void)leftBarButtonClick:(id)sender {
    if (_enterType != LoginEnterTypeMy) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -- 按钮点击事件
/**
 *  注册按钮
 *
 *  @param sender
 */
- (IBAction)registerBtnClick:(id)sender {
    
    ASRegisterViewController *registerVC = [[ASRegisterViewController alloc] initWithNibName:@"ASRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

/**
 *  登录
 *
 *  @param sender 
 */

- (IBAction)loginBtnClick:(id)sender {
    if (![CommonHelp isvalidateMobile:_phoneTextF.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    if (_pwdTextF.text.length < 6 || _pwdTextF.text.length > 20) {
        [ITTPromptView showMessage:@"密码长度在6~20位之间"];
        return;
    }
    __weak ASLoginViewController *weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safeString:_phoneTextF.text ForKey:@"mobile"];
    [dic safeString:_pwdTextF.text ForKey:@"password"];
    
    [[UserManager shareManager] requestLoginWithParam:dic withIndicatorView:self.view withCancelRequestID:@"Login" onRequestFinish:^(MKNetworkOperation *operation) {
        if ([operation isSuccees]) {
            UserModel *model = [[UserModel alloc]initWithDataDic:[operation.resultDic objectForKey:@"appUser"]];
            
            [ITTPromptView showMessage:@"登录成功"];
            NSString *lastUserId = [USER_DEFAULT objectForKey:LastUserId];
            
            if ([model.userId isEqualToString:lastUserId]) {
                if (_enterType == LoginEnterTypeMy) {
                    [weakSelf removeFromParentViewController];
                    [weakSelf.view removeFromSuperview];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Login" object:nil];
                }else{
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                }
            }else {
                if (_enterType == LoginEnterTypeMy) {
                    [weakSelf removeFromParentViewController];
                    [weakSelf.view removeFromSuperview];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Login" object:nil];
                }else{
                    [weakSelf dismissViewControllerAnimated:NO completion:nil];
                }
                if ([NSThread isMainThread]) {
                    
                    [weakSelf jumpMainViewController];
                    
                }else
                {
                    [weakSelf performSelectorOnMainThread:@selector(jumpMainViewController) withObject:nil waitUntilDone:YES];
                }
                
            }
            [USER_DEFAULT setValue:model.userId forKey:LastUserId];
            [USER_DEFAULT synchronize];
        }else{
//            [ITTPromptView showMessage:@"登录失败"];
        }
        
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [ITTPromptView showMessage:@"请重新登录"];
    } doSaveAccount:^UserModel *{
        UserModel * model = [[UserModel alloc]init];
        model.password = weakSelf.pwdTextF.text;
        model.mobile = weakSelf.phoneTextF.text;
        return model;
    }];
}

- (void) jumpMainViewController {
    
    if (self.currentController) {
        popToThisContrller(self.currentController, 0);
    }
    
    AppDelegate * app =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app.tabbarController setSelectedTabIndex:0];
    [app.customTabBarView selectTabAtIndex:0];
}

/**
 *  忘记密码
 *
 *  @param sender
 */
- (IBAction)forgetBtnClick:(id)sender
{
    ASResetPassViewController *resetVC = [[ASResetPassViewController alloc] initWithNibName:@"ASResetPassViewController" bundle:nil];
    resetVC.type = 1;
    [self.navigationController pushViewController:resetVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
