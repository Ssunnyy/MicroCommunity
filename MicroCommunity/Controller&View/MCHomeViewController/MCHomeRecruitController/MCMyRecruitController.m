//
//  MCMyRecruitController.m
//  MicroCommunity
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyRecruitController.h"
#import "ZHPickView.h"


@interface MCMyRecruitController ()<ZHPickViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *detailBg;
@property (weak, nonatomic) IBOutlet UITextField *titleLab;
@property (weak, nonatomic) IBOutlet UITextView *detailtextView;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (weak, nonatomic) IBOutlet UILabel *job_year;
@property (weak, nonatomic) IBOutlet UILabel *pric;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak, nonatomic) IBOutlet UITextField *otherTeChang;

@property (nonatomic, strong) ZHPickView *pickview;

@property (nonatomic, strong) NSMutableArray *imagePath;

@end

@implementation MCMyRecruitController
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    [self enableKeyboardManger];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [self disableKeyboardManager];
}

- (void)awakeFromNibs {

    [_detailBg makeCornerRadius:5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  初始化数据
 *
 *  @return
 */
- (void) setUpData {

    _imagePath = [[NSMutableArray alloc]init];
    
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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignfirst)];
    [self.view addGestureRecognizer:tap];
    
}

#pragma  mark  --  ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    
    switch (pickView.tag) {
        case 400:
        {
            _job_year.text = resultString;
        }
            break;
        case 401:
        {
            _pric.text = resultString;
        }
            break;
        case 402:
        {
            _college.text = resultString;
        }
            break;
        default:
            break;
    }
    
}

/**
 *  300 选择工作经验 301 选择薪资 302 选择学历
 *
 *  @param sender
 */
- (IBAction)jobYearChoose:(UIButton *)sender {
    
    if (_pickview) {
        [_pickview remove];
    }
    
    switch (sender.tag) {
        case 300:
        {
            NSArray *array=@[@"新手",@"1年",@"2年",@"3年",@"4年",@"5年",@"5年以上"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 400;
        }
            break;
        case 301:
        {
            NSArray *array=@[@"500元/月以下",@"500—1000元/月",@"1000—2000元/月",@"2000—3000元/月",@"3000—5000元/月",@"5000—8000元/月",@"8000—10000元/月",@"10000—15000元/月",@"",@"15000元/月以上"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 401;
        }
            break;
        case 302:
        {
            NSArray *array=@[@"选择学历",@"小学",@"初中",@"高中及大专",@"大专",@"本科",@"硕士及以上"];
            _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            _pickview.tag = 402;
        }
            break;
        default:
            break;
    }
    
    _pickview.delegate=self;
    [_pickview show];
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

    if ([self check]) {
        
        MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        if (user) {
            
            __weak MCMyRecruitController *weak = self;
            
            [param safeString:user.user_id ForKey:@"user_id"];
            [param safeString:_titleLab.text ForKey:@"title"];
            [param safeString:_detailtextView.text ForKey:@"content"];
            [param safeString:_pric.text ForKey:@"profession"];
            [param safeString:_job_year.text ForKey:@"job_year"];
            [param safeString:_college.text ForKey:@"user_education"];
            [param safeString:_otherTeChang.text ForKey:@"strong_demo"];
            [param safeString:user.user_id ForKey:@"education_image"];
            
            
            NSMutableArray *images = [NSMutableArray array];
            
            for (int i = 0 ; i < _imagePath.count ; i ++) {
                NSMutableDictionary *picDic = [NSMutableDictionary dictionary];
                [picDic safeString:[_imagePath objectAtIndex:i] ForKey:@"path"];
                [picDic safeString:[NSString stringWithFormat:@"image%d",i] ForKey:@"image"];
                [images addObject:picDic];
            }
            
            
            [[MCHomeManager shareManager]requestHome_request_job_addWithParam:param updateFiles:nil withIndicatorView:self.view withCancelRequestID:Home_request_job_add onRequestFinish:^(MKNetworkOperation *operation) {
                if (operation.isSuccees) {
                    [ITTPromptView  showMessage:@"投递成功"];
                    [weak.navigationController popViewControllerAnimated:YES];
                }else {
                    [ITTPromptView showMessage:@"投递失败"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                     [ITTPromptView showMessage:@"网络请求失败"];
            }];
        }
    }
    
}

- (BOOL) check{

    if ([_titleLab.text removeStringSpaceBlankEndAndStart].length <= 0) {
        [ITTPromptView showMessage:@"求职标题不能为空"];
        return NO;
    }
    
    if ([_detailtextView.text removeStringSpaceBlankEndAndStart].length <= 0) {
        [ITTPromptView showMessage:@"简历详情不能为空"];
        return NO;
    }
    if ([_job.text removeStringSpaceBlankEndAndStart].length <= 0) {
        [ITTPromptView showMessage:@"应聘职位不能为空"];
        return NO;
    }
    if ([_college.text isEqualToString:@"选择学历"]) {
        [ITTPromptView showMessage:@"应聘职位不能为空"];
        return NO;
    }
    return YES;
}


- (void) resignfirst{
    
    [self.view endEditing:NO];    
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
