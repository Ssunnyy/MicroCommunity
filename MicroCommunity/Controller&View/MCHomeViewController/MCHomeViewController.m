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

@interface MCHomeViewController ()<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,MCHomeViewCellDelegate,MCHomeSearchViewDelegate>

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
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:YES];
    [_search resignTextView];
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
    
    for (int i = 0;  i < 3; i ++) {
        [_adArray addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    }
    
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
    
    [_circleScrollV setScrollViewContent:_adArray];
    
}


#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
    
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
    [cell setContentCell:nil andIndex:indexPath.row];
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

    
//    MCHomeModel *model = (MCHomeModel *)[_tableArray objectAtIndex:index - 200];
    
    switch (index) {
        case 200:
        {
            MCHomeSearchResultControllerViewController *result = [[MCHomeSearchResultControllerViewController alloc]initWithNibName:@"MCHomeSearchResultControllerViewController" bundle:nil];
            result.type = customeSearch;
            result.currentTitle = @"本地企业";
            [self.navigationController pushViewController:result animated:YES];
        }
            break;
        case 201:
        {
            MCRecruitController *recruit = [[MCRecruitController alloc]initWithNibName:@"MCRecruitController" bundle:nil];
            recruit.currentTitle = @"求职招聘";
            [self.navigationController pushViewController:recruit animated:YES];
        }
            break;
        default:
            break;
    }

    
}

#pragma  mark  --  MCHomeSearchViewDelegate
/**
 *  选择城市
 */
- (void)chooseCityBtnClick {
    
    
}
/**
 *  搜索
 */
- (void)searchBarView:(MCHomeSearchView *)searchBarView inputCompleted:(NSString *)searchText {

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
