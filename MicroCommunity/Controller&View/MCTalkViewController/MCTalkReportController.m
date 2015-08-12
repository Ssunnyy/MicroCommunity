//
//  MCTalkReportController.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkReportController.h"

@interface MCTalkReportController ()<UITextViewDelegate>

{
    NSInteger selectReport;
}

@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (weak, nonatomic) IBOutlet UIButton *btnFour;
@property (weak, nonatomic) IBOutlet UIButton *btnFive;
@property (weak, nonatomic) IBOutlet UIButton *btnSix;


@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@end

@implementation MCTalkReportController

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
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"举报"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"提交" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

#pragma  mark  --  UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _placeholder.hidden = YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        _placeholder.hidden = YES;
    }else{
        _placeholder.hidden = NO;
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    
    sender.selected = YES;
    selectReport = sender.tag;
    
    switch (sender.tag) {
        case 100:
        {
            _btnTwo.selected = NO;
            _btnThree.selected = NO;
            _btnFour.selected = NO;
            _btnFive.selected = NO;
            _btnSix.selected = NO;
        }
            break;
        case 101:
        {
            _btnOne.selected = NO;
            _btnThree.selected = NO;
            _btnFour.selected = NO;
            _btnFive.selected = NO;
            _btnSix.selected = NO;
        }
            break;
        case 102:
        {
            _btnOne.selected = NO;
            _btnTwo.selected = NO;
            _btnFour.selected = NO;
            _btnFive.selected = NO;
            _btnSix.selected = NO;
        }
            break;
        case 103:
        {
            _btnOne.selected = NO;
            _btnTwo.selected = NO;
            _btnThree.selected = NO;
            _btnFive.selected = NO;
            _btnSix.selected = NO;
        }
            break;
        case 104:
        {
            _btnOne.selected = NO;
            _btnTwo.selected = NO;
            _btnThree.selected = NO;
            _btnFour.selected = NO;
            _btnSix.selected = NO;
        }
            break;
        case 105:
        {
            _btnOne.selected = NO;
            _btnTwo.selected = NO;
            _btnThree.selected = NO;
            _btnFour.selected = NO;
            _btnFive.selected = NO;
        }
            break;
            
            
        default:
            break;
    }

}


#pragma  mark  提交
- (void)rightBarButtonClick:(UIButton *)button {
    
    switch (selectReport) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
        case 103:
            
            break;
        case 104:
            
            break;
        case 105:
            
            break;
        case 106:
            
            break;
        default:
            break;
    }
    
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
