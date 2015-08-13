//
//  MCMyErWeiMaController.m
//  MicroCommunity
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyErWeiMaController.h"

#import "MCCodeReaderController.h"
#import "QRCodeGenerator.h"
#import "MCMyRecordController.h"

@interface MCMyErWeiMaController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *cityID;
@property (weak, nonatomic) IBOutlet UIImageView *erweiMaImage;

@end

@implementation MCMyErWeiMaController

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
    [self setNavigationBarTitle:@"我的二维码"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

/**
 *  二维码扫描
 */

- (IBAction)saoMiao:(id)sender {

    pushToDestinationController(self, MCMyRecordController);

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
