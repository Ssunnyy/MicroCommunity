//
//  MCMyGoldController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyGoldController.h"
#import "MCMyGoleTableCell.h"
#import "MCMyGoldHeadView.h"
#import "MCMyGoldRuleController.h"
#import "MCSendGoldController.h"

@interface MCMyGoldController ()<UITableViewDataSource,UITableViewDelegate,MCMyGoldHeadViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *goldTableView;
@property (nonatomic, strong) MCMyGoldHeadView *headView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCMyGoldController

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
    
    MCMyGoldModel *gold = [[MCMyGoldModel alloc]init];
    gold.title = @"分享APP";
    gold.gold = @"+100";
    gold.detailDate = @"16:45:45";
    for (int i = 0 ; i < 5; i ++) {
        [_dataArray addObject:gold];
    }
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"我的金豆"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"规则" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}
/**
 *  设置headView
 */

- (void) configHeadView{

    _goldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCMyGoldHeadView" owner:self options:nil]lastObject];
    _headView.delegate = self;
    _goldTableView.tableHeaderView = _headView;
    _goldTableView.frameheight = 130;
    _goldTableView.framewidth = SCREEN_WIDTH;
    
}
#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"今日收入";
    
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
}


#pragma  mark  --  MCMyGoldHeadViewDelegate
/**
 *  给其他人赠送金豆
 */

- (void)sendGoldToOther {
    
    MCSendGoldController *send = [[MCSendGoldController alloc]initWithNibName:@"MCSendGoldController" bundle:nil];
    [self.navigationController pushViewController:send animated:YES];

}
/**
 *  金蛋规则
 */
- (void)rightBarButtonClick:(UIButton *)button {

    pushToDestinationController(self, MCMyGoldRuleController);
    
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
