//
//  MCHomeSearchResultControllerViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeSearchResultControllerViewController.h"
#import "MCHomeSearchView.h"
#import "MCSerachResultCell.h"
#import "MCCustomHeadView.h"
#import "MCCompanyProductController.h"
#import "MCCompanyConfirmController.h"
#import "MCHomeSearchModel.h"
#import "MCProductDetilController.h"
#import "MCShopPublicController.h"

@interface MCHomeSearchResultControllerViewController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate,MCSerachResultCellDelegate,MCCustomHeadViewDelegate>

{
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (nonatomic, strong) MCHomeSearchView *search;
@property (nonatomic, strong) MCCustomHeadView *navView;
@property (nonatomic, strong) UIWebView *callWebView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCHomeSearchResultControllerViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
//    if (self.type == otherSearch) {
   
//    }
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    [[MCHomeManager shareManager]cancelAllRequest];
}
#pragma  mark  --  搜索网络请求
- (void) searchRequest {
    
   __weak  MCHomeSearchResultControllerViewController *weak = self;
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        
        
        NSString *lon = [USER_DEFAULT objectForKey:MMLastLongitude];
        NSString *lat = [USER_DEFAULT objectForKey:MMLastLatitude];
        
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:lon ForKey:@"long"];
        [param safeString:lat ForKey:@"lat"];
        [param safeString:@"1" ForKey:@"pageindex"];
        
        switch (_type) {
            case customeSearch:
            {
                [param safeString:self.category_id ForKey:@"category_id"];
                
                [[MCHomeManager shareManager]requestHome_company_homeWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_company_home withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                    
                    if (operation.isSuccees) {
                        [weak.dataArray removeAllObjects];
                        NSArray *data = [operation.resultDic objectForKey:@"data"];
                        for (int i = 0; i < data.count; i ++) {
                            MCHomeSearchModel *model = [[MCHomeSearchModel alloc]initWithDataDic:[data objectAtIndex:i]];
                            model.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,model.goods_image];
                            [weak.dataArray addObject:model];
                        }
                    } else {
                        [ITTPromptView showMessage:@"查询失败"];
                    }
                    [weak.resultTableView reloadData];
                    
                } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                     [ITTPromptView showMessage:@"查询失败"];
                }];
            }
                break;
            case otherSearch:
            {
                [param safeString:self.keyWorld ForKey:@"key"];
                
                [[MCHomeManager shareManager]requestHomeMainSearchWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_lifeSearch withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                    
                    if (operation.isSuccees) {
                        [weak.dataArray removeAllObjects];
                        NSArray *data = [operation.resultDic objectForKey:@"data"];
                        for (int i = 0; i < data.count; i ++) {
                            MCHomeSearchModel *model = [[MCHomeSearchModel alloc]initWithDataDic:[data objectAtIndex:i]];
                            model.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,model.goods_image];
                            [weak.dataArray addObject:model];
                        }
                    } else {
                        [ITTPromptView showMessage:@"搜索失败"];
                    }
                    [weak.resultTableView reloadData];
                } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                    [ITTPromptView showMessage:@"搜索失败"];
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setUpData];
    
    [AppDelegate HideTabBar];
    
    [self hideNavBar];
    
    [self initSearchView];
    
    [self initCallWebView];
    
    [self searchRequest];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化数据
 */
- (void) setUpData {

    _dataArray = [NSMutableArray array];
    
}

/**
 *  设置搜索栏
 */
- (void) initSearchView {
    
    
    _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    switch (_type) {
        case customeSearch:
        {
            [self setNavigationBarStatus];
        }
            break;
        case otherSearch:
        {
            _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
            _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
            [_search setSearchVWithBtnPlace:self.keyWorld];
            [_search backBtnChange];
            _search.delegate = self;
            [_headView addSubview:_search];
        }
            break;
        default:
            break;
    }
}

- (void) initCallWebView {
    
    _callWebView= [[UIWebView alloc] init];
    [self.view addSubview:_callWebView];
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _navView = [[[NSBundle mainBundle] loadNibNamed:@"MCCustomHeadView" owner:self options:nil]lastObject];
    
    [_navView setTitleWithString:self.currentTitle];
    _navView.delegate = self;
    [_headView addSubview:_navView];
    
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 77;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCSerachResultCellIdentifier";
    MCSerachResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCSerachResultCell" owner:self options:nil]lastObject];
    }
    MCHomeSearchModel *modle = [_dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWithMCHomeSearchModel:modle withType:0];
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}
#pragma  mark  --  MCHomeSearchViewDelegate
/**
 *  返回
 */
- (void)chooseCityBtnClick {

    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  搜索
 */
- (void)searchBarView:(MCHomeSearchView *)searchBarView inputCompleted:(NSString *)searchText {
    
    
    if (![self.keyWorld isEqualToString:searchText]) {
        [_dataArray removeAllObjects];
    }
    self.keyWorld = searchText;
    [self searchRequest];
}

#pragma  mark  --  MCSerachResultCellDelegate

/**
 *  cell点击事件
 *  100商品详情
 *  101公司产品列表
 *  102联系
 */

- (void)inType:(NSInteger)type AtIndex:(NSInteger)index {

    switch (type) {
        case 100:
        {
        //  100商品详情
            switch (_type) {
                case customeSearch:
                {
                    MCProductDetilController *compony = [[MCProductDetilController alloc]initWithNibName:@"MCProductDetilController" bundle:nil];
                    compony.searchModel = [_dataArray objectAtIndex:index];
                    compony.type = productType;
                    [self.navigationController pushViewController:compony animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        
        }
            break;
        case 101:
        {
        //  101公司产品列表
            switch (_type) {
                case customeSearch:
                {
                    MCCompanyProductController *compony = [[MCCompanyProductController alloc]initWithNibName:@"MCCompanyProductController" bundle:nil];
                    compony.type = customeSearchc;
                    compony.currentModel = [_dataArray objectAtIndex:index];
                    compony.currentTitle = @"产品列表";
                    [self.navigationController pushViewController:compony animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 102:
        {
        //  102联系
            {
                MCHomeSearchModel *model = [_dataArray objectAtIndex:index];
                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.linkphone]];
                [_callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                
                
//                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18920107237"];
//                //            NSLog(@"str======%@",str);
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma  mark  --  MCCustomHeadViewDelegate

/*
 100 返回 101 发布 102搜索
 */

- (void)customNavViewClickWithIndex:(NSInteger)index {

    switch (index) {
        case 100:
        {
            //  100返回
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 101:
        {
            //  101发布
            
            if ([[[MCUserManager shareManager]getCurrentUser].user_type isEqualToString:@"0"]) {
                MCCompanyConfirmController *confirm = [[MCCompanyConfirmController alloc]initWithNibName:@"MCCompanyConfirmController" bundle:nil];
                confirm.isConfirm = YES;
                [self.navigationController pushViewController:confirm animated:YES];
            } else if([[[MCUserManager shareManager]getCurrentUser].user_type isEqualToString:@"1"]){
                [ITTPromptView showMessage:@"正在审核中"];
            }else if ([[[MCUserManager shareManager]getCurrentUser].user_type isEqualToString:@"2"]){
                
                MCShopPublicController *shop = [[MCShopPublicController alloc]initWithNibName:@"MCShopPublicController" bundle:nil];
                shop.seller_id = [[MCUserManager shareManager]getCurrentUser].seller_id;
                [self.navigationController pushViewController:shop animated:YES];
            }
        }
            break;
        case 102:
        {
            //  102搜索
            
        }
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
