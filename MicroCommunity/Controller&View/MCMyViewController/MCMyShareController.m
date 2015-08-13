//
//  MCMyShareController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyShareController.h"

@interface MCMyShareController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicatorView;
}
@property (nonatomic, retain) UIWebView *webView;

@end

@implementation MCMyShareController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(30, SCREEN_HEIGHT - 120, SCREEN_WIDTH - 60, 45);
    [share setBackgroundImage:ImageNamed(@"btn_bg1.png") forState:UIControlStateNormal];
    [share setTitle:@"分享APP" forState:UIControlStateNormal];
    [share.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:share];
    
    // Do any additional setup after loading the view.
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
    [self setNavigationBarTitle:@"分享页面"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    
}

- (void)setUpWebView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_webView];
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareUrl]]];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview : activityIndicatorView] ;
    
}
#pragma  mark  --  网页delegate

#pragma mark---UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlStr = [request.URL absoluteString] ;
    NSMutableString *url = [NSMutableString stringWithString:urlStr];
    //  bc
    //
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
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
