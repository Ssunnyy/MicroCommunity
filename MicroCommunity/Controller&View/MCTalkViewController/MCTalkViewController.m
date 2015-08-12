//
//  MCHomeSearchResultControllerViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkViewController.h"
#import "MCHomeSearchView.h"
#import "MCTalkMainCell.h"
#import "MCTalkListViewController.h"


@interface MCTalkViewController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (nonatomic, strong) MCHomeSearchView *search;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCTalkViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    [AppDelegate DisplayTabBar];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewDidDisappear:YES];
    [_search resignTextView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setUpData];
    
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
    
    _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
    _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [_search leftViewHiden];
    _search.delegate = self;
    [_headView addSubview:_search];
}


#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 77;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCTalkMainCellIdentifier";
    MCTalkMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCTalkMainCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);

    MCTalkListViewController *talk = [[MCTalkListViewController alloc]initWithNibName:@"MCTalkListViewController" bundle:nil];
    talk.titleStr = @"初恋";
    [self.navigationController pushViewController:talk animated:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
