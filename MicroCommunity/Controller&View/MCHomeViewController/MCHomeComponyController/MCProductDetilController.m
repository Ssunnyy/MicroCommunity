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
#import "MCSendMessageView.h"

@interface MCProductDetilController ()<UITableViewDataSource,UITableViewDelegate,MCCompanyCommentCellDelegate,MCCompanProductBottomViewDelegate,EScrollerViewDelegate,MCSendMessageViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) MCProdectHeadTableViewCell *headTabCell;
@property (nonatomic, strong) MCCompanyCommentCell *commentCell;
@property (nonatomic, strong) MCCompanProductBottomView *bottomProView;
@property (nonatomic, strong) UIWebView *callWebView;// 用来拨打电话
@property (nonatomic, strong) EScrollerView *circleScrollV;//   广告位
@property (nonatomic, strong) MCSendMessageView *senderView; //发送view


@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *adArray;
@property (nonatomic, strong) MCProductModel *productInfo;

@end

@implementation MCProductDetilController

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    [self.headTabCell.sender removeKeyboardLison];
}


- (void) requestForDetail {


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configTableView];
    
    [self configBottomView];
    
    [self initCallWebView];
    
    [self initAdView];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

    _adArray = [[NSMutableArray alloc]init];
    _commentArray = [[NSMutableArray alloc]init];
    _productInfo = [[MCProductModel alloc]init];
    _productInfo.productIntro = @"深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司深圳有限责任公司";
    MCCompanyCommentModel *cmodel = [[MCCompanyCommentModel alloc]init];
    cmodel.comment = @"商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家详情商家";
    [_commentArray addObject:cmodel];
    
    for (int i = 0;  i < 3; i ++) {
        [_adArray addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    }
    
}

/**
 *  设置广告位
 */
- (void) initAdView {
    
    float headViewHeight = SCREEN_HEIGHT / 4;
    
    _circleScrollV=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight)];
    _productTableView.tableHeaderView = _circleScrollV;
    _circleScrollV.delegate = self;
    
    [_circleScrollV setScrollViewContent:_adArray];
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
 *  发送评论试图
 */
- (void) configSendView {
    
    _senderView = [[[NSBundle mainBundle] loadNibNamed:@"MCSendMessageView" owner:self options:nil]lastObject];
    _senderView.delegate = self;
    _senderView.framebottom = 88;
    _senderView.frameheight = 64;
    _senderView.framewidth = SCREEN_WIDTH;
    [self.headTabCell.commentView addSubview:_senderView];
}
/**
 *  发送评论
 */

#pragma  mark  -- MCSendMessageViewDelegate
- (void)sendMessage:(NSString *)message {

    
    
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1 + _commentArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float cellHeight = 0.0;
    
    if (indexPath.row == 0) {
        MCProdectHeadTableViewCell *cell = (MCProdectHeadTableViewCell *)self.headTabCell;
        CGSize introHeight = [self.productInfo.productIntro calculateSize:CGSizeMake(cell.descriptionLab.frame.size.width, FLT_MAX) font:cell.descriptionLab.font];
        
        if (introHeight.height > 29) {
            cell.desViewHeight.constant = 120 - 32 + introHeight.height;
        }
        cellHeight = cell.headViewHead.constant + cell.desViewHeight.constant  + cell.addressViewHeight.constant + cell.bottomViewHeight.constant;
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
        [cell configCellWithMCProductModel:self.productInfo];
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
            [cell configCellWithMCCompanyCommentModel:cModel];
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
            detail.sellerId = self.searchModel.seller_id;
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        case 202:
        {
            
            NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:10086"]];
            
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
        CGSize introHeight = [model.comment calculateSize:CGSizeMake(cell.contentLab.frame.size.width, FLT_MAX) font:cell.contentLab.font];
        if (introHeight.height > 16) {
            height = height - 16 + introHeight.height;
        }
        return height;
    } else {
        return 0;
    }
    
}

- (void)rightBarButtonClick:(UIButton *)button {

    [ITTPromptView showMessage:@"收藏成功 "];
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
