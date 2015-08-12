//
//  MCMySettingController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMySettingController.h"
#import "MCMyTableCell.h"
#import "MCRegisViewController.h"
#import "MCMyAboutUSController.h"
#import "MCMyIdearReoprtController.h"

@interface MCMySettingController ()

/**
 *  开启关闭接受消息
 */
- (IBAction)openOrCloseMessage:(UISwitch *)sender;
/**
 *  清除缓存
 */
- (IBAction)clearMemory:(UIButton *)sender;
/**
 *  意见反馈
 */
- (IBAction)idearReturn:(UIButton *)sender;
/**
 *  修改密码
 */
- (IBAction)changePass:(UIButton *)sender;
/**
 *  关于我们
 */
- (IBAction)aboutUS:(UIButton *)sender;

/**
 *  退出登陆
 */
- (IBAction)exitLogin:(UIButton *)sender;
@end


@implementation MCMySettingController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

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
    [self setNavigationBarTitle:@"设置"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  开启关闭接受消息
 */
- (IBAction)openOrCloseMessage:(UISwitch *)sender{

}
/**
 *  清除缓存
 */
- (IBAction)clearMemory:(UIButton *)sender{

}
/**
 *  意见反馈
 */
- (IBAction)idearReturn:(UIButton *)sender{
    pushToDestinationController(self, MCMyIdearReoprtController);
}
/**
 *  修改密码
 */
- (IBAction)changePass:(UIButton *)sender{

    MCRegisViewController *regis = [[MCRegisViewController alloc] init];
    regis.type = LoginEnterChange;
    [self.navigationController pushViewController:regis animated:YES];
    
}
/**
 *  关于我们
 */
- (IBAction)aboutUS:(UIButton *)sender{

    pushToDestinationController(self, MCMyAboutUSController);
}
/**
 *  退出登陆
 */
- (IBAction)exitLogin:(UIButton *)sender {

}
@end
