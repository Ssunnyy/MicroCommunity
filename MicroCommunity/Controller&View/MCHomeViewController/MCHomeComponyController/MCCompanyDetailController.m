//
//  MCCompanyDetailController.m
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyDetailController.h"
#import "MCComDetailHeadView.h"
#import "MCCompanyIntroCell.h"
#import "MCCompanyCommentCell.h"
#import "MCCompanyServerCell.h"
#import "MCCompanyBottomView.h"
#import "MCCompanyCommentView.h"
@interface MCCompanyDetailController ()<UITableViewDataSource,UITableViewDelegate,MCComDetailHeadViewDelegate,MCCompanyCommentCellDelegate,MCCompanyBottomViewDelegate,MCCompanyCommentViewDelegate>
{
    NSInteger cellType; // 0 商家介绍  1评论  2服务
}

@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UITableView *componyTableView;
@property (nonatomic, strong) MCComDetailHeadView *headView;       //   head
@property (nonatomic, strong) MCCompanyIntroCell *prototypeCell;
@property (nonatomic, strong) MCCompanyCommentCell *commentCell;
@property (nonatomic, strong) MCCompanyBottomView *bottomView; //   底部导航
@property (nonatomic, strong) MCCompanyCommentView *sendMessageView;//  发送评论

@property (nonatomic, strong) NSMutableArray *commentArray;//   评论数组
@property (nonatomic, strong) NSMutableArray *serverArray;//   服务数组
@property (nonatomic, strong) MCHomeSearchModel *companyModel;

@end

@implementation MCCompanyDetailController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    [self requestShopDetail];
//    [self enableKeyboardManger];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    //  移除通知
    [_sendMessageView removeKeyboardLison];
}
/**
 *  商家介绍
 */
- (void) requestShopDetail{
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCCompanyDetailController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.sellerId ForKey:@"seller_id"];
        [[MCHomeManager shareManager]requestHome_seller_detailsWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_details withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.superclass) {
                NSArray *data = [operation.resultDic objectForKey:@"data"];
                if (data.count > 0) {
                    weak.companyModel = [[MCHomeSearchModel alloc]initWithDataDic:[data objectAtIndex:0]];
                    weak.companyModel.seller_image = [NSString stringWithFormat:@"%@%@",Main_URL,weak.companyModel.seller_image];
                }
                
            }else {
                
            }
            [weak.headView configHeadWithMCHomeSearchModel:weak.companyModel];
            [weak tableViewReloadData];
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
}
/**
 *  评论列表
 *
 *  @return
 */

- (void) requestForCommentList {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCCompanyDetailController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.sellerId ForKey:@"seller_id"];
        [[MCHomeManager shareManager]requestHome_seller_comment_listWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_comment_list withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                
                [weak.commentArray removeAllObjects];
                
                NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
                
                for (int i = 0;  i < dataArray.count;  i ++) {
                    MCCompanyCommentModel *modle = [[MCCompanyCommentModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                    modle.image = [NSString stringWithFormat:@"%@%@",Main_URL,modle.image];
                    [weak.commentArray addObject:modle];
                }
            }else {
                [ITTPromptView showMessage:@"评论列表请求失败"];
            }
            [weak tableViewReloadData];
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
    
}

/**
 *  发表评论
 *
 *  @param comment
 */
- (void) requestForCommentWithComment:(NSString *) comment {

    __weak MCCompanyDetailController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.sellerId ForKey:@"seller_id"];
        [param safeString:comment ForKey:@"comment_content"];
        
        [[MCHomeManager shareManager]requestHome_seller_details_commentCityWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_details_comment withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"评论成功"];
            }else {
                [ITTPromptView showMessage:@"评论失败"];
            }
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
             [ITTPromptView showMessage:@"评论失败"];
        }];
    }
}
/**
 *  商家服务
 *
 *  @return
 */
- (void) requestForShopServer {

    
    if (self.serverArray.count > 0) {
        [self tableViewReloadData];
    }else{
    
        MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
        
        __weak MCCompanyDetailController *weak = self;
        
        if (user) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param safeString:user.user_id ForKey:@"user_id"];
            [param safeString:self.sellerId ForKey:@"seller_id"];
            [[MCHomeManager shareManager]requestHome_request_goods_serviceWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_service withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    [weak.serverArray removeAllObjects];
                    MCProductModel *product = [[MCProductModel alloc]initWithDataDic:operation.resultDic];
                    product.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,product.goods_image];
                    [weak.serverArray addObject:product];
                }else {
                    [ITTPromptView showMessage:@"服务请求失败"];
                }
                [weak tableViewReloadData];
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"网络请求失败"];
            }];
        }
    }
}

/**
 *  点赞
 */

- (void) requestForParise {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.sellerId ForKey:@"seller_id"];
        [[MCHomeManager shareManager]requestHome_seller_praiseWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_praise withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                
                NSString *code = [NSString stringWithFormat:@"%@",[operation.responseJSON objectForKey:@"code_array"]];
                
                if ([code isEqualToString:@"0"]) {
                    [ITTPromptView showMessage:@"取消点赞成功"];
                }else {
                    [ITTPromptView showMessage:@"点赞成功"];
                }
            }else {
                [ITTPromptView showMessage:@"操作失败"];
            }
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
             [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
}
/**
 *  商家收藏
 */
- (void) requestForCollectionWithSelect:(BOOL) select {
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.sellerId ForKey:@"company_id"];
        
        [[MCHomeManager shareManager]requestHome_seller_collectWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                if (operation.isSuccees) {
                    
                    NSString *code = [NSString stringWithFormat:@"%@",[operation.responseJSON objectForKey:@"code_array"]];
                    
                    if ([code isEqualToString:@"0"]) {
                        [ITTPromptView showMessage:@"取消收藏成功"];
                    }else {
                        [ITTPromptView showMessage:@"收藏成功"];
                    }
                }else {
                    [ITTPromptView showMessage:@"操作失败"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"网络请求失败"];
            }];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configHeadView];
    
    [self configSendMessageView];
    
     [self configBottomView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置tableViewHead
 */
- (void) setUpData {
    
    cellType = 0;
    _commentArray = [[NSMutableArray alloc] init];
    _serverArray = [[NSMutableArray alloc] init];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"商家详情"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andImage:ImageNamed(@"top_btn_heart.png") highImage:ImageNamed(@"top_btn_heart.png")];
}
/**
 *  设置tableViewHead
 */

- (void) configHeadView{
    //  注册商家介绍cell
    UINib *cellNib1 = [UINib nibWithNibName:@"MCCompanyIntroCell" bundle:nil];
    [_componyTableView registerNib:cellNib1 forCellReuseIdentifier:@"MCCompanyIntroCellIdentifier"];
    self.prototypeCell  = [_componyTableView dequeueReusableCellWithIdentifier:@"MCCompanyIntroCellIdentifier"];
    //  注册商家评论Cell
    UINib *cellNib2 = [UINib nibWithNibName:@"MCCompanyCommentCell" bundle:nil];
    [_componyTableView registerNib:cellNib2 forCellReuseIdentifier:@"MCCompanyCommentCellIdentifier"];
    self.commentCell  = [_componyTableView dequeueReusableCellWithIdentifier:@"MCCompanyCommentCellIdentifier"];
    
    _componyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCComDetailHeadView" owner:self options:nil]lastObject];
    _headView.delgate = self;
    _componyTableView.tableHeaderView = _headView;
}

/**
 *  设置bottomView
 */
- (void) configBottomView {
    
    _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"MCCompanyBottomView" owner:self options:nil]lastObject];
    _bottomView.delegate = self;
    [_bottomBgView addSubview:_bottomView];
}
/**
 *  设置 发送评论
 */
- (void) configSendMessageView  {

    _sendMessageView = [[[NSBundle mainBundle] loadNibNamed:@"MCCompanyCommentView" owner:self options:nil]lastObject];
    _sendMessageView.framewidth = SCREEN_WIDTH;
    _sendMessageView.delegate = self;
    [self.view addSubview:_sendMessageView];

}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    
    switch (cellType) {
        case 0:
            count = 1;
            break;
        case 1:
            count = _commentArray.count;
            break;
        case 2:
            count = _serverArray.count;
            break;
            
        default:
            break;
    }
    
    return count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float cellHeight = 0.0;
    
    switch (cellType) {
        case 0:
            {
                if (self.companyModel) {
                    MCCompanyIntroCell *cell = (MCCompanyIntroCell *)self.prototypeCell;
                    CGSize introHeight = [self.companyModel.seller_content calculateSize:CGSizeMake(cell.componyIntro.frame.size.width, FLT_MAX) font:cell.componyIntro.font];
                    
                    if (introHeight.height > 29) {
                        cell.introViewHeight.constant = 120 - 20 + introHeight.height;
                    }
                    cellHeight = cell.userInfoHeight.constant + cell.introViewHeight.constant  + cell.bottomViewHeight.constant;
                }
            }
            break;
        case 1:
            {
                cellHeight = [self calculateCellHeight:indexPath];
            }
            break;
        case 2:
            {
                cellHeight = 80;
            }
            break;
        default:
            break;
        }
    
    return cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (cellType) {
        case 0:
        {
            static NSString *cellID = @"MCCompanyIntroCellIdentifier";
            MCCompanyIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyIntroCell" owner:self options:nil]lastObject];
            }
            if (self.companyModel) {
                [cell configCellWithInfoModel:self.companyModel];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellID = @"MCCompanyCommentCellIdentifier";
            MCCompanyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyCommentCell" owner:self options:nil]lastObject];
            }
            MCCompanyCommentModel *cModel = [_commentArray objectAtIndex:indexPath.row];
            if (cModel) {
                [cell configCellWithMCCompanyCommentModel:cModel withType:NO];
            }
            cell.delegate = self;
            [cell setPariseBtnTag:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
            break;
        case 2:
        {
            static NSString *cellID = @"MCCompanyServerCellIdentifier";
            MCCompanyServerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyServerCell" owner:self options:nil]lastObject];
            }
            MCProductModel *sModel = [_serverArray objectAtIndex:indexPath.row];
            if (sModel) {
                [cell configCellWithMCProductModel:sModel];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (cellType) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
    NSLog(@"%ld",indexPath.row);
    
}

#pragma  mark  --  MCComDetailHeadViewDelegate

/**
 *  headView 代理方法
 */
- (void)headViewClickAtIndex:(NSInteger)index {

    
    switch (index) {
        case 100:
        {
            //简介
            cellType = 0;
            [self tableViewReloadData];
        }
            break;
        case 101:
        {
            //评论
            cellType = 1;
            [self requestForCommentList];
        }
            break;
        case 102:
        {
            //服务
            cellType = 2;
            [self requestForShopServer];
        }
            break;
        default:
            break;
    }
}

- (void) tableViewReloadData {

    [_componyTableView reloadData];
    
}

#pragma  mark  --   MCCompanyCommentCellDelegate
/**
 *  评论点赞
 */
- (void)pariseAtIndex:(NSInteger)index {

    MCCompanyCommentModel *model = [_commentArray objectAtIndex:index];
    
}

#pragma  mark  --  MCCompanyBottomViewDelegate
/**
 *  底部点击事件 点赞 评论 联系
 */
- (void)btnClickAtIndex:(NSInteger)index {

    switch (index) {
        case 100:
        {
            //  点赞商品
            [_sendMessageView hidenSelf];
            
            [self requestForParise];
        }
            break;
        case 101:
        {
            //  评论商品
            [_sendMessageView showSelf];
        }
            break;
        case 102:
        {
            //  联系
            [_sendMessageView hidenSelf];
        }
            break;
        default:
            break;
    }
}

#pragma  mark  --  MCCompanyCommentViewDelegate

- (void)sendMessage:(NSString *)meessage {

    if (meessage.length <= 0) {
        [ITTPromptView showMessage:@"评论内容不能为空"];
        return;
    }
    [_sendMessageView hidenSelf];
    
    [self requestForCommentWithComment:meessage];
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    MCCompanyCommentModel *model = [_commentArray objectAtIndex:indexPath.row];
    float height = 85;
    
    if (model) {
        MCCompanyCommentCell *cell = (MCCompanyCommentCell *)self.commentCell;
        CGSize introHeight = [model.comment_content calculateSize:CGSizeMake(cell.contentLab.frame.size.width, FLT_MAX) font:cell.contentLab.font];
        if (introHeight.height > 16) {
            height = height - 16 + introHeight.height;
        }
        return height;
    } else {
        return 0;
    }
    
}

/**
 *  收藏
 */
- (void)rightBarButtonClick:(UIButton *)button {

    [self requestForCollectionWithSelect:button.selected];
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
