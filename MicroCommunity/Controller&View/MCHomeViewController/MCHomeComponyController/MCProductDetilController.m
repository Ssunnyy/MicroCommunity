//
//  MCProductDetilController.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCProductDetilController.h"
#import "MCProdectHeadTableViewCell.h"
#import "MCCompanyCommentCell.h"
#import "MCCompanProductBottomView.h"
#import "MCCompanyDetailController.h"
#import "EScrollerView.h"

@interface MCProductDetilController ()<UITableViewDataSource,UITableViewDelegate,MCCompanyCommentCellDelegate,MCCompanProductBottomViewDelegate,EScrollerViewDelegate,MCSendMessageViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) MCProdectHeadTableViewCell *headTabCell;
@property (nonatomic, strong) MCCompanyCommentCell *commentCell;
@property (nonatomic, strong) MCCompanProductBottomView *bottomProView;
@property (nonatomic, strong) UIWebView *callWebView;// 用来拨打电话
@property (nonatomic, strong) EScrollerView *circleScrollV;//   广告位


@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *adArray;
@property (nonatomic, strong) MCProductModel *productInfo;

@end

@implementation MCProductDetilController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [self requestForDetail];
}

- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:YES];
    [self requestForCommentList];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    [[MCHomeManager shareManager]cancelAllRequest];
}
/**
 *  评论列表网络请求
 *
 *  @return
 */

- (void) requestForCommentList {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCProductDetilController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        if(_type == zhaopingType){
            [param safeString:self.zhaopinModel.zhaopin_id ForKey:@"zhaopin_id"];
        }else {
            [param safeString:self.searchModel.goods_id ForKey:@"goods_id"];
            [[MCHomeManager shareManager]requestHome_request_goods_comment_listWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_comment_list withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    
                    NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
                    for (int i = 0; i < dataArray.count ; i ++) {
                        MCCompanyCommentModel *comment =[[MCCompanyCommentModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                        comment.image = [NSString stringWithFormat:@"%@%@",Main_URL,comment.image];
                        [weak.commentArray addObject:comment];
                    }
                }else {
                    [ITTPromptView showMessage:@"评论列表请求失败"];
                }
                [weak tableViewReload];
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"评论列表请求失败"];
            }];
        }
    }
    
}

/**
 *  head请求
 */
- (void) requestForDetail {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCProductDetilController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        if(_type == zhaopingType){
            
            [param safeString:self.zhaopinModel.zhaopin_id ForKey:@"zhaopin_id"];
            [[MCHomeManager shareManager]requestHome_haopin_detailsWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_zhaopin_details withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    
                    weak.zhaopinModel = [[MCHomeZhaoPingModel alloc]initWithDataDic:operation.resultDic];
                    weak.zhaopinModel.seller_image = [NSString stringWithFormat:@"%@%@",Main_URL,weak.zhaopinModel.seller_image];
                    [weak.bottomProView configUserInfoWithUerName:self.zhaopinModel.linkman andConnect:self.zhaopinModel.linkphone];
                }else {
                    [ITTPromptView showMessage:@"查询失败"];
                }
                [weak tableViewReload];
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"网络请求失败"];
            }];
        } else {
            //  产品
            
            [param safeString:self.searchModel.goods_id ForKey:@"goods_id"];
            [[MCHomeManager shareManager]requestHome_request_goods_detailsWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_details withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    
                    weak.productInfo = [[MCProductModel alloc]initWithDataDic:operation.resultDic];
                    weak.productInfo.goods_image = [NSString stringWithFormat:@"%@%@",Main_URL,weak.productInfo.goods_image];
                    weak.productInfo.is_goods_collect = [[operation.responseJSON objectForKey:@"goods_info"] objectForKey:@"is_goods_collect"];
                    [weak.bottomProView configUserInfoWithUerName:self.productInfo.linkman andConnect:self.productInfo.linkphone];
                }else {
                    [ITTPromptView showMessage:@"查询失败"];
                }
                [weak tableViewReload];
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"网络请求失败"];
            }];
        }
    }
}


/**
 *  发表评论
 */
- (void) sendMessageRequest:(NSString *) message{

    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCProductDetilController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        if(_type == zhaopingType){
        
        }else {
            [param safeString:self.searchModel.goods_id ForKey:@"goods_id"];
            [param safeString:message ForKey:@"content"];
            [[MCHomeManager shareManager]requestHome_request_goods_commentWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_comment withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                if (operation.isSuccees) {
                    [ITTPromptView showMessage:@"评论成功"];
                }else{
                    [ITTPromptView showMessage:@"评论失败"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"评论失败"];
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configTableView];
    
    [self configBottomView];
    
    [self initCallWebView];
    
    [self initAdView];

    [self configAdHeadViewForData];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

    _adArray = [[NSMutableArray alloc]init];
    _commentArray = [[NSMutableArray alloc]init];
}

- (void) configAdHeadViewForData{

    [_adArray removeAllObjects];
    
    if (_type == zhaopingType) {
        if (self.zhaopinModel.seller_image) {
            [_adArray addObject:self.zhaopinModel.seller_image];
        }
    }else {
        if (self.searchModel.goods_image) {
            [_adArray addObject:self.searchModel.goods_image];
        }
    }
    [_circleScrollV setScrollViewContent:_adArray];
}

/**
 *  设置广告位
 */
- (void) initAdView {
    
    float headViewHeight = SCREEN_HEIGHT / 4;
    
    _circleScrollV=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
    _productTableView.tableHeaderView = _circleScrollV;
    _circleScrollV.delegate = self;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"详情"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andImage:ImageNamed(@"top_btn_heart.png") highImage:ImageNamed(@"top_btn_heart.png")];
}
/**
 *  设置tableView
 */
- (void) configTableView {

    _productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  注册商品介绍cell
    UINib *cellNib1 = [UINib nibWithNibName:@"MCProdectHeadTableViewCell" bundle:nil];
    [_productTableView registerNib:cellNib1 forCellReuseIdentifier:@"MCProdectHeadTableViewCellIdentifier"];
    self.headTabCell  = [_productTableView dequeueReusableCellWithIdentifier:@"MCProdectHeadTableViewCellIdentifier"];
//    [self.headTabCell.sender removeKeyboardLison];
    //  注册评论cell
    UINib *commentCellNib = [UINib nibWithNibName:@"MCCompanyCommentCell" bundle:nil];
    [_productTableView registerNib:commentCellNib forCellReuseIdentifier:@"MCCompanyCommentCellIdentifier"];
    self.commentCell  = [_productTableView dequeueReusableCellWithIdentifier:@"MCCompanyCommentCellIdentifier"];

}

/**
 *  设置底部试图
 */

- (void) configBottomView {
    
    _bottomProView = [[[NSBundle mainBundle] loadNibNamed:@"MCCompanProductBottomView" owner:self options:nil]lastObject];
    _bottomProView.frameheight = 64;
    _bottomProView.delegate = self;
    [_bottomView addSubview:_bottomProView];
}
/**
 *  初始化网页调用拨打电话
 */
- (void) initCallWebView {
    
    _callWebView= [[UIWebView alloc] init];
    [self.view addSubview:_callWebView];
}

#pragma  mark  --  EScrollerViewDelegate
/**
 *  滚动试图点击事件
 */
- (void)EScrollerViewDidClicked:(NSUInteger)index {

    
}

/**
 *  发送评论
 */

#pragma  mark  -- MCSendMessageViewDelegate
- (void)sendMessage:(NSString *)message {
    
    [self sendMessageRequest:message];
    
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + _commentArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float cellHeight = 0.0;
    
    if (indexPath.row == 0) {
        MCProdectHeadTableViewCell *cell = (MCProdectHeadTableViewCell *)self.headTabCell;
        
        CGSize introHeight;
        
        if (_type == zhaopingType) {
            introHeight = [self.zhaopinModel.zhaopin_content calculateSize:CGSizeMake(cell.descriptionLab.frame.size.width, FLT_MAX) font:cell.descriptionLab.font];
        }else {
            introHeight = [self.productInfo.goods_message calculateSize:CGSizeMake(cell.descriptionLab.frame.size.width, FLT_MAX) font:cell.descriptionLab.font];
        }
        if (introHeight.height > 29) {
            cell.desViewHeight.constant = 120 - 32 + introHeight.height;
        }
        cellHeight = cell.headViewHead.constant + cell.desViewHeight.constant  + cell.addressViewHeight.constant + cell.bottomViewHeight.constant + 30;
        
    } else {
        cellHeight = [self calculateCellHeight:indexPath];
    }
    return cellHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellID = @"MCProdectHeadTableViewCellIdentifier";
        MCProdectHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MCProdectHeadTableViewCell" owner:self options:nil]lastObject];
        }
        cell.sender.delegate = self;
        if (_type == zhaopingType) {
            [cell configCellWithMCHomeZhaoPingModel:self.zhaopinModel];
        }else {
            [cell configCellWithMCProductModel:self.productInfo];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *cellID = @"MCCompanyCommentCellIdentifier";
        MCCompanyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MCCompanyCommentCell" owner:self options:nil]lastObject];
        }
        MCCompanyCommentModel *cModel = [_commentArray objectAtIndex:indexPath.row - 1];
        if (cModel) {
            [cell configCellWithMCCompanyCommentModel:cModel withType:YES];
        }
        cell.delegate = self;
        [cell setPariseBtnTag:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
#pragma  mark  --  MCCompanyCommentCellDelegate
/**
 *  评论点赞
 */
- (void)pariseAtIndex:(NSInteger)index {

}

#pragma  mark  --  MCCompanProductBottomViewDelegate
/**
 *  200 联系人 201 企业详情 202 通话 203 咨询
 */

- (void)bottomBtnClickAtIndex:(NSInteger)index {
    
    switch (index) {
        case 200:
            
            break;
        case 201:
        {
            
            MCCompanyDetailController *detail = [[MCCompanyDetailController alloc]initWithNibName:@"MCCompanyDetailController" bundle:nil];
            if (_type == zhaopingType) {
                detail.sellerId = self.zhaopinModel.zhaopin_seller_id;
            }else {
                detail.sellerId = self.searchModel.seller_id;
            }
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        case 202:
        {
            
            NSURL *telURL ;
            if (_type == zhaopingType) {
                telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.zhaopinModel.linkphone]];
            } else {
                telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.searchModel.linkphone]];
            }
            [_callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            
        }
            break;
        case 203:
            
            break;
        default:
            break;
    }
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    MCCompanyCommentModel *model = [_commentArray objectAtIndex:indexPath.row - 1];
    float height = 85;
    
    if (model) {
        MCCompanyCommentCell *cell = (MCCompanyCommentCell *)self.commentCell;
        CGSize introHeight = [model.goods_comment_content calculateSize:CGSizeMake(cell.contentLab.frame.size.width, FLT_MAX) font:cell.contentLab.font];
        if (introHeight.height > 16) {
            height = height - 16 + introHeight.height;
        }
        return height;
    } else {
        return 0;
    }
    
}

- (void)rightBarButtonClick:(UIButton *)button {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCProductDetilController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        if(_type == zhaopingType){
            
            [param safeString:self.zhaopinModel.zhaopin_id ForKey:@"zhaopin_id"];
            [[MCHomeManager shareManager] requestHome_zhaopin_collectWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_zhaopin_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
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
        }else {
            
            [param safeString:self.searchModel.goods_id ForKey:@"goods_id"];
            [[MCHomeManager shareManager] requestHome_request_goods_collectWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_collect withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
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
}


- (void) tableViewReload{

    [_productTableView reloadData];
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
