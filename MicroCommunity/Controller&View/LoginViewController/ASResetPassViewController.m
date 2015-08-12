//
//  ASResetPassViewController.m
//  ITotem
//
//  Created by adims on 15/3/20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASResetPassViewController.h"
#import "CommonHelp.h"
#import "UserManager.h"
#import "ASMyRequestManager.h"

@interface ASResetPassViewController ()<UITextFieldDelegate>
{
    ///计数器
    int count;
    /**
     *  验证码
     */
    NSString *codeStr;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewTop;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *verificationCode;
@property (weak, nonatomic) IBOutlet UIView *phoneBgView;
@property (weak, nonatomic) IBOutlet UIView *verificationBgView;
@property (weak, nonatomic) IBOutlet UIView *passBgView;
@property (weak, nonatomic) IBOutlet UIView *verificationPassBgView;
@property (weak, nonatomic) IBOutlet UITextField *verificationText;
@property (weak, nonatomic) IBOutlet UITextField *pass1Text;
@property (weak, nonatomic) IBOutlet UITextField *paseText;
@property (weak, nonatomic) IBOutlet UILabel *placehodErrorMessage;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
/*
 页面逻辑
 */
///定时器
@property (nonatomic, retain) NSTimer *timerCode;

- (IBAction)sureBtnClick:(UIButton *)sender;
- (IBAction)verificationClick:(UIButton *)sender;

@end

@implementation ASResetPassViewController


- (void)awakFrom {
    
    if (is35InchScreen()) {
        _viewTop.constant = 67;
        _btnBottom.constant = 10;
    }
    
    [_bgView makeCornerRadius:10];
    [_phoneBgView makeCornerRadius:10];
    [_phoneBgView setBorderWidth:1 andBorderColor:BaseColor];
    [_verificationBgView makeCornerRadius:10];
    [_verificationBgView setBorderWidth:1 andBorderColor:BaseColor];
    [_passBgView makeCornerRadius:10];
    [_passBgView setBorderWidth:1 andBorderColor:BaseColor];
    [_verificationPassBgView makeCornerRadius:10];
    [_verificationPassBgView setBorderWidth:1 andBorderColor:BaseColor];
}

- (void) setNav{
    [AppDelegate HideTabBar];
    [self setNavigationBarTitle:@"重新设置密码"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_icon_.png")];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableKeyboardManger];
    [self setNav];
    [self awakFrom];
    [self setPassType];
    // Do any additional setup after loading the view from its nib.
}

- (void)setPassType{

    if (_type == 2) {
        _paseText.keyboardType = UIKeyboardTypeNumberPad;
        _pass1Text.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UserManager shareManager] cancelAllRequest];
    [[ASMyRequestManager shareManager]cancelAllRequest];
}

- (void)leftBarButtonClick:(id)sender
{
    [_phoneText resignFirstResponder];
    [_verificationText resignFirstResponder];
    [_pass1Text resignFirstResponder];
    [_paseText resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)sureBtnClick:(UIButton *)sender
{
    _placehodErrorMessage.hidden = YES;
    
    if (![_verificationText.text isEqualToString:codeStr]) {
        _placehodErrorMessage.hidden = NO;
        return;
    }
    
    if (![_paseText.text isEqualToString:_pass1Text.text]) {
        [ITTPromptView showMessage:@"两次输入的密码不一致"];
        return;
    }
    
    if (self.type == 1) { //    忘记密码
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeString:_phoneText.text ForKey:@"mobile"];
        [dic safeString:_verificationText.text ForKey:@"identifyCode"];
        [dic safeString:_pass1Text.text ForKey:@"newPwd"];
        [[UserManager shareManager] requestForgetPwdWithParam:dic withIndicatorView:self.view withCancelRequestID:@"ForgerPwd" onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                [ITTPromptView showMessage:[operation message]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ITTPromptView showMessage:[operation message]];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            
        }];
    } else  {// 忘记支付密码
        
        
        if (_pass1Text.text.length != 6) {
            [ITTPromptView showMessage:@"支付密码为6位数字"];
            return;
        }
        
        __weak ASResetPassViewController *weak = self;
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        NSString *userId =  [[UserManager shareManager] getCurrentUser].userId;
        [param safeString:userId ForKey:@"userid"];
        [param safeString:_pass1Text.text ForKey:@"paypwd"];
        
        [[ASMyRequestManager shareManager]requestMysetMyalipayorPwdWithParam:param withIndicatorView:self.view withCancelRequestID:@"setPayPwd" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                 [ITTPromptView showMessage:@"支付密码修改成功"];
                [weak.navigationController popViewControllerAnimated:YES];
            }else {
                [ITTPromptView showMessage:@"支付密码修改失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"支付密码修改失败"];
        }];
    }
}

- (IBAction)verificationClick:(UIButton *)sender {
    
    ///判断是否是正确的手机号码
    if (![CommonHelp isvalidateMobile:self.phoneText.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    
    if (_type == 2) {
        NSString *phone = [[UserManager shareManager]getCurrentUser].mobile;
        if (![phone isEqualToString:_phoneText.text]) {
            
            [ITTPromptView showMessage:@"请输入您注册时的手机号"];
            return;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safeString:_phoneText.text ForKey:@"mobile"];
    __weak ASResetPassViewController *weakSelf = self;
    [[UserManager shareManager] requestGetCodeWithParam:dic withIndicatorView:self.view withCancelRequestID:@"GetCode" onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [weakSelf setUpTimer];
            codeStr = [operation.resultDic objectForKey:@"identifyCode"];
            [ITTPromptView showMessage:@"验证码已发往手机、请注意查收"];

        }else{
            [ITTPromptView showMessage:[operation message]];
            sender.enabled = YES;
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        sender.enabled = YES;
    }];
}

///初始化timer
- (void)setUpTimer
{
    count = 120;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    self.timerCode = timer;
}

#pragma mark -- 倒计时
- (void)countDown:(NSTimer *)timer
{
    
    count -- ;
    [_verificationCode setTitle:[NSString stringWithFormat:@"%d秒后重新获取",count] forState:UIControlStateDisabled];
    [_verificationCode setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateNormal];
    [_verificationCode setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateHighlighted];
    _verificationCode.enabled = NO;
    if (count == 0) {
        [self.timerCode invalidate];
        self.timerCode = nil;
        _verificationCode.enabled = YES;
        [_verificationCode setTitle:@"重新获取" forState:UIControlStateNormal];
        [_verificationCode setTitle:@"重新获取" forState:UIControlStateHighlighted];
        [_verificationCode setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateNormal];
        [_verificationCode setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateHighlighted];
    }
}


#pragma  mark  --  textViewDelegate 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.bgView endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField.tag == 10) {
        if (textField.text.length != 0) {
                self.sureBtn.enabled = YES;
                [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"denglu2.png"] forState:UIControlStateNormal];
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (self.type == 2) {
        
        if (textField == _pass1Text || textField == _paseText) {
            NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
            if ([toBeString length] > 6) { //如果输入框内容大于20则弹出警告
                textField.text = [toBeString substringToIndex:6];
                return NO;
            }
            return YES;
        }else {
            return  YES;
        }
    }else {
        return YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
