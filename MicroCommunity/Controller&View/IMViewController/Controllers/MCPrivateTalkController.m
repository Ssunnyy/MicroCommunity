//
//  MCPrivateTalkController.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCPrivateTalkController.h"
#import "MCPrivateTalkCell.h"
#import "MCImPersonInfoController.h"

@interface MCPrivateTalkController ()<UITableViewDelegate,UITableViewDataSource,MCPrivateTalkCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *talkTableView;
@property (nonatomic, strong) NSMutableArray *peopleArray;

@end

@implementation MCPrivateTalkController

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

    _peopleArray = [[NSMutableArray alloc]init];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    _talkTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setNavigationBarTitle:@"私聊"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
//    [self setButtonStyle:UIButtonStyleRegister andTitle:@"私聊" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}



#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCPrivateTalkCellIdentifier";
    MCPrivateTalkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCPrivateTalkCell" owner:self options:nil]lastObject];
    }
    cell.delegate = self;
    [cell setBtnTag:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

/**
 *  进入聊天
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}

#pragma  mark  --  MCPrivateTalkCellDelegate


- (void)headImageClickAtIndex:(NSInteger)index {
    
//    [_peopleArray objectAtIndex:index - 3000];
    MCImPersonInfoController *person = [[MCImPersonInfoController alloc]initWithNibName:@"MCImPersonInfoController"bundle:nil];
    person.titleName = @"繁华";
    [self.navigationController pushViewController:person  animated:YES];
    
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
