//
//  MCMyGoldController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyGoldRuleController.h"
#import "MCMyGoleTableCell.h"
#import "MCGoldRuleHeadView.h"

@interface MCMyGoldRuleController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *goldTableView;
@property (nonatomic, strong) MCGoldRuleHeadView *headView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCMyGoldRuleController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self configHeadView];
    
    [self setNavigationBarStatus];
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
    
    _dataArray = [[NSMutableArray alloc]init];
    
    NSArray *titles = [NSArray arrayWithObjects:@"分享APP",@"发主帖",@"回帖",@"创建聊天室",@"主帖被删",@"回帖被删",@"聊天被封", nil];
    NSArray *counts = [NSArray arrayWithObjects:@"+10",@"+10",@"+1",@"+10",@"-10",@"-1",@"-10", nil];
    for (int i = 0 ; i < titles.count; i ++) {
        MCMyGoldModel *gold = [[MCMyGoldModel alloc]init];
        gold.title = [titles objectAtIndex:i];
        gold.gold = [counts objectAtIndex:i];
        [_dataArray addObject:gold];
    }
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"积分规则"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}
/**
 *  设置headView
 */

- (void) configHeadView{

    _goldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCGoldRuleHeadView" owner:self options:nil]lastObject];
    _goldTableView.tableHeaderView = _headView;
    _goldTableView.frameheight = 70;
    _goldTableView.framewidth = SCREEN_WIDTH;
    
}
#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyGoleTableCellIdentifier";
    MCMyGoleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyGoleTableCell" owner:self options:nil]lastObject];
    }
    MCMyGoldModel *model = (MCMyGoldModel *) [_dataArray objectAtIndex:indexPath.row];
    [cell configCellWithMCMyGoldModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
