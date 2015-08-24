//
//  MCMyPublicController.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyPublicController.h"
#import "MCCompanyConfirmController.h"
#import "MCShopPublicController.h"

#import "MCMysPublicCell.h"
#import "MCMyPublicBottomView.h"
#import "MCMyPublishShowMessage.h"

@interface MCMyPublicController ()<UITableViewDataSource,UITableViewDelegate,MCMysPublicCellCellDelegate,MCMyPublicBottomViewDelegate,MCMyPublishShowMessageDelegate>

@property (weak, nonatomic) IBOutlet UITableView *publicTableViw;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) MCMyPublicBottomView *bottom;
@property (nonatomic, strong) MCMyPublishShowMessage *showMessage;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MCMyPublicController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    
    [self requestForMyPublic];
}

- (void) requestForMyPublic{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:self.userId ForKey:@"user_id"];

    __weak MCMyPublicController *weak = self;
    
    [[MCMYManager shareManager]requestMy_PublicWithParam:param withIndicatorView:self.view withCancelRequestID:My_Request_publish withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        if (operation.isSuccees) {
            
            NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
            if (dataArray.count > 0) {
                for ( int i = 0; i < dataArray.count ; i ++) {
                    MCMyPublicModel *public = [[MCMyPublicModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                    public.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,public.goods_image];
                    public.isChoose = NO;
                    [_dataArray addObject:public];
                }
            }
        }else{
            [ITTPromptView showMessage:@"查询失败"];
        }
        [weak tableViewReloadData];
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [ITTPromptView showMessage:@"网络请求失败"];
    }];
}

- (void) deletePublic{

    __weak MCMyPublicController *weak = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param safeString:self.userId ForKey:@"user_id"];
    
    
    NSArray *array = [NSArray arrayWithArray:_dataArray];
    NSMutableArray *deleteIds = [NSMutableArray array];
    
    for (MCMyPublicModel *model in array) {
        if (model.isChoose) {
            [deleteIds addObject:model.goods_id];
        }
    }
    
    if (deleteIds.count > 0) {
        [param safeString:[deleteIds componentsJoinedByString:@","]ForKey:@"goods_id"];
    } else {
        [param safeString:@""ForKey:@"goods_id"];
    }
    
    
    [[MCHomeManager shareManager]requestHome_goods_DeleteWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_all_goods_delete withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
        
        if (operation.isSuccees) {
            
            NSArray *array = [NSArray arrayWithArray:_dataArray];
            
            for (MCMyPublicModel *model in array) {
                if (model.isChoose) {
                    [weak.dataArray removeObject:model];
                }
            }
            [ITTPromptView showMessage:@"产品删除成功"];
        }else {
            [ITTPromptView showMessage:@"产品删除失败,请重试"];
        }
        [weak tableViewReloadData];
    } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
        [ITTPromptView showMessage:@"产品删除失败,请重试"];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configBottomView];
    
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
    
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    _publicTableViw.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setNavigationBarTitle:@"我的发布"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"编辑企业资料" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 25, 100, 40);
    [rightBtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:rightBtn];
}
/**
 *  设置导航栏
 */
- (void) configBottomView {

    _bottom = [[[NSBundle mainBundle]loadNibNamed:@"MCMyPublicBottomView" owner:self options:nil] lastObject];
    _bottom.framewidth = SCREEN_WIDTH;
    _bottom.frameheight = 47;
    _bottom.delegate = self;
    [_bottomView addSubview:_bottom];
    
}

/**
 *  设置导ApplyView
 */
- (void) configApplyView {
    
    _showMessage = [[[NSBundle mainBundle]loadNibNamed:@"MCMyPublishShowMessage" owner:self options:nil]lastObject];
    _showMessage.delegate = self;
    _showMessage.center = self.view.center;
    [self.view addSubview:_showMessage];
    _showMessage.hidden = YES;
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 77;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCMysPublicCellIdentifier";
    MCMysPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCMysPublicCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MCMyPublicModel *modle = [_dataArray objectAtIndex:indexPath.row];
    [cell setUpCellWithModel:modle andeIndex:indexPath.row];
    cell.delegate = self;
    return cell;

}

#pragma  mark  --  MCMysPublicCellCellDelegate

- (void)inType:(NSInteger)type AtIndex:(NSInteger)index {
    
    switch (type) {
        case 100://  点击击该产品图片可以对该产品重新编辑。
        {
            MCShopPublicController *pub = [[MCShopPublicController alloc]initWithNibName:@"MCShopPublicController" bundle:nil];
            pub.isEdting = YES;
            [self.navigationController pushViewController:pub animated:YES];
        }
            break;
        case 101://  选中 删除或者重新发布
        {
            MCMyPublicModel *model = [_dataArray objectAtIndex:index];
            model.isChoose = !model.isChoose;
        }
            break;
        default:
            break;
    }
}

#pragma  mark  --  MCMyPublicBottomViewDelegate

//  200 删除 201 重新发布
- (void)deleteOrPublic:(NSInteger)tag {

    switch (tag) {
        case 200:
        {
            BOOL isDelete = NO;
            for (MCMyPublicModel *model in _dataArray) {
                if (model.isChoose) {
                    isDelete = YES;
                }
            }
            if (isDelete) {
                [_showMessage showMessage];
            }else {
                [ITTPromptView showMessage:@"请选择要删除的选项"];
            }
        }
            break;
        case 201:
        {
        
        }
            break;
        default:
            break;
    }
    
}

#pragma  mark  --  MCMyPublishShowMessageDelegate
//  400 取消  401 确认
- (void)sureOrCancel:(NSInteger)index {
    
    switch (index) {
        case 400:
        {
            
        }
            break;
        case 401:
        {
            [self deletePublic];
        }
            break;
        default:
            break;
    }
}

- (void)rightBarButtonClick:(UIButton *)button {

    MCCompanyConfirmController *confirm = [[MCCompanyConfirmController alloc]initWithNibName:@"MCCompanyConfirmController" bundle:nil];
    confirm.isConfirm = NO;
    [self.navigationController pushViewController:confirm animated:YES];
    
}


- (void) tableViewReloadData {

    [_publicTableViw reloadData];
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
