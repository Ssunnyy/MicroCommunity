//
//  MCMyCountController.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountController.h"
#import "MCMyCountCell.h"
#import "MCMycountModle.h"

@interface MCMyCountController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *countTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCMyCountController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
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
    
    MCMycountModle *model = [[MCMycountModle alloc]init];
    model.content = @"竞价服务";
    model.money = @"-100";
    model.date = @"2015-08-15";
    
    for (int i = 0 ; i < 6; i ++) {
        [_dataArray addObject:model];
    }
    
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"我的账户"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andImage:ImageNamed(@"top_btn_plus.png")  highImage:ImageNamed(@"top_btn_plus.png") ];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyCountCellIdentifier";
    MCMyCountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyCountCell" owner:self options:nil]lastObject];
    }
    MCMycountModle *model = [_dataArray objectAtIndex:indexPath.row];
//    [cell configCellWithMCMycountModle: model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
