//
//  ASRegisterDetailViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASRegisterDetailViewController.h"
#import "UserManager.h"

@interface ASRegisterDetailViewController ()<UIAlertViewDelegate>

{
    /**
     *  是否同意协议
     */
    BOOL isAgree;
}

/**
 *  显示密码的右侧
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdRight;
/**
 *  scrollview的滚动距离
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

/**
 *  个人信息的背景
 */
@property (nonatomic, strong) IBOutlet UIView *msgBgView;
/**
 *  推荐view
 */
@property (nonatomic, strong) IBOutlet UIView *recommendView;
/**
 *  协议view
 */
@property (nonatomic, strong) IBOutlet UIView *protocolView;
/**
 *  电话号
 */
@property (nonatomic, strong) IBOutlet UITextField *phoneTextF;
/**
 *  密码
 */
@property (nonatomic, strong) IBOutlet UITextField *pwdTextF;
/**
 *  昵称
 */
@property (nonatomic, strong) IBOutlet UITextField *nickTextF;
/**
 *  推荐人
 */
@property (nonatomic, strong) IBOutlet UITextField *personTextF;
/**
 *  下一步btn
 */
@property (nonatomic, strong) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSString *userId;

@end

@implementation ASRegisterDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [self setNavigationBarStatus];
    [self setUpDate];
}
- (IBAction)inProtal:(UIButton *)sender {

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UserManager shareManager] cancelAllRequest];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)setUpViews
{
    [_msgBgView makeCornerRadius:10.0f];
    [_recommendView makeCornerRadius:10.0f];
    [_protocolView makeCornerRadius:10.0f];
    self.contentViewHeight.constant = 736;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [_scrollView addGestureRecognizer:recognizer];
    if (iPhone6) {
        _pwdRight.constant = 42;
    }
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"用户注册"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

- (void)setUpDate
{
    _phoneTextF.text = _phoneStr;
    isAgree = YES;
    switch (_userType) {
        case ASPersonTypeUser:
        {
            [_nextBtn setTitle:@"确认注册" forState:UIControlStateNormal];
            [_nextBtn setTitle:@"确认注册" forState:UIControlStateHighlighted];
        }
            break;
        case ASPersonTypeBusiness:
        {
            [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [_nextBtn setTitle:@"下一步" forState:UIControlStateHighlighted];
        }
            break;
    }
}

- (void)hiddenSecurePwd
{
    _pwdTextF.secureTextEntry = YES;
}

/**
 *  textfield键盘消失
 */
- (void)touchScrollView
{
    [_phoneTextF resignFirstResponder];
    [_pwdTextF resignFirstResponder];
    [_nickTextF resignFirstResponder];
    [_personTextF resignFirstResponder];
}

/**
 *  显示密码
 *
 *  @param sender
 */
- (IBAction)showPwdClick:(id)sender
{
    _pwdTextF.secureTextEntry = NO;
    [self performSelector:@selector(hiddenSecurePwd) withObject:self afterDelay:5.f];
}
/**
 *  同意协议
 *
 *  @param sender
 */
- (IBAction)protocolBtnClick:(UIButton *)sender
{
    if (sender.selected) {
        sender.selected = NO;
        isAgree = NO;
    }else {
        sender.selected = YES;
        isAgree = YES;
    }
}
- (IBAction)nextBtnClick:(id)sender
{
    if (!isAgree) {
        [ITTPromptView showMessage:@"请同意用户使用协议"];
        return;
    }
    
    if (![CommonHelp isvalidateMobile:self.phoneTextF.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    
    if (_pwdTextF.text.length < 6 || _pwdTextF.text.length > 20) {
        [ITTPromptView showMessage:@"密码长度在6~20位之间"];
        return;
    }
    
    if (_nickTextF.text.length == 0) {
        [ITTPromptView showMessage:@"请写下您的昵称"];
        return;
    }
    switch (_userType) {
        case ASPersonTypeUser:
        {
             [self registerQuestRequest];
        }
            break;
        case ASPersonTypeBusiness:
        {
            
            [self registerQuestRequest];
        }
            break;
    }

}

- (void)registerQuestRequest
{
    __weak ASRegisterDetailViewController *weakSelf = self;
    
    [[UserManager shareManager] requestRegisterWithParam:[self getRegisterParam] withIndicatorView:self.view withCancelRequestID:@"Register" onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic safeString:_phoneTextF.text ForKey:@"mobile"];
            [dic safeString:_pwdTextF.text ForKey:@"password"];
            
            [[UserManager shareManager] requestLoginWithParam:dic withIndicatorView:self.view withCancelRequestID:@"Login" onRequestFinish:^(MKNetworkOperation *operation) {
                if ([operation isSuccees]) {
                    
                    weakSelf.userId = [[operation.resultDic objectForKey:@"appUser"]objectForKey:@"id"];
                    switch (weakSelf.userType) {
                        case ASPersonTypeUser:
                            //  进入用户要进入的页面
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            break;
                        case ASPersonTypeBusiness:
                        {
                            //  跳过进入用户要进入的页面
                            //  否则进入认证页面
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"为了尽快树立自我品牌，请补全个人主页内容" delegate:self cancelButtonTitle:@"稍后完善" otherButtonTitles:@"立刻前往", nil];

                            [alert show];
                        }
                            break;
                        default:
                            break;
                    }
                    
                    [ITTPromptView showMessage:@"登录成功"];
                }else{
                    [ITTPromptView showMessage:[operation message]];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                
            } doSaveAccount:^UserModel *{
                UserModel * model = [[UserModel alloc]init];
                model.password = weakSelf.pwdTextF.text;
                model.mobile = weakSelf.phoneTextF.text;
                return model;
            }];
            
        }else{
            [ITTPromptView showMessage:[operation message]];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
    }];
}

#pragma  mark  --  uialertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 1:
        {
        }
            break;
        default:
            break;
    }
}

- (NSMutableDictionary *)getRegisterParam
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safeString:_phoneTextF.text ForKey:@"mobile"];
    [dic safeString:_pwdTextF.text ForKey:@"password"];
    [dic safeString:[NSString stringWithFormat:@"%d",_userType] ForKey:@"type"];
    [dic safeString:_nickTextF.text ForKey:@"nickname"];
    [dic safeString:_personTextF.text ForKey:@"referral"];
    return dic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
