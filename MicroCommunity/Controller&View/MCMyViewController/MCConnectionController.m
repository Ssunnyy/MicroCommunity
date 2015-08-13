//
//  MCConnectionController.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCConnectionController.h"
#import "MCMyFriendHeadView.h"
#import "MCMyNewFriendCell.h"
#import "MCMyFriendSearchController.h"
#import "MCImPersonInfoController.h"

@interface MCConnectionController ()<UITableViewDelegate,UITableViewDataSource,MCMyFriendHeadViewDelegate,MCImPersonTableViewCellDelegate>

{
    NSInteger selectIndex; // 0 新朋友 1朋友 2通讯录
}

@property (weak, nonatomic) IBOutlet UITableView *connectTableView;
@property (nonatomic, strong) MCMyFriendHeadView *headViwe;


@property (nonatomic, strong) NSMutableArray *newsFriendArray;
@property (nonatomic, strong) NSMutableArray *friendArray;
@property (nonatomic, strong) NSMutableArray *phoneArray;

@end

@implementation MCConnectionController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self setHeadView];
    // Do any additional setup after loading the view from its nib.
}


/**
 *  初始化数据
 */
- (void) setUpData {

    selectIndex = 0;
    _friendArray = [[NSMutableArray alloc]init];
    _newsFriendArray = [[NSMutableArray alloc]init];
    _phoneArray = [[NSMutableArray alloc]init];
    
    for (int i = 0;  i < 5; i ++) {
        [_newsFriendArray addObject:@"1"];
    }
    
    for (int i = 0;  i < 10; i ++) {
        [_friendArray addObject:@"1"];
    }
    
    for (int i = 0;  i < 6; i ++) {
        [_phoneArray addObject:@"1"];
    }
}

/**
 *  初始化headView
 */
- (void) setHeadView {

    _connectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _headViwe = [[[NSBundle mainBundle]loadNibNamed:@"MCMyFriendHeadView" owner:self options:nil]lastObject];
    _headViwe.framewidth = SCREEN_WIDTH;
    _headViwe.frameheight = 53;
    _headViwe.delegate = self;
    _connectTableView.tableHeaderView = _headViwe;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"通讯录"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andImage:ImageNamed(@"top_btn_plus.png")  highImage:ImageNamed(@"top_btn_plus.png") ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count ;
    
    switch (selectIndex) {
        case 0:
            count = _newsFriendArray.count;
            break;
        case 1:
            count = _friendArray.count;
            break;
        case 2:
            count = _phoneArray.count;
            break;
        default:
            break;
    }
    
    return count;
    
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
    cell.delegate = self;
    [cell configCellWithType:selectIndex];
    [cell setBtnTag:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
}

#pragma  mark  --  MCMyFriendHeadViewDelegate

// 300 新朋友 301 朋友普 302 手机通讯录
- (void)btnClickAtIndex:(NSInteger)index {

    switch (index) {
        case 300:
        {
            selectIndex = 0;
        }
            break;
        case 301:
        {
            selectIndex = 1;
        }
            break;
        case 302:
        {
            selectIndex = 2;
        }
            break;
        default:
            break;
    }
    
    [self tableviewReloadWithSelectIndex:index];
}

- (void) tableviewReloadWithSelectIndex:(NSInteger)index{

    [_connectTableView reloadData];
    
}

#pragma  mark  --  MCImPersonTableViewCellDelegate

//  进入个人中心  接受  拒绝 发送 请求
- (void)headImageClickAtIndex:(NSInteger)index {
    
    if (index < 2000) {
        
        switch (selectIndex) {
            case 0:
            {
                MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
                person.titleName = @"繁华";
                person.type = receiveFriendIn;
                [self.navigationController pushViewController:person  animated:YES];
            }
                break;
            case 1:
            {
                MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
                person.titleName = @"繁华";
                person.type = friendIn;
                [self.navigationController pushViewController:person  animated:YES];
            }
                break;
            case 2:
            {
                MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
                person.titleName = @"繁华";
                person.type = customeIn;
                [self.navigationController pushViewController:person  animated:YES];
            }
                break;
            default:
                break;
        }
        
        //  进入个人中心
    }else{
        //  接受  拒绝 发送 请求
        switch (index) {
            case 0:
            {
                [ITTPromptView showMessage:@"已接受请求"];
            }
                break;
            case 2:
            {
                [ITTPromptView showMessage:@"已发送请求"];
            }
                break;
            default:
                break;
        }
    }
}

- (void)rightBarButtonClick:(UIButton *)button {

    pushToDestinationController(self, MCMyFriendSearchController);
    
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
