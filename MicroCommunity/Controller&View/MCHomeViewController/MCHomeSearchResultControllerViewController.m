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
#import "MCProductDetilController.h"
#import "MCCompanyProductController.h"
#import "MCCompanyConfirmController.h"

@interface MCHomeSearchResultControllerViewController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate,MCSerachResultCellDelegate,MCCustomHeadViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (nonatomic, strong) MCHomeSearchView *search;
@property (nonatomic, strong) MCCustomHeadView *navView;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCHomeSearchResultControllerViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setUpData];
    
    [AppDelegate HideTabBar];
    
    [self hideNavBar];
    
    [self initSearchView];
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
    
    return 10;
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (_type) {
        case customeSearch:
        {
            MCProductDetilController *compony = [[MCProductDetilController alloc]initWithNibName:@"MCProductDetilController" bundle:nil];
            [self.navigationController pushViewController:compony animated:YES];
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
    
    NSLog(@"%@",searchText);
    
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
            MCCompanyConfirmController *confirm = [[MCCompanyConfirmController alloc]initWithNibName:@"MCCompanyConfirmController" bundle:nil];
            [self.navigationController pushViewController:confirm animated:YES];
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
