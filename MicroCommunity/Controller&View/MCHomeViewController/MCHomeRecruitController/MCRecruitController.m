//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeSearchView.h"
#import "MCCustomHeadView.h"
#import "MCRecruitController.h"
#import "MCCompanyServerCell.h"
#import "MCProductSearchHeadView.h"

#import "MCRecruitCell.h"
#import "MCRecruitMainCell1.h"
#import "MCRecruitMainCell.h"

#import "MCProductDetilController.h"
#import "MCRecruitPersonController.h"
#import "MCRecruitPublicController.h"

#import "MCMyRecruitController.h"

#define RecruitHistoryList @"RecruitHistoryList"


@interface MCRecruitController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate,MCCustomHeadViewDelegate,UITextFieldDelegate,MCRecruitCellDelegate>
{
    NSInteger switchType;//    1招聘 2求职
    NSInteger pageIndex;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (weak, nonatomic) IBOutlet UIView *historyView;

@property (nonatomic, strong) MCHomeSearchView *search;
@property (nonatomic, strong) MCCustomHeadView *navView;
@property (nonatomic, strong) MCProductSearchHeadView *tableHeadView;

@property (nonatomic, strong) MCRecruitCell *tableHeader;

@property (nonatomic, strong) NSMutableArray *dataArray;//  招聘数组
@property (nonatomic, strong) NSMutableArray *dataArray1;//  求职数组


@property (nonatomic, strong) NSMutableArray *listArray;//  缓存搜索历史
@property (nonatomic, strong) NSMutableArray *historyBtnArray;

@end

@implementation MCRecruitController

- (void)viewWillAppear:(BOOL)animated {

    [AppDelegate HideTabBar];
    [super viewWillAppear:YES];
    
    [self requestForRecruit];
    
}

- (void) requestForRecruit{

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:[NSString stringWithFormat:@"%ld",pageIndex] ForKey:@"pageindex"];
        [param safeString:self.category_id ForKey:@"category_id"];
    
        [[MCHomeManager shareManager] requestHome_zhaopin_indexWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_zhaopin_index withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                
            }else {
            
                
            }
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            
        }];

        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setUpData];
    
    [self hideNavBar];
    
    [self initSearchView];
    
    [self configTableHeadView];
    
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

    switchType = 1;
    pageIndex = 1;
    self.dataArray = [NSMutableArray array];
    self.dataArray1 = [NSMutableArray array];
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
 *  设置tableViewHeader
 */

- (void) configTableHeadView {

    _tableHeader = [[[NSBundle mainBundle]loadNibNamed:@"MCRecruitCell" owner:self options:nil]lastObject];
    _tableHeader.delegate = self;
    _resultTableView.tableHeaderView = _tableHeader;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
    _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [_search setSearchVWithBtnPlace:self.keyWorld];
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
    
    NSInteger count ;
    switch (switchType) {
        case 1:
        {
            count = 4;
        }
            break;
        case 2:
        {
            count = 3;
        }
            break;
        default:
            break;
    }
    
    return count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (switchType) {
        case 1:
        {
            static NSString *cellID = @"MCRecruitMainCellIdentirier";
            MCRecruitMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCRecruitMainCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        }
            break;
        case 2:
        {
            static NSString *cellID = @"MCRecruitMainCell1Identifier";
            MCRecruitMainCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCRecruitMainCell1" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (switchType) {
        case 1:
        {
            MCProductDetilController *detail = [[MCProductDetilController alloc]initWithNibName:@"MCProductDetilController" bundle:nil];
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        case 2:
        {
            MCRecruitPersonController *person = [[MCRecruitPersonController alloc] initWithNibName:@"MCRecruitPersonController" bundle:nil];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        default:
            break;
    }
    
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
        
        [DATA_CATHE addObject:_listArray forKey:RecruitHistoryList];
        [DATA_CATHE doSave];
        [self serachViewHiden:NO];
    }
    
    NSLog(@"%@",searchText);
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
            switch (switchType) {
                case 1:
                {
                    MCRecruitPublicController *pub = [[MCRecruitPublicController alloc]initWithNibName:@"MCRecruitPublicController" bundle:nil];
                    [self.navigationController pushViewController:pub animated:YES];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                    
                default:
                    break;
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

#pragma  mark  --  UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (range.location > 0 || (string.length > 0 && range.location == 0)) {
        [_search changeRightBtnTitle:@"搜索"];
    }else {
        [_search changeRightBtnTitle:@"返回"];
    }
    return YES;
}

#pragma  mark  --  MCRecruitCellDelegate
/**
 *  headerDelegate
 */
- (void)selectAtIndex:(NSInteger)index {
    
    switch (index) {
        case 300:
        {
            switchType = 1;
            [self tableViewReloadData];
        }
            break;
        case 301:
        {
            switchType = 2;
            pushToDestinationController(self, MCMyRecruitController);
        }
            
            break;
        default:
            break;
    }
}

- (void) tableviewReloadData {

    [_resultTableView reloadData];

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
    
    [self tableViewReloadData];
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
    
    [DATA_CATHE removeObjectInCacheByKey:RecruitHistoryList];
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
    if ([DATA_CATHE hasObjectInCacheByKey:RecruitHistoryList]) {
        self.listArray = [DATA_CATHE getCachedObjectByKey:RecruitHistoryList];
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

    [_search setSearchText:[btn currentTitle]];
    
    [ITTPromptView showMessage:[btn currentTitle]];
    
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
