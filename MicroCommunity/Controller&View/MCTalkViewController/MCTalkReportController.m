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

@property (weak, nonatomic) IBOutlet UITextView *reportText;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;


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

- (void) reportRequestWithCategory:(NSString *) message {
    
    __weak MCTalkReportController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:user.nickname ForKey:@"report_nickname"];
        [param safeString:self.reportModel.talk_id ForKey:@"talk_id"];
        [param safeString:self.reportModel.talk_nickname ForKey:@"breport_nickname"];
        [param safeString:self.reportModel.talk_id ForKey:@"talk_uid"];
        [param safeString:message ForKey:@"category_name"];
        [param safeString:_reportText.text ForKey:@"report_message"];
        
        
        [[MCTalkManager shareManager]requestTalk_ReportWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_report_talk withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"举报成功"];
                [weak.navigationController popViewControllerAnimated:YES];
            }else {
                [ITTPromptView showMessage:@"举报提交失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"举报失败"];
        }];
    }
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
    
    NSString *reportString = @"";
    
    switch (selectReport) {
        case 100:
            reportString = _lab1.text;
            break;
        case 101:
            reportString = _lab2.text;
            break;
        case 102:
            reportString = _lab3.text;
            break;
        case 103:
            reportString = _lab4.text;
            break;
        case 104:
            reportString = _lab5.text;
            break;
        case 105:
            reportString = _lab6.text;
            break;
        default:
            break;
    }
    
    if (reportString.length <= 0) {
        [ITTPromptView showMessage:@"请选择举报项目"];
        return;
    }
    
    [self reportRequestWithCategory:reportString];
    
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
