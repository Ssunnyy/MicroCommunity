//
//  ASIMViewController.m
//  ITotem
//
//  Created by Mac on 15/3/30.
//  Copyright (c) 2015年 李超峰. All rights reserved.
//

#import "MCIMViewController.h"
#import "MCImPersonTableViewCell.h"
#import "MCImGroupTableViewCell.h"
#import "MCUserSearchCell.h"
#import "MCPrivateTalkController.h"
#import "MCIMTalkRoomController.h"

#import "MCImPersonInfoController.h"

@interface MCIMViewController ()<UITableViewDelegate,UITableViewDataSource,MCUserSearchCellDelegate,MCImPersonTableViewCellDelegate>
{
    BOOL isSearch;
}
@property (weak, nonatomic) IBOutlet UITableView *imTableViw;

@property (nonatomic, strong) NSMutableArray *groupArray;// 群组
@property (nonatomic, strong) NSMutableArray *peopleArray;// 个人

@end

@implementation MCIMViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
      [AppDelegate DisplayTabBar];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
#pragma mark  ---  取消请求
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    [[MCIMManager shareManager]cancelAllRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
}

- (void) setUpData {

    isSearch = NO;
    
    _peopleArray = [[NSMutableArray alloc]init];
    
    _groupArray = [[NSMutableArray alloc]init];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _imTableViw.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setNavigationBarTitle:@"小城聊"];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"私聊" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {

    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = 1;
            break;
        case 1:
            if (isSearch) {
                count = 1;
            }else {
                count = 0;
            }
            break;
        case 2:
            count = 5;
            break;
        default:
            break;
    }
    
    return count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 80;
    
    if (indexPath.section == 1) {
        height = 347;
    }
    
    return height;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellID = @"MCImGroupTableViewCellIdentifier";
            MCImGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCImGroupTableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
            break;
        case 1:
        {
            static NSString *cellID = @"MCUserSearchCellIdentifier";
            MCUserSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCUserSearchCell" owner:self options:nil]lastObject];
            }
            cell.delegate = self;
            [cell reset];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellID = @"MCImPersonTableViewCellIdentifier";
            MCImPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCImPersonTableViewCell" owner:self options:nil]lastObject];
            }
            cell.delegate = self;
            [cell setBtnTag:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 60;
    }else {
        return 0;
    }
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
    lab.font = [UIFont systemFontOfSize:14];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(SCREEN_WIDTH - 50 - 10, 10, 50, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    lab.text = @"在线聊天(县城名)";
    UIView *line = [[UIView alloc]initWithFrame: CGRectMake(0, view.frameheight - 1, SCREEN_WIDTH, 1)];
    line.alpha = 0.4;
    line.backgroundColor = [UIColor grayColor];
    
    [view addSubview:lab];
    [view addSubview:btn];
    [view addSubview:line];

    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    switch (indexPath.section) {
            //进入聊天室
        case 0:
        {
            MCIMTalkRoomController *talkRoom = [[MCIMTalkRoomController alloc]initWithNibName:@"MCIMTalkRoomController" bundle:nil];
            [self.navigationController pushViewController:talkRoom animated:YES];
        }
            break;
        case 2:
            //发起聊天
            break;
        default:
            break;
    }
    
}

#pragma  mark  --  MCUserSearchCellDelegate
/*
 *  400 搜索 401取消
 */
- (void)searchConditionSex:(NSString *)sex AndHunYin:(NSString *)hunyin AndAge:(NSString *)age AndCollege:(NSString *)college AndConstellation:(NSString *)Constellation AndTag:(NSInteger)tag{
    isSearch = NO;
    switch (tag) {
        case 400:
            
            break;
        case 401:
            
            break;
        default:
            break;
    }
    [self tableViewReloadData];
}

- (void) tableViewReloadData {

    [_imTableViw reloadData];
    
}

#pragma  mark  --  MCImPersonTableViewCellDelegate
/*
 * 点击进入个人主页
 */
- (void)headImageClickAtIndex:(NSInteger)index {
    
//    [_peopleArray objectAtIndex:index - 1000];
    
    MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
    person.titleName = @"晓红";
    person.type = customeIn;
    [self.navigationController pushViewController:person  animated:YES];
    
}

/*
 * 搜索好友
 */
- (void) searchFriend {
    
    isSearch = YES;
    [self tableViewReloadData];
}

/*
 * 导航栏右侧按钮点击事件 私聊
 */
- (void)rightBarButtonClick:(UIButton *)button {
    
    MCPrivateTalkController *private = [[MCPrivateTalkController alloc]initWithNibName:@"MCPrivateTalkController" bundle:nil];
    [self.navigationController pushViewController:private animated:YES];
}
@end

