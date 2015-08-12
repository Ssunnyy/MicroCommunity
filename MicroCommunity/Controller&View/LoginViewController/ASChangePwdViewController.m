//
//  ASChangePwdViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-21.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASChangePwdViewController.h"
#import "UserManager.h"
#import "UserModel.h"
#import "ASMyRequestManager.h"
#import "NSString+MD5Addition.h"

@interface ASChangePwdViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okBtnTop;

/**
 *  提示lab
 */
@property (nonatomic, strong) IBOutlet UILabel *promptLab;

/**
 *  个人信息的view
 */
@property (nonatomic, strong) IBOutlet UIView *msgBgView;
/**
 *  原密码
 */
@property (nonatomic, strong) IBOutlet UITextField *oldPwd;
/**
 *  新密码
 */
@property (nonatomic, strong) IBOutlet UITextField *nowPwd;
/**
 *  确认密码
 */
@property (nonatomic, strong) IBOutlet UITextField *confirmNowPwd;

/**
 *  确认按钮
 */
@property (nonatomic, strong) IBOutlet UIButton *comfirmBtn;


@end

@implementation ASChangePwdViewController

#pragma mark  --  取消请求

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    [[UserManager shareManager]cancelAllRequest];
    [[ASMyRequestManager shareManager]cancelAllRequest];
    [self disableKeyboardManager];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [self setNavigationBarStatus];
    [self configTextKeybord];
    [self enableKeyboardManger];
    if (_type == 2) {
        _nowPwd.placeholder = @"6位数字支付密码";
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void) configTextKeybord{

    if (self.type == 2) {
        _oldPwd.keyboardType = UIKeyboardTypeNumberPad;
        _nowPwd.keyboardType = UIKeyboardTypeNumberPad;
        _confirmNowPwd.keyboardType = UIKeyboardTypeNumberPad;
    }
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:self.currentTitle];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

- (void)setUpViews
{
    [_msgBgView makeCornerRadius:10.0f];
}

#pragma mark -- textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _oldPwd) {
        if (textField.text.length > 0) {
            _comfirmBtn.enabled = YES;
        }
    }
}

- (IBAction)confirmBtnClicl:(id)sender
{
    
    if (_type == 1) {
        NSString *pwdStr = [[UserManager shareManager] getCurrentUser].password;
        if (![_oldPwd.text isEqualToString:pwdStr]) {
            [ITTPromptView showMessage:@"请输入正确的原密码"];
            return;
        }
    }else {
        if (![[_oldPwd.text md5] isEqualToString:self.pawePass]) {
            [ITTPromptView showMessage:@"请输入正确的原密码"];
            return;
        }
        if (_nowPwd.text.length != 6) {
            [ITTPromptView showMessage:@"支付密码为6位数字"];
            return;
        }
    }
    if (![_nowPwd.text isEqualToString:_confirmNowPwd.text]) {
        [ITTPromptView showMessage:@"二次输入的密码不一致"];
        return;
    }
    //  账户
    if (_type == 1) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic safeString:[[UserManager shareManager] getCurrentUser].userId ForKey:@"appUserId"];
        [dic safeString:_oldPwd.text ForKey:@"orginalPwd"];
        [dic safeString:_nowPwd.text ForKey:@"newPwd"];
        [[UserManager shareManager] requestChangePwdWithParam:dic withIndicatorView:self.view withCancelRequestID:@"ChangePwd" onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ITTPromptView showMessage:[operation message]];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            
        }];
    }else {
        __weak ASChangePwdViewController *weak = self;
        //支付密码
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        NSString *userId =  [[UserManager shareManager] getCurrentUser].userId;
        [param safeString:userId ForKey:@"userid"];
        [param safeString:_confirmNowPwd.text ForKey:@"paypwd"];
        
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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_type == 2) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        if ([toBeString length] > 6) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
        return YES;
    }else {
        return YES;
    }
}

- (IBAction)cancelBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
