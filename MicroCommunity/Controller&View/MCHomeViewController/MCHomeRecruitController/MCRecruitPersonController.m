//
//  MCRecruitPersonController.m
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitPersonController.h"
#import "MCRecruitDetailCell.h"
#import "MCCompanProductBottomView.h"


@interface MCRecruitPersonController ()<UITableViewDataSource,UITableViewDelegate,MCCompanProductBottomViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *personTableView;
@property (nonatomic, strong) MCCompanProductBottomView *bottomProView;

@property (nonatomic, strong) MCRecruitDetailCell *recruitDetaitCell;

@property (nonatomic, strong) UIWebView *callWebView;

@property (nonatomic, strong) MCRecruitModel *recruitModel;

@end

@implementation MCRecruitPersonController

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    [self requestForJobDetail];
}
/**
 *  请求详情
 */
- (void) requestForJobDetail {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    __weak MCRecruitPersonController *weak = self;
    
    if (user) {
        
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.recruitHomeModel.job_id ForKey:@"job_id"];
        
        [[MCHomeManager shareManager]requestHome_job_detailsWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_job_details withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                
                weak.recruitModel = [[MCRecruitModel alloc]initWithDataDic:[[operation.resultDic objectForKey:@"data"] objectAtIndex:0]];
                weak.recruitModel.image = [NSString stringWithFormat:@"%@%@",Main_URL,weak.recruitModel.image];

            }else {
                [ITTPromptView showMessage:@"请求失败"];
            }
            [weak.personTableView reloadData];
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    
    [self setUpData];
    
    [self configBottomView];
    
    [self initCallWebView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"详情"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andImage:ImageNamed(@"top_btn_heart.png") highImage:ImageNamed(@"top_btn_heart.png")];
}

/**
 *  设置bottomView
 */
- (void) configBottomView {
    
    
    //  注册商品介绍cell
    UINib *cellNib1 = [UINib nibWithNibName:@"MCRecruitDetailCell" bundle:nil];
    [_personTableView registerNib:cellNib1 forCellReuseIdentifier:@"MCRecruitDetailCellIdentifier"];
    self.recruitDetaitCell  = [_personTableView dequeueReusableCellWithIdentifier:@"MCRecruitDetailCellIdentifier"];
    
    _personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomProView = [[[NSBundle mainBundle] loadNibNamed:@"MCCompanProductBottomView" owner:self options:nil]lastObject];
    [_bottomProView hidenCompanyBtn];
    _bottomProView.frameheight = 64;
    _bottomProView.delegate = self;
    [_bottomView addSubview:_bottomProView];
    
}

/**
 *  初始化网页调用拨打电话
 */
- (void) initCallWebView {
    
    _callWebView= [[UIWebView alloc] init];
    [self.view addSubview:_callWebView];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [self calculateCellHeight:indexPath];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCRecruitDetailCellIdentifier";
    MCRecruitDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCRecruitDetailCell" owner:self options:nil]lastObject];
    }
    if (self.recruitModel) {
        [cell configCellWithMCCompanyCommentModel:self.recruitModel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma  mark  --  MCCompanProductBottomViewDelegate
/**
 *  200 联系人 201 企业详情 202 通话 203 咨询
 */

- (void)bottomBtnClickAtIndex:(NSInteger)index {
    
    switch (index) {
        case 200:
            
            break;
        case 201:
        {
            
        }
            break;
        case 202:
        {
            
            NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:10086"]];
            
            [_callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            
        }
            break;
        case 203:
            
            break;
        default:
            break;
    }
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    
    if (self.recruitModel) {
        MCRecruitDetailCell *cell = (MCRecruitDetailCell *)self.recruitDetaitCell;
        
        CGSize likeheight = [self.recruitModel.strong_demo calculateSize:CGSizeMake(cell.like.frame.size.width, FLT_MAX) font:cell.like.font];
        
        float height = cell.view2Height.constant;;
        
        if (likeheight.height > 17) {
            height = cell.view2Height.constant - 17 + likeheight.height;
        }
        
        CGSize intrHeight = [self.recruitModel.job_content calculateSize:CGSizeMake(cell.detailLab.frame.size.width, FLT_MAX) font:cell.detailLab.font];
        
        if (intrHeight.height > 67) {
            height +=( cell.view2Height.constant - 67 + intrHeight.height);
        }
        
        float heights = cell.headViewHeight.constant + cell.view1Height.constant + height + cell.view3Height.constant + 20;
        return heights;
    } else {
        return 579;
    }
}

- (void)rightBarButtonClick:(UIButton *)button {

    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.recruitHomeModel.job_id ForKey:@"job_id"];
    
        [[MCHomeManager shareManager] requestHome_job_collectWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_job_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                NSString *code = [NSString stringWithFormat:@"%@",[operation.responseJSON objectForKey:@"code_array"]];
                
                if ([code isEqualToString:@"0"]) {
                    [ITTPromptView showMessage:@"取消收藏成功"];
                }else {
                    [ITTPromptView showMessage:@"收藏成功"];
                }
            }else {
                [ITTPromptView showMessage:@"操作失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
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
