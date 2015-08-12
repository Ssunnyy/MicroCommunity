//
//  MCIMTalkRoomController.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMTalkRoomController.h"
#import "MCImGroupRoomCell.h"

#import "MCIMCreatController.h"



@interface MCIMTalkRoomController ()<UITableViewDelegate,UITableViewDataSource,MCImGroupRoomCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *groupTableView;

@property (nonatomic, strong) NSMutableArray *groupArray;

@end

@implementation MCIMTalkRoomController

- (void) viewWillAppear:(BOOL)animated {

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

    _groupArray = [[NSMutableArray alloc]init];
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _groupTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setNavigationBarTitle:@"聊天室"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"创建" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCImGroupRoomCellIdentifier";
    MCImGroupRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCImGroupRoomCell" owner:self options:nil]lastObject];
    }
    cell.delegate = self;
    [cell setBtnTag:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma  mark  --  MCImGroupRoomCellDelegate
//  进入讨论组信息主页
- (void)groupHeadImageClickAtIndex:(NSInteger)index {

//    [_groupArray objectAtIndex:index - 2000];
    
}

//  创建聊天室
- (void)rightBarButtonClick:(UIButton *)button {

    
    MCIMCreatController *creat = [[MCIMCreatController alloc]initWithNibName:@"MCIMCreatController" bundle:nil];
    [self.navigationController pushViewController:creat animated:YES];
    
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
