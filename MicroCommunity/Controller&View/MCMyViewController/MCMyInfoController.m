//
//  MCMyInfoController.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyInfoController.h"

@interface MCMyInfoController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *headBgImage;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *cityID;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *hunLab;
@property (weak, nonatomic) IBOutlet UITextField *zhiyeTextField;
@property (weak, nonatomic) IBOutlet UILabel *birthLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *xingZuoLab;
@property (weak, nonatomic) IBOutlet UILabel *xueLiLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *guanJiLab;
@property (weak, nonatomic) IBOutlet UITextField *likeLab;
@property (weak, nonatomic) IBOutlet UITextField *likeBook;
@property (weak, nonatomic) IBOutlet UITextField *likeMove;

/**
 * 性别
 */
- (IBAction)sexBtnClick:(id)sender;
/**
 *  婚姻
 */
- (IBAction)hunBtnClick:(id)sender;
/**
 *  生日
 */
- (IBAction)birthClick:(id)sender;
/**
 *  学历
 */
- (IBAction)xueLiClick:(id)sender;
/**
 *  所在地
 */
- (IBAction)addressClick:(id)sender;
/**
 *  贯籍
 */
- (IBAction)guanJiClick:(id)sender;
/**
 *  兴趣爱好
 */
- (IBAction)likeClick:(id)sender;

@end

@implementation MCMyInfoController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)awakeFromNibs {

    [_headImage makeCircleView];
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
    [self setNavigationBarTitle:@"个人信息"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"保存" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
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
 * 性别
 */
- (IBAction)sexBtnClick:(id)sender {

}
/**
 *  婚姻
 */
- (IBAction)hunBtnClick:(id)sender{

}
/**
 *  生日
 */
- (IBAction)birthClick:(id)sender{

}
/**
 *  学历
 */
- (IBAction)xueLiClick:(id)sender{

}
/**
 *  所在地
 */
- (IBAction)addressClick:(id)sender{

}
/**
 *  贯籍
 */
- (IBAction)guanJiClick:(id)sender{

}
/**
 *  兴趣爱好
 */
- (IBAction)likeClick:(id)sender{

}

@end
