//
//  MCMyFriendSearchController.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyFriendSearchController.h"
#import "MCMyNewFriendCell.h"
#import "MCHomeSearchView.h"
#import "MCImPersonInfoController.h"

@interface MCMyFriendSearchController ()<UITableViewDataSource,UITableViewDelegate,MCHomeSearchViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic,strong) MCHomeSearchView *search;
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (nonatomic,strong) NSMutableArray *searchArray;
@end

@implementation MCMyFriendSearchController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    [self hideNavBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  初始化数据
 */
- (void) setUpData {

    _searchArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < 10; i ++) {
        [_searchArray addObject:@"1"];
    }
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _search = [[[NSBundle mainBundle]loadNibNamed:@"MCHomeSearchView" owner:self options:nil]lastObject];
    _search.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [_search backBtnChange];
    _search.delegate = self;
    [_headView addSubview:_search];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _searchArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyNewFriendCellIdentifier";
    MCMyNewFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyNewFriendCell" owner:self options:nil]lastObject];
    }
    [cell configCellWithType:3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
    person.titleName = @"晓红";
    [self.navigationController pushViewController:person  animated:YES];
    
}
#pragma  mark  --  MCHomeSearchViewDelegate
// 搜索完成
-(void) searchBarView:(MCHomeSearchView *)searchBarView inputCompleted:(NSString *)searchText {

    [self tableViewReloadData];
    
}

- (void)chooseCityBtnClick {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) tableViewReloadData {

    [_searchTableView reloadData];
    
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
