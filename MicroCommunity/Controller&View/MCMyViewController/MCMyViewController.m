//
//  MCMyViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyViewController.h"
#import "MCMyHeadView.h"
#import "MCMyTableCell.h"
#import "MCCompanyConfirmController.h"
#import "MCMyMessageController.h"
#import "MCMyShareController.h"
#import "MCMyGoldController.h"
#import "MCMySettingController.h"
#import "MCMyErWeiMaController.h"
#import "MCConnectionController.h"
#import "MCMyCountController.h"
#import "MCMyCollectionViewController.h"
#import "MCMyPublicController.h"
#import "MCMyInfoController.h"

@interface MCMyViewController ()<UITableViewDataSource,UITableViewDelegate,MCMyHeadViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) MCMyHeadView *headView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation MCMyViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate DisplayTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setUpHeadView];
    
    [self setNavigationBarStatus];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) setUpData {

    _dataArray = [[NSMutableArray alloc]init];
    
    NSArray *images = [NSArray arrayWithObjects:@"my_collection.png",@"my_public.png", @"my_count.png",@"my_share.png",@"my_connection.png",@"my_erweima.png",@"my_setting.png",nil];
    NSArray *titles = [NSArray arrayWithObjects:@"我的收藏",@"我的发布",@"我的账户",@"分享给朋友",@"我的通讯录",@"我的二维码",@"设置", nil];
    
    for (int i = 0 ; i < images.count; i ++) {
        if (![self isBusniss]) {
            if (i == 1 || i == 2) {
                continue;
            }
        }
        MCMyCellModel *model = [[MCMyCellModel alloc]init];
        model.myId = 300 +i;
        model.myHeadPic = [images objectAtIndex:i];
        model.myNickName = [titles objectAtIndex:i];
        [_dataArray addObject:model];
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  是不是商家
- (BOOL) isBusniss {
    
    if ([[[MCUserManager shareManager]getCurrentUser].user_type isEqualToString:@"2"]) {
        return YES;
    }else {
        return NO;
    }
}

- (void) setUpHeadView {

    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"MCMyHeadView" owner:self options:nil]lastObject];
    _headView.framewidth = SCREEN_WIDTH;
    if (iPhone6) {
        _headView.frameheight = 140;
    }else if (iPhone6Plus) {
        _headView.frameheight = 145;
    }
    _headView.delegate = self;
    _myTableView.tableHeaderView = _headView;
    
    if ([[MCUserManager shareManager] isAutoLoginResult]) {
        [_headView configHeadWithMCUserModel:[[MCUserManager shareManager]getCurrentUser]];
    }
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"我的"];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"消息" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}
#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyTableCellIdentifier";
    MCMyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyTableCell" owner:self options:nil]lastObject];
    }
    
    MCMyCellModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell configMyCellWithMCMyCellModel:model isShowCount:NO];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MCMyTableCell *cell = (MCMyTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    switch (cell.tag) {
        case 300:
        {
            /*
             *收藏
             */
            [self collection];
        }
            break;
        case 301:
        {
            /*
             *发布
             */
            [self public];
        }
            break;
        case 302:
        {
            /*
             *账户
             */
            [self myCount];
        }
            break;
        case 303:
        {
            /*
             *分享
             */
            [self shareFriend];
        }
            break;
        case 304:
        {
            /*
             *通讯录
             */
            [self myConnection];
        }
            break;
        case 305:
        {
            /*
             *二维码
             */
            [self myErWeiMa];
        }
            break;
        case 306:
        {
            /*
             *设置
             */
            [self setting];
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

/*
 *收藏
 */
- (void)collection{
    
    if ([[MCUserManager shareManager]isAutoLoginResult]) {
        
        MCMyCollectionViewController *collect = [[MCMyCollectionViewController alloc]initWithNibName:@"MCMyCollectionViewController" bundle:nil];
        collect.userId = [[MCUserManager shareManager]getCurrentUser].user_id;
        [self.navigationController pushViewController:collect animated:YES];
    }else {
        [ITTPromptView showMessage:@"用户还未登陆"];
    }
}
/*
 *发布
 */
- (void)public{
    
    if ([[MCUserManager shareManager]isAutoLoginResult]) {
        
        MCMyPublicController *public = [[MCMyPublicController alloc]initWithNibName:@"MCMyPublicController" bundle:nil];
        public.userId = [[MCUserManager shareManager]getCurrentUser].user_id;
        [self.navigationController pushViewController:public animated:YES];
        
    }else {
        [ITTPromptView showMessage:@"用户还未登陆"];
    }
}
/*
 *账户
 */
- (void)myCount{
    
    pushToDestinationController(self, MCMyCountController);
}
/*
 *分享
 */
- (void)shareFriend{
    
    pushToDestinationController(self, MCMyShareController);

}
/*
 *通讯录
 */
- (void)myConnection{
    
    pushToDestinationController(self, MCConnectionController);
    
}
/*
 *二维码
 */
- (void)myErWeiMa{
    
    pushToDestinationController(self, MCMyErWeiMaController);
}
/*
 *设置
 */
- (void)setting{

    MCMySettingController *setting = [[MCMySettingController alloc]initWithNibName:@"MCMySettingController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
    
}

#pragma  mark  --  MCMyHeadViewDelegate
/*
 *商家认证
 */
- (void)busnissBtnClickWithTag:(NSInteger)tag {

    switch (tag) {
        case 200:
        {
//            MCCompanyConfirmController *company = [[MCCompanyConfirmController alloc]initWithNibName:@"MCCompanyConfirmController" bundle:nil];
//            company.isConfirm = NO;
//            [self.navigationController pushViewController:company animated:YES];
        }
            break;
        case 201:
        {
            MCMyGoldController *gold = [[MCMyGoldController alloc]initWithNibName:@"MCMyGoldController" bundle:nil];
            [self.navigationController pushViewController:gold animated:YES];
        }
            break;
        case 203:
        {
            [self changeUereInfo];
        }
            break;
        default:
            break;
    }
    
    
    
}
/*
 *消息
 */
- (void)rightBarButtonClick:(UIButton *)button {

    MCMyMessageController *message = [[MCMyMessageController alloc]initWithNibName:@"MCMyMessageController" bundle:nil];
    [self.navigationController pushViewController:message animated:YES];
}
/*
 *修改个人信息
 */
- (void) changeUereInfo {
    MCMyInfoController *info = [[MCMyInfoController alloc]initWithNibName:@"MCMyInfoController" bundle:nil];
    [self.navigationController pushViewController:info animated:YES];
}
@end
