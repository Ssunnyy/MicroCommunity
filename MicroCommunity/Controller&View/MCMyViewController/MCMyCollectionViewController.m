//
//  MCMyCollectionViewController.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyCollectionViewController.h"
#import "MCCompanyServerCell.h"
#import "MCSerachResultCell.h"

@interface MCMyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selecIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *collectionTableViwe;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@property (weak, nonatomic) IBOutlet UIButton *serverBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@property (nonatomic, strong) NSMutableArray *shopArray;
@property (nonatomic, strong) NSMutableArray *serverArray;


@end

@implementation MCMyCollectionViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear: YES];
    [AppDelegate HideTabBar];
    
    [self requeswithType:0];
}


//  0 商家  1 产品
- (void) requeswithType:(NSInteger)type{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:self.userId ForKey:@"user_id"];
    
    __weak MCMyCollectionViewController *weak = self;
    
    if (type == 0) {
        [[MCMYManager shareManager] requestMy_CollectWithParam:param withIndicatorView:self.view withCancelRequestID:My_Request_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                
                NSArray *data = [operation.resultDic objectForKey:@"data"];
                if (data.count > 0) {
                    
                    [_shopArray removeAllObjects];
                    for (int i = 0 ; i < data.count; i ++) {
                        MCHomeSearchModel *shop = [[MCHomeSearchModel alloc]initWithDataDic:[data objectAtIndex:i]];
                        shop.seller_image = [NSString stringWithFormat:@"%@%@",Main_URL,shop.seller_image];
                        [_shopArray addObject:shop];
                    }
                }
            }else {
                [ITTPromptView showMessage:@"查询失败"];
            }
            [weak performSelectorOnMainThread:@selector(tableViewReload) withObject:nil waitUntilDone:NO];
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }else {
        [[MCMYManager shareManager] requestMy_Goods_CollectWithParam:param withIndicatorView:self.view withCancelRequestID:My_Request_goods_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                
                NSArray *data = [operation.resultDic objectForKey:@"data"];
                if (data.count > 0) {
                    
                    [_serverArray removeAllObjects];
                    for (int i = 0 ; i < data.count; i ++) {
                        MCMyCollectProductModel *product = [[MCMyCollectProductModel alloc]initWithDataDic:[data objectAtIndex:i]];
                        product.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,product.goods_image];
                        [_serverArray addObject:product];
                    }
                }
            }else {
                [ITTPromptView showMessage:@"查询失败"];
            }
            [weak performSelectorOnMainThread:@selector(tableViewReload) withObject:nil waitUntilDone:NO];

        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
}

- (void)awakeFromNibs {

    _btnWidth.constant = SCREEN_WIDTH / 2;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
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

    _shopArray = [[NSMutableArray alloc]init];
    _serverArray = [[NSMutableArray alloc]init];
    selecIndex = 0;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    _collectionTableViwe.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setNavigationBarTitle:@"我的收藏"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count;
    switch (selecIndex) {
        case 0:
            count = _shopArray.count;
            break;
        case 1:
            count = _serverArray.count;
            break;
        default:
            break;
    }
    
    return count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height;
    
    switch (selecIndex) {
        case 0:
            height = 77;
            break;
        case 1:
            height = 80;
            break;
        default:
            break;
    }
    
    return height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (selecIndex) {
        case 0:
        {
            static NSString *cellID = @"MCSerachResultCellIdentifier";
            MCSerachResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCSerachResultCell" owner:self options:nil]lastObject];
            }
            MCHomeSearchModel *searchModel = [_shopArray objectAtIndex:indexPath.row];
            [cell configCellWithMCHomeSearchModel:searchModel withType:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellID = @"MCCompanyServerCellIdentifier";
            MCCompanyServerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyServerCell" owner:self options:nil]lastObject];
            }
            
            MCMyCollectProductModel *product = [_serverArray objectAtIndex:indexPath.row];
            [cell configCellWithMCMyCollectProductModel:product];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}


- (IBAction)switchVtnClick:(UIButton *)sender {
    
    __weak MCMyCollectionViewController *weak = self;
    
    switch (sender.tag) {
        case 300:
        {
            _lineLeft.constant = 0;
            _shopBtn.selected = YES;
            _serverBtn.selected = NO;
            selecIndex = 0;
        }
            break;
        case 301:
        {
            _lineLeft.constant = SCREEN_WIDTH / 2;
            _shopBtn.selected = NO;
            _serverBtn.selected = YES;
            selecIndex = 1;
        }
            break;
        default:
            break;
    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [weak.view layoutIfNeeded];
    }];
    
    [self requeswithType:selecIndex];

}

- (void) tableViewReload {

    [_collectionTableViwe reloadData];
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
