//
//  MCMyIdearReoprtController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyIdearReoprtController.h"

@interface MCMyIdearReoprtController ()
@property (weak, nonatomic) IBOutlet UITextView *contenView;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@end

@implementation MCMyIdearReoprtController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"意见反馈"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

- (void) sendidear{

    if (_contenView.text.length <= 0) {
        [ITTPromptView showMessage:@"反馈内容不能为空"];
        return;
    }
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:_contenView.text ForKey:@"content"];
        [param safeString:_phone.text ForKey:@"phone"];
        
        [[MCMYManager shareManager]requestMy_view_feedbackWithParam:param withIndicatorView:self.view withCancelRequestID:MY_Request_view_feedback withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"意见反馈已提交"];
            }else{
                [ITTPromptView showMessage:@"意见反馈提交失败,请重试"];
            }
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"意见反馈提交失败,请重试"];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {
    
    [self sendidear];
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
