//
//  MCMyRecruitController.m
//  MicroCommunity
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyRecruitController.h"

@interface MCMyRecruitController ()

@property (weak, nonatomic) IBOutlet UIView *detailBg;
@property (weak, nonatomic) IBOutlet UITextField *titleLab;
@property (weak, nonatomic) IBOutlet UITextView *detailtextView;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (weak, nonatomic) IBOutlet UILabel *job_year;
@property (weak, nonatomic) IBOutlet UILabel *pric;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak, nonatomic) IBOutlet UITextField *otherTeChang;
@end

@implementation MCMyRecruitController
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)awakeFromNibs {

    [_detailBg makeCornerRadius:5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
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
    [self setNavigationBarTitle:@"我的简历"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"投递简历" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 25, 100, 40);
    [rightBtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:rightBtn];
}
/**
 *  刷新简历
 */
- (IBAction)refersh:(id)sender {
    
}
/**
 *  投递简历
 */
- (void)rightBarButtonClick:(UIButton *)button {

    
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
