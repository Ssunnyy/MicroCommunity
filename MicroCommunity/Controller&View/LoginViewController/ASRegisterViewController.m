//
//  ASRegisterViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-20.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASRegisterViewController.h"
#import "UserManager.h"
#import "ASRegisterDetailViewController.h"

@interface ASRegisterViewController ()
{
    ///计数器
    int count;
    /**
     *  验证码
     */
    NSString *codeStr;
    /**
     *  验证码的右侧
     */
    __weak IBOutlet NSLayoutConstraint *codeRight;
}

/**
 *  提示信息
 */
@property (nonatomic, strong) IBOutlet UILabel *promptLab;

/**
 *  个人信息背景view
 */
@property (nonatomic, strong) IBOutlet UIView *msgBgView;
/**
 *  电话号码
 */
@property (nonatomic, strong) IBOutlet UITextField *phoneTextF;
/**
 *  验证码
 */
@property (nonatomic, strong) IBOutlet UITextField *codeTextF;
/**
 *  获取验证码
 */
@property (nonatomic, strong) IBOutlet UIButton *codeBtn;
/**
 *  身份view
 */
@property (nonatomic, strong) IBOutlet UIView *identityView;
/**
 *  结婚新人
 */
@property (nonatomic, strong) IBOutlet UIButton *marriedPersonBtn;
/**
 *  结婚从业者
 */
@property (nonatomic, strong) IBOutlet UIButton *marriedProvideBtn;

///定时器
@property (nonatomic, retain) NSTimer *timerCode;

/**
 *  用户类型
 */
@property (nonatomic, assign) ASPersonType personType;
@end

@implementation ASRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [self setNavigationBarStatus];
    [self setUpData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [AppDelegate HideTabBar];
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
    [_identityView makeCornerRadius:10.0f];
    _marriedPersonBtn.selected = YES;
    if (iPhone6) {
        codeRight.constant = 40;
    }
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"注册"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

- (void)setUpData
{
    _personType = ASPersonTypeUser;

}

//初始化timer
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
    [_codeBtn setTitle:[NSString stringWithFormat:@"%d秒后重新获取",count] forState:UIControlStateDisabled];
    [_codeBtn setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateNormal];
    [_codeBtn setBackgroundImage:ImageNamed(@"dengdaizhengma.png") forState:UIControlStateHighlighted];
    _codeBtn.enabled = NO;
    if (count == 0) {
        [self.timerCode invalidate];
        self.timerCode = nil;
        _codeBtn.enabled = YES;
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateHighlighted];
        [_codeBtn setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateNormal];
        [_codeBtn setBackgroundImage:ImageNamed(@"huoquyanzhengma.png") forState:UIControlStateHighlighted];
    }
}
/**
 *  选择结婚新人还是结婚从业者
 *
 *  @param sender 
 */
- (IBAction)marryTypeClick:(UIButton *)sender
{
    UIButton *btnPerson = (UIButton *)[self.view viewWithTag:601];
    UIButton *btnPrivode = (UIButton *)[self.view viewWithTag:602];
    btnPerson.selected = NO;
    btnPrivode.selected = NO;
    
    sender.selected = YES;

    switch (sender.tag) {
        case 601:
        {
            _personType = ASPersonTypeUser;
        }
            break;
        case 602:
        {
            _personType = ASPersonTypeBusiness;
        }
            break;
    }
}

- (IBAction)getCodeClick:(id)sender
{
    ///判断是否是正确的手机号码
    if (![CommonHelp isvalidateMobile:self.phoneTextF.text]) {
        [CommonHelp promptMessage:@"请输入正确的手机号码!" withCancelStr:nil withConfirmStr:@"确定"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safeString:_phoneTextF.text ForKey:@"mobile"];
    __weak ASRegisterViewController *weakSelf = self;
    [[UserManager shareManager] requestGetCodeWithParam:dic withIndicatorView:self.view withCancelRequestID:@"GetCode" onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            [weakSelf setUpTimer];
            codeStr = [operation.resultDic objectForKey:@"identifyCode"];
        }else{
            [ITTPromptView showMessage:[operation message]];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)nextBtnClick:(id)sender
{    
    _promptLab.hidden = YES;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_phoneTextF.text.length == 0) {
        [ITTPromptView showMessage:@"请输入手机号"];
        return;
    }
    
    if (_codeTextF.text.length == 0) {
        [ITTPromptView showMessage:@"请输入验证码"];
        return;
    }
    
    if (![_codeTextF.text isEqualToString:codeStr]) {
        _promptLab.hidden = NO;
        return;
    }
    
    [dic safeString:_phoneTextF.text ForKey:@"mobile"];
    [dic safeString:_codeTextF.text ForKey:@"identifyCode"];
    [[UserManager shareManager] requestConfirmCodeWithParam:dic withIndicatorView:self.view withCancelRequestID:@"ConfirmCode" onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            ASRegisterDetailViewController *registerDetailVC = [[ASRegisterDetailViewController alloc] initWithNibName:@"ASRegisterDetailViewController" bundle:nil];
            registerDetailVC.userType = _personType;
            registerDetailVC.phoneStr = _phoneTextF.text;
            [self.navigationController pushViewController:registerDetailVC animated:YES];
        }
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
