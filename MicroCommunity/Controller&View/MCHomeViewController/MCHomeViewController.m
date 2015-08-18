//
//  MCHomeViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeViewController.h"
#import "SearchBarView.h"
#import "EScrollerView.h"
#import "MCHomeViewCell.h"
#import "MCHomeModel.h"
#import "MCHomeSearchView.h"
#import "MCHomeSearchResultControllerViewController.h"
#import "MCRecruitController.h"

#import "MCHomeAdModel.h"
#import "MCHomeCityModel.h"

@interface MCHomeViewController ()<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,MCHomeViewCellDelegate,MCHomeSearchViewDelegate>
{
    NSArray *provinces;
}

@property (nonatomic, strong) MCHomeSearchView *search;
@property (nonatomic, strong) EScrollerView *circleScrollV;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) NSMutableArray *adArray;
@end

@implementation MCHomeViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [self hideNavBar];
    [AppDelegate DisplayTabBar];
    
    [self requestCircle];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:YES];
    [self requestMain];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:YES];
    [_search resignTextView];
}
#pragma  mark  --  请求轮播图
- (void) requestCircle{

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCHomeViewController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [[MCHomeManager shareManager]requestCircleWithParam:param withIndicatorView:self.view
                                        withCancelRequestID:Home_request_circle withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                                            
                                            if (operation.isSuccees) {
                                                NSArray *addArray = [operation.resultDic objectForKey:@"data"];
                                                NSMutableArray *imageArray = [NSMutableArray array];
                                                for (int i = 0; i < addArray.count; i ++) {
                                                    MCHomeAdModel *adModel = [[MCHomeAdModel alloc]initWithDataDic:[addArray objectAtIndex:i]];
                                                    adModel.key_drawing_image = [NSString stringWithFormat:@"%@%@",Main_URL,adModel.key_drawing_image];
                                                    [weak.adArray addObject:adModel];
                                                    [imageArray addObject:adModel.key_drawing_image];
                                                }
                                                
                                                [weak.circleScrollV setScrollViewContent:imageArray];
                                            }
                                        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                                            [ITTPromptView showMessage:@"广告请求失败"];
                                        }];
    }
}

#pragma  mark  --  请求首页数据

- (void) requestMain{
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        __weak MCHomeViewController *weak  = self;
        
        [[MCHomeManager shareManager]requestHomeMainWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_main withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [weak.tableArray removeAllObjects];
                NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
                for (int i = 0 ;i < dataArray.count; i ++) {
                    MCHomeModel *homeModel = [[MCHomeModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                    homeModel.category_image = [NSString stringWithFormat:@"%@%@",Main_URL,homeModel.category_image];
                    [weak.tableArray addObject:homeModel];
                }
                [weak.homeTableView reloadData];
            }
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self initSearchView];
    
    [self initAdView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

    _tableArray = [[NSMutableArray alloc]init];
    _adArray = [[NSMutableArray alloc]init];
}

/**
 *  设置搜索栏
 */
- (void) initSearchView {
    
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
    _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    _search.delegate = self;
    [_headView addSubview:_search];
}
/**
 *  设置广告位
 */
- (void) initAdView {
    
    float headViewHeight = SCREEN_HEIGHT / 4;
    
    _circleScrollV=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
    _homeTableView.tableHeaderView = _circleScrollV;
    _circleScrollV.delegate = self;
}


#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return ceilf(self.tableArray.count /3.0) ; ;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 110;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"MCHomeViewCellIdentifi";
    MCHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MCHomeViewCell" owner:self options:nil]lastObject];
    }
    cell.delegate = self;
    [cell setContentCell:self.tableArray andIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark  --  EScrollerViewDelegate

- (void)EScrollerViewDidClicked:(NSUInteger)index {

    
}

#pragma  mark  --  MCHomeViewCellDelegate
/**
 *  cell点击事件
 */
- (void)btnClickAtIndex:(NSInteger)index {

    
    MCHomeModel *model = (MCHomeModel *)[_tableArray objectAtIndex:index - 200];
    
    if ([model.category_name isEqualToString:@"本地企业"]) {
        
        MCHomeSearchResultControllerViewController *result = [[MCHomeSearchResultControllerViewController alloc]initWithNibName:@"MCHomeSearchResultControllerViewController" bundle:nil];
        result.type = customeSearch;
        result.currentTitle = @"本地企业";
        [self.navigationController pushViewController:result animated:YES];
        
    } else if ([model.category_name isEqualToString:@"求职招聘"]){
        
        MCRecruitController *recruit = [[MCRecruitController alloc]initWithNibName:@"MCRecruitController" bundle:nil];
        recruit.currentTitle = @"求职招聘";
        [self.navigationController pushViewController:recruit animated:YES];
        
    } else if ([model.category_name isEqualToString:@"特色美食"]){
        
    }else if([model.category_name isEqualToString:@"服装鞋帽"]) {
        
    }else if([model.category_name isEqualToString:@"休闲娱乐"]) {
        
    }else if([model.category_name isEqualToString:@"家具电器"]) {
        
    }else if([model.category_name isEqualToString:@"综合信息"]) {
        
    }else if([model.category_name isEqualToString:@"二手市场"]) {
        
    }else if([model.category_name isEqualToString:@"物流运输"]) {
        
    }else if([model.category_name isEqualToString:@"宾馆洗浴"]) {
        
    }else if([model.category_name isEqualToString:@"珠宝玉器"]) {
        
    }else if([model.category_name isEqualToString:@"医药医疗"]) {
        
    }else if([model.category_name isEqualToString:@"家政服务"]) {
        
    }else if([model.category_name isEqualToString:@"旅游景点"]) {
        
    }else if([model.category_name isEqualToString:@"房屋出租"]) {
        
    }
}

#pragma  mark  --  MCHomeSearchViewDelegate
/**
 *  选择城市
 */
- (void)chooseCityBtnClick {

    
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citys.plist" ofType:nil]];
    
    provinces = [[[data objectForKey:@"data"]objectAtIndex:0]objectForKey:@"_child"];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i < provinces.count; i ++) {
        
        MCHomeCityModel *cityModel = [[MCHomeCityModel alloc]initWithDataDic:[provinces objectAtIndex:i]];
        
        NSMutableArray *cityArray = [NSMutableArray array];
        for (int j = 0 ; j < cityModel._child.count; j ++) {
            MCHomeCityModel *city = [[MCHomeCityModel alloc]initWithDataDic:[cityModel._child objectAtIndex:j]];
            NSMutableArray *areaArray = [NSMutableArray array];
            
            for (int m = 0; m < city._child.count; m ++) {
                MCHomeCityModel *area = [[MCHomeCityModel alloc]initWithDataDic:[city._child objectAtIndex:m]];
                [areaArray addObject:area];
            }

            city._child = areaArray;
            
            [cityArray addObject:city];
        }
        
        cityModel._child = cityArray;
        
        [dataArray addObject:cityModel];
    }

}
/**
 *  搜索
 */
- (void)searchBarView:(MCHomeSearchView *)searchBarView inputCompleted:(NSString *)searchText {

    NSString *key = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (key.length <= 0) {
        [ITTPromptView showMessage:@"搜索关键字不能为空"];
        return;
    }
    
    MCHomeSearchResultControllerViewController *result = [[MCHomeSearchResultControllerViewController alloc]initWithNibName:@"MCHomeSearchResultControllerViewController" bundle:nil];
    result.type = otherSearch;
    result.keyWorld = searchText;
    [self.navigationController pushViewController:result animated:YES];
    
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
