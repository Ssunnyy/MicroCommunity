//
//  MCMyMessageController.m
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyMessageController.h"
#import "MCMyMessageCell.h"

@interface MCMyMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (nonatomic ,strong) MCMyMessageCell *messageCell;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCMyMessageController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self setUptableView];
    // Do any additional setup after loading the view from its nib.
}

- (void) setUptableView {

    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  注册商家介绍cell
    UINib *cellNib1 = [UINib nibWithNibName:@"MCMyMessageCell" bundle:nil];
    [_messageTableView registerNib:cellNib1 forCellReuseIdentifier:@"MCMyMessageCellIdentifier"];
    self.messageCell  = [_messageTableView dequeueReusableCellWithIdentifier:@"MCMyMessageCellIdentifier"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

    _dataArray = [[NSMutableArray alloc]init];
    
    MCMyMessageModel *message = [[MCMyMessageModel alloc]init];
    message.message = @"消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心";
    MCMyMessageModel *message1 = [[MCMyMessageModel alloc]init];
    message1.message = @"心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心消息中心";
    
    [_dataArray addObject:message];
    [_dataArray addObject:message1];
    
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"消息中心"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}
#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self calculateCellHeight:indexPath];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMyMessageCellIdentifier";
    MCMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMyMessageCell" owner:self options:nil]lastObject];
    }
    MCMyMessageModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell configCellWithMCMyMessageModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    
    MCMyMessageCell *cell = (MCMyMessageCell *)self.messageCell;
    
    MCMyMessageModel *model = (MCMyMessageModel *)[_dataArray objectAtIndex:indexPath.row];
    
    CGSize likeheight = [model.message calculateSize:CGSizeMake(cell.contenLab.frame.size.width, FLT_MAX) font:cell.contenLab.font];
    
    float height = 0;
    
    if (likeheight.height > 17) {
        height = 82 - 17 + likeheight.height;
    } else {
        height = 82;
    }

    return height;
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
