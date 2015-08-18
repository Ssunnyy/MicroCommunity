//
//  MCRegisViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRegisViewController.h"

#import "MCProtocolController.h"

@interface MCRegisViewController ()

{
    ///计数器
    int count;
    /**
     *  验证码
     */
    NSString *codeStr;
    /**
     *  定时器
     */
    NSTimer *timerCode;
    
    BOOL protocol;
}


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) IBOutlet UIView *passView;

@property (weak, nonatomic) IBOutlet UIView *protocolView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UITextField *passField;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

/**
 *  确认协议
 */
- (IBAction)sureProtocol:(UIButton *)sender;
/**
 *  确认协议
 */
- (IBAction)sureRegistAction:(UIButton *)sender;
/**
 *  获取验证码
 */
- (IBAction)code:(UIButton *)sender;
/**
 *  确认协议
 */
- (IBAction)protocolAction:(UIButton *)sender;
@end

@implementation MCRegisViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化界面
 */
- (void) initView {

    [_phoneView makeCornerRadius:10];
    [_codeView makeCornerRadius:10];
    [_passView makeCornerRadius:10];
    [_bottomView makeCornerRadius:10];
    [_okBtn makeCornerRadius:10];
    
    if (_type == LoginEnterFoget || _type == LoginEnterChange) {
        _titleLable.hidden = YES;
        _protocolView.hidden = YES;
        _passField.placeholder = @"新密码";
    }
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    switch (_type) {
        case LoginEnterRegist:
        {
            [self setNavigationBarTitle:@"用户注册"];
        }
            break;
        case LoginEnterFoget:
        {
            [self setNavigationBarTitle:@"重置密码"];
        }
            break;
        case LoginEnterChange:
        {
            [self setNavigationBarTitle:@"修改密码"];
        }
            break;
        default:
            break;
    }
    
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

/**
 *  确认协议
 */
- (IBAction)sureProtocol:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    protocol = sender.selected;
}
/**
 *  确认注册
 */
- (IBAction)sureRegistAction:(UIButton *)sender{
    
    [self sureRegist];
}
/**
 *  获取验证码
 */
- (IBAction)code:(UIButton *)sender {
    
    if (![CommonHelp isvalidateMobile:_phoneField.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    
    __block MCRegisViewController *weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:_phoneField.text ForKey:@"phone"];
    
    [[MCUserManager shareManager] requestCodeWithParam:param withIndicatorView:self.view withCancelRequestID:Request_User_GetCode withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [ITTPromptView showMessage:@"验证码获取成功,请注意查收"];
//            codeStr = operation.resultDic1
            [weakSelf setUpTimer];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [ITTPromptView showMessage:@"验证码获取失败,请重新获取"];
    
    }];
    
}
/**
 *  确认协议
 */
- (IBAction)protocolAction:(UIButton *)sender {
    MCProtocolController *pro = [[MCProtocolController alloc]init];
    pro.protocolUrl = @"http://www.baidu.com";
    [self.navigationController pushViewController:pro animated:YES];
}


//初始化timer
- (void)setUpTimer
{
    count = 60;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    timerCode = timer;
}


#pragma mark -- 倒计时
- (void)countDown:(NSTimer *)timer
{
    
    count -- ;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒后重新获取",count] forState:UIControlStateDisabled];
    [_codeBtn setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateNormal];
    [_codeBtn setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateHighlighted];
    _codeBtn.enabled = NO;
    if (count == 0) {
        [timerCode invalidate];
        timerCode = nil;
        _codeBtn.enabled = YES;
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateHighlighted];
        [_codeBtn setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateNormal];
        [_codeBtn setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateHighlighted];
    }
}


- (void) sureRegist {

    if (![CommonHelp isvalidateMobile:_phoneField.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    
    if (_passField.text.length < 8 || _passField.text.length > 20) {
        [ITTPromptView showMessage:@"密码长度在8~20位之间"];
        return;
    }
    
//    if (![_codeField.text isEqualToString:codeStr]) {
//        [ITTPromptView showMessage:@"验证码不正确"];
//        return;
//    }
    
    switch (_type) {
        case LoginEnterRegist:
        {
            ///////  注册   //////////
            if (!protocol) {
                [ITTPromptView showMessage:@"需同意用户隐私"];
                return;
            }
            [self requestToRegist];
        }
            break;
        case LoginEnterFoget:
        {
            ///////  重置密码   //////////
            [self requestToReset];
        }
            break;
        case LoginEnterChange:
        {
            [self requestToReset];
        }
            break;
            
        default:
            break;
    }
    
}
/**
 *  注册请求
 */
- (void) requestToRegist {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:_phoneField.text ForKey:@"phone"];
    [param safeString:_passField.text ForKey:@"password"];
    
    [[MCUserManager shareManager]requestRegisterWithParam:param withIndicatorView:self.view withCancelRequestID:Request_User_Regist onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [ITTPromptView showMessage:@"注册成功"];
            [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:0];
        }
        
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [ITTPromptView showMessage:@"注册失败"];
    }];
    
}
/**
 *  重置请求
 */

- (void) requestToReset {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:_phoneField.text ForKey:@"phone"];
    [param safeString:_passField.text ForKey:@"new_password"];
    
    [[MCUserManager shareManager]requestResetPassWithParam:param withIndicatorView:self.view withCancelRequestID:Request_User_ResetPass withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        
        if (operation.isSuccees) {
            [ITTPromptView showMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [ITTPromptView showMessage:@"修改失败"];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        
        [ITTPromptView showMessage:@"修改失败"];
    }];
    
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
