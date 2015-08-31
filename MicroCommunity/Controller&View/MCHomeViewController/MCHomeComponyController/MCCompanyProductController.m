//
//  MCHomeSearchResultControllerViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeSearchResultControllerViewController.h"
#import "MCHomeSearchView.h"
#import "MCCustomHeadView.h"
#import "MCCompanyDetailController.h"
#import "MCCompanyProductController.h"
#import "MCCompanyServerCell.h"
#import "MCProductSearchHeadView.h"
#import "MCCompanProductBottomView.h"

#import "MCShopPublicController.h"
#import "MCCompanyConfirmController.h"

#define HistoryList @"HistoryList"

@interface MCCompanyProductController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate,MCCustomHeadViewDelegate,MCCompanProductBottomViewDelegate,UITextFieldDelegate>

{
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIView *bottom;

@property (nonatomic, strong) MCHomeSearchView *search;
@property (nonatomic, strong) MCCustomHeadView *navView;
@property (nonatomic, strong) MCProductSearchHeadView *tableHeadView;
@property (nonatomic, strong) MCCompanProductBottomView *bottomView;
@property (nonatomic, strong) UIWebView *callWebView;


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *listArray;//  缓存搜索历史
@property (nonatomic, strong) NSMutableArray *historyBtnArray;

@end

@implementation MCCompanyProductController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    [self requestGoodList];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [[MCHomeManager shareManager]cancelAllRequest];
    
}


- (void) requestGoodList {

    __weak MCCompanyProductController *weak = self;
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.currentModel.seller_id ForKey:@"seller_id"];
        [param safeString:[NSString stringWithFormat:@"%ld",pageIndex] ForKey:@"pageindex"];
        
        [[MCHomeManager shareManager]requestHome_goods_listWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_list withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [_dataArray removeAllObjects];
                NSArray *data = [operation.resultDic objectForKey:@"data"];
                
                if (data.count > 0) {
                    for (int i = 0; i < data.count; i ++) {
                        MCMyCollectProductModel *collect = [[MCMyCollectProductModel alloc]initWithDataDic:[data objectAtIndex:i]];
                        collect.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,collect.goods_image];
                        [weak.dataArray addObject:collect];
                    }
                }else {
                    [ITTPromptView showMessage:@"暂无数据"];
                }
            }else {
                [ITTPromptView showMessage:@"请求失败"];
            }
            
            [weak tableViewReloadData];
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
             [weak tableViewReloadData];
        }];
    }
    
}


- (void) requestForProductList:(NSString *)key {

    self.keyWorld = key;
    
    __weak MCCompanyProductController *weak = self;
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:key ForKey:@"content"];
        [param safeString:self.currentModel.seller_id ForKey:@"seller_id"];
        
        [[MCHomeManager shareManager]requestHome_goods_searchWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_search withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [_dataArray removeAllObjects];
                NSArray *data = [operation.resultDic objectForKey:@"data"];
                
                if (data.count > 0) {
                    for (int i = 0; i < data.count; i ++) {
                        MCMyCollectProductModel *collect = [[MCMyCollectProductModel alloc]initWithDataDic:[data objectAtIndex:i]];
                        collect.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,collect.goods_image];
                        [_dataArray addObject:collect];
                    }
                }else {
                    [ITTPromptView showMessage:@"暂无数据"];
                }
                [weak.tableHeadView setProductName:weak.keyWorld andProductNmu:[NSString stringWithFormat:@"%ld",data.count]];
            }else {
                [ITTPromptView showMessage:@"请求失败"];
            }
            
            [weak tableViewReloadData];
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setUpData];
    
    [AppDelegate HideTabBar];
    
    [self hideNavBar];
    
    [self configBottomView];
    
    [self initSearchView];
    
    [self initCallWebView];
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

    pageIndex = 1;
    
    self.dataArray = [NSMutableArray array];
    self.listArray = [NSMutableArray array];
    self.historyBtnArray = [NSMutableArray array];
    //  获取历史记录
    [self getHistoryList];
}



/**
 *  设置搜索栏
 */
- (void) initSearchView {
    
    _tableHeadView = [[[NSBundle mainBundle] loadNibNamed:@"MCProductSearchHeadView" owner:self options:nil]lastObject];
    _tableHeadView.hidden = YES;
    _tableHeadView.frameheight = 0;
    _resultTableView.tableHeaderView = _tableHeadView;
    
    _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setNavigationBarStatus];
    
    _historyView.hidden = YES;

}

/**
 *  设置底部试图
 */

- (void) configBottomView {

    _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"MCCompanProductBottomView" owner:self options:nil]lastObject];
    _bottomView.frameheight = 64;
    _bottomView.delegate = self;
    [_bottomView configUserInfoWithUerName:self.currentModel.seller_name andConnect:self.currentModel.linkphone];
    [_bottom addSubview:_bottomView];
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
    
    _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
    _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [_search setSearchText:self.keyWorld];
    [_search leftViewHiden];
    [_search changeRightBtnTitle:@"返回"];
    _search.searchTextField.delegate = self;
    _search.delegate = self;
    
    [_headView addSubview:_search];
    
    _navView = [[[NSBundle mainBundle] loadNibNamed:@"MCCustomHeadView" owner:self options:nil]lastObject];
    [_navView setTitleWithString:self.currentTitle];
    _navView.delegate = self;
    [_headView addSubview:_navView];
    
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCCompanyServerCellIdentifier";
    MCCompanyServerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyServerCell" owner:self options:nil]lastObject];
    }
    MCMyCollectProductModel *collect = [_dataArray objectAtIndex:indexPath.row];
    [cell configCellWithMCMyCollectProductModel:collect];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    if (searchText.length <= 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //  只存储前10个历史记录
        if (_listArray.count > 10) {
            [_listArray removeLastObject];
            [_listArray insertObject:searchText atIndex:0];
        }else {
            [_listArray insertObject:searchText atIndex:0];
        }
        
        [DATA_CATHE addObject:_listArray forKey:HistoryList];
        [DATA_CATHE doSave];
        [self serachViewHiden:NO];
        [self requestForProductList:searchText];
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
            //  100 返回
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 101:
        {
            //  发布
            
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
            //  搜索
            [self serachViewHiden:YES];
        }
            break;
        default:
            break;
    }
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
            MCCompanyDetailController *detail = [[MCCompanyDetailController alloc]initWithNibName:@"MCCompanyDetailController" bundle:nil];
            detail.sellerId = self.currentModel.seller_id;
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        case 202:
        {
            
            NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.currentModel.linkphone]];
            [_callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            
        }
            break;
        case 203:
            
            break;
        default:
            break;
    }
    
    
}
#pragma  mark  --  UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (range.location > 0 || (string.length > 0 && range.location == 0)) {
        [_search changeRightBtnTitle:@"搜索"];
    }else {
        [_search changeRightBtnTitle:@"返回"];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
/**
 *  显示隐藏搜索控件
 */
- (void) serachViewHiden:(BOOL) hiden {
    //  tableViewHeadView
    _tableHeadView.hidden = NO;
    _tableHeadView.frameheight = 64;
    _resultTableView.tableHeaderView = _tableHeadView;
    
    _navView.hidden = hiden;
    if (hiden) {
        _historyView.frametop = 64;
    }else {
        _historyView.frametop = SCREEN_WIDTH;
        [self clearHistoryList];
        [self getHistoryList];
    }
    
    [self.historyView setNeedsUpdateConstraints];
    [self.historyView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        _historyView.hidden = !hiden;
        [self.historyView layoutIfNeeded];
    }];
}
/**
 *  刷新数据
 */
- (void) tableViewReloadData {

    [_resultTableView reloadData];
}

/**
 *  清除历史记录事件
 */
- (IBAction)clearCache:(UIButton *)sender {

    [_listArray removeAllObjects];

    [self clearHistoryList];
    
    [DATA_CATHE removeObjectInCacheByKey:HistoryList];
}
/**
 *  清除历史记录 方法
 */
- (void) clearHistoryList {

    for (int i = 0;  i < _historyBtnArray.count; i ++) {
        UIButton *btn = (UIButton *)[_historyBtnArray objectAtIndex:i];
        [btn removeFromSuperview];
    }
    [_historyBtnArray removeAllObjects];
}
/**
 *  获取历史记录 方法
 */

- (void) getHistoryList {

//    [_listArray removeAllObjects];
    if ([DATA_CATHE hasObjectInCacheByKey:HistoryList]) {
        self.listArray = [DATA_CATHE getCachedObjectByKey:HistoryList];
        if (_listArray.count > 0) {
            for (int i = 0;  i < _listArray.count ; i ++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
                button.backgroundColor = [UIColor clearColor];
                [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [button setTitle:[_listArray objectAtIndex:i] forState:UIControlStateNormal];
                [button setTitleColor:RGBACOLOR(58, 58, 58, 1) forState:UIControlStateNormal];
                [button addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(SCREEN_WIDTH / 5,30 + ( 30 + 2) * i, SCREEN_WIDTH / 4 * 2, 30);
                [_historyBtnArray addObject:button];
                [_historyView addSubview:button];
            }
        }
    }
}

- (void) historyBtnClick:(UIButton *) btn {

    [self requestForProductList:[btn currentTitle]];
    [self serachViewHiden:NO];
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
