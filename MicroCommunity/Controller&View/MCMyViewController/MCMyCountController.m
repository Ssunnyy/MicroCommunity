//
//  MCMyCountController.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCountController.h"
#import "MCMyCountCells.h"
#import "MCMyCountHeadView.h"
#import "MCMyCountBottomView.h"
#import "MCMyRechargeController.h"
#import "MCMyCountApplyView.h"

@interface MCMyCountController ()<UITableViewDataSource,UITableViewDelegate,MCMyCountBottomViewDelegate,MCMyCountApplyViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *countTableView;
@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (nonatomic, strong) MCMyCountHeadView *headView;
@property (nonatomic, strong) MCMyCountBottomView *bottomView;
@property (nonatomic, strong) MCMyCountApplyView *applyView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MCMyCountController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];

}
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [_applyView removeKeyboardLison];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self conifgHeadView];
    
    [self conifgBottomView];
    
    [self configApplyView];
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
}
/**
 *  设置导headView
 */

- (void) conifgHeadView {

    _countTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCMyCountHeadView" owner:self options:nil]lastObject];
    _headView.frameheight = 122;
    _headView.framewidth = SCREEN_WIDTH;
    _countTableView.tableHeaderView = _headView;
}

/**
 *  设置导bottomview
 */

- (void) conifgBottomView {

    _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"MCMyCountBottomView" owner:self options:nil]lastObject];
    _bottomView.framewidth = SCREEN_WIDTH;
    _bottomView.frameheight = 47;
    _bottomView.delegate = self;
    [_bottom addSubview:_bottomView];
}

/**
 *  设置导ApplyView
 */
- (void) configApplyView {

    _applyView = [[[NSBundle mainBundle]loadNibNamed:@"MCMyCountApplyView" owner:self options:nil]lastObject];
    _applyView.delegate = self;
    _applyView.center = self.view.center;
    [self.view addSubview:_applyView];
    _applyView.hidden = YES;
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 57;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyCountCellIdentifier";
    MCMyCountCells *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyCountCells" owner:self options:nil]lastObject];
    }

    MCMycountModle *model = [_dataArray objectAtIndex:indexPath.row];
    [cell configCellWithMCMycountModle: model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark  --  MCMyCountBottomViewDelegate 

- (void)buttonClickAtIndex:(NSInteger)index {

    switch (index) {
        case 200:
        {
            pushToDestinationController(self, MCMyRechargeController);
        }
            break;
        case 201:
        {
            [_applyView showApply];
        }
            break;
        default:
            break;
    }
}
#pragma mark  --  MCMyCountApplyViewDelegate

- (void)myCountApplyClick:(NSInteger)index andMoney:(NSString *)money andName:(NSString *)name andPay:(NSString *)pay {

    
    
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
