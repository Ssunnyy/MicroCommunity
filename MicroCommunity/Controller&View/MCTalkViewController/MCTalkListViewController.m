//
//  MCTalkListViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListViewController.h"
#import "MCTalkListHeaderView.h"

#import "MCTalkListCell.h"
#import "MCTalkListModel.h"
#import "QShowImgViewController.h"
#import "QFriendPicView.h"
#import "MCTalkPublishController.h"
#import "MCTalkDetailController.h"

#import "ASCCPersonEditViewController.h"


@interface MCTalkListViewController ()<UITableViewDataSource,UITableViewDelegate,MCTalkListHeaderViewDelegate,MCTalkListCellDelegate,qChoosePicDelegate,ITTTableViewDelegate>

{
    BOOL isFirst;// 是不是首次进入
    BOOL isSeePhoto;
    NSInteger pagIndex;//   分页
    BOOL pageType;//    最新最热
    NSInteger clickIndex;// 点击那行
}

@property (weak, nonatomic) IBOutlet ITTTableView *talkTableView;
@property (nonatomic, strong) MCTalkListHeaderView *headView;
@property (nonatomic, strong) MCTalkListCell *prototypeCell;
@property (nonatomic, strong) QShowImgViewController *scrollV;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCTalkListViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    
    if (isFirst) {
        pagIndex = 1;
        [self requestWithType:pageType andPageIndex:pagIndex];
        isFirst = NO;
        isSeePhoto = NO;
    }else {
        if (!isSeePhoto) {
            [self reloadDataAtIndex:clickIndex];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [[MCTalkManager shareManager]cancelAllRequest];
}

// 0 最新 1 最热
- (void) requestWithType:(NSInteger) type andPageIndex:(NSInteger) pageIndex{
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCTalkListViewController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        if (self.headModel) {
            
            [param safeString:self.headModel.bar_id ForKey:@"bar_id"];
            [param safeString:[NSString stringWithFormat:@"%ld",pageIndex] ForKey:@"pageindex"];
            
            if (type == 0) {
                [[MCTalkManager shareManager]requestTalk_New_ListWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_new_list withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                    if (operation.isSuccees) {
                        if (pagIndex == 1) {
                            [weak.dataArray removeAllObjects];
                        }
                        NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
                        
                        for (int i = 0; i < dataArray.count; i++ ) {
                            MCTalkListModel *model = [[MCTalkListModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                            model.head_image = [NSString stringWithFormat:@"%@%@",Main_URL,model.head_image];
                            if (model.talk_image != nil) {
                                if (model.talk_image.length > 0) {
                                    model.images = [NSMutableArray array];
                                    NSArray *images = [model.talk_image componentsSeparatedByString:@","];
                                    for (int i = 0; i < images.count; i ++) {
                                        ;
                                        [model.images addObject:[NSString stringWithFormat:@"%@%@",Main_URL,[images objectAtIndex:i]]];
                                    }
                                }
                            }
                            [weak.dataArray addObject:model];
                        }
                        pagIndex ++;
                        [weak.talkTableView reloadData];
                    }
                    
                    [weak.talkTableView  endNetTable];
                } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                    [weak.talkTableView  endNetTable];
                    [ITTPromptView showMessage:@"数据请求失败"];
                }];
            } else {
                
                [[MCTalkManager shareManager]requestTalk_Hot_ListWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_hot_list withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                    if (operation.isSuccees) {
                        if (pagIndex == 1) {
                            [weak.dataArray removeAllObjects];
                        }
                        pagIndex ++;
                        NSArray *dataArray = [operation.resultDic objectForKey:@"data"];
                        
                        for (int i = 0; i < dataArray.count; i++ ) {
                            MCTalkListModel *model = [[MCTalkListModel alloc]initWithDataDic:[dataArray objectAtIndex:i]];
                            model.head_image = [NSString stringWithFormat:@"%@%@",Main_URL,model.head_image];
                            if (model.talk_image != nil) {
                                if (model.talk_image.length > 0) {
                                    model.images = [NSMutableArray array];
                                    NSArray *images = [model.talk_image componentsSeparatedByString:@","];
                                    for (int i = 0; i < images.count; i ++) {
                                        ;
                                        [model.images addObject:[NSString stringWithFormat:@"%@%@",Main_URL,[images objectAtIndex:i]]];
                                    }
                                }
                            }
                            [weak.dataArray addObject:model];
                        }
                        
                        [weak.talkTableView reloadData];
                    }
                    [weak.talkTableView  endNetTable];
                } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                    [weak.talkTableView  endNetTable];
                    [ITTPromptView showMessage:@"数据请求失败"];
                }];
                
            }
        }
    }
}

#pragma  mark  --  点赞

- (void) requestForPariseAtIndex:(NSInteger) index{

    __weak MCTalkListViewController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    MCTalkListModel *model = [_dataArray objectAtIndex:index];
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:model.talk_id ForKey:@"talk_id"];
        
        [[MCTalkManager shareManager]requestTalk_PraiseWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_praise withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                MCTalkListModel *model = [weak.dataArray objectAtIndex:clickIndex];
                model.praise_number = [NSString stringWithFormat:@"%ld",[model.praise_number integerValue] + 1];
                [weak reloadDataAtIndex:clickIndex];
                [ITTPromptView showMessage:@"点赞成功"];
            }else {
                [ITTPromptView showMessage:@"已点赞"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"点赞成失败"];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configHeadView];
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

    isFirst = YES;
    isSeePhoto = NO;
    pageType = 0;
    pagIndex = 1;
    
    _dataArray = [[NSMutableArray alloc]init];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:_titleStr];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"写" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}
/**
 *  设置tableHead
 */
- (void) configHeadView {

    UINib *cellNib = [UINib nibWithNibName:@"MCTalkListCell" bundle:nil];
    [_talkTableView registerNib:cellNib forCellReuseIdentifier:@"MCTalkListCellIdentifier"];
    self.prototypeCell  = [_talkTableView dequeueReusableCellWithIdentifier:@"MCTalkListCellIdentifier"];
    _scrollV = [[QShowImgViewController alloc] initWithNibName:@"QShowImgViewController" bundle:nil];
    
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCTalkListHeaderView" owner:self options:nil]lastObject];
    
    if (self.headModel) {
        [_headView configHeadWithMCTalkMainModel:self.headModel];
    }
    
    float height = 183;
    if (iPhone6) {
        height = 198;
    }else if (iPhone6Plus){
        height = 213;
    }
    _headView.frameheight = height;
    _headView.framewidth = SCREEN_WIDTH;
    _headView.delegate = self;
    _talkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _talkTableView.tableHeaderView = _headView;
    _talkTableView.ittDelegate = self;
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = [self calculateCellHeight:indexPath];
    
    return cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCTalkListCellIdentifier";
    
    MCTalkListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCTalkListCell" owner:self options:nil]lastObject];
    }
    MCTalkListModel *model = (MCTalkListModel *)[_dataArray objectAtIndex:indexPath.row];
    if (model) {
        [cell setCellWithTalkListModel:model AtIndex:indexPath.row];
    }
    cell.delegate = self;
    cell.picV.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MCTalkListModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    MCTalkDetailController *detail = [[MCTalkDetailController alloc]initWithNibName:@"MCTalkDetailController" bundle:nil];
    detail.currentModel = model;
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"%ld",indexPath.row);
    
}


#pragma  mark --  ITTTableViewDelegate

/**
 *  触发时，刷新--- 在执行这个代理方法  请求数据结束之后 需要手动调用endNetTable
 *
 *  @param ittTableView
 */
-(void)pullTableViewDIdTriggerRefresh:(ITTTableView *)ittTableView{

    pagIndex = 1;
    [self requestWithType:pageType andPageIndex:pagIndex];
}

/**
 *  触发时加载更多    请求数据结束之后  需要手动调用 endNetTable
 *
 *  @param ittTableView
 */
-(void)pullTableViewDIdTriggerLoadMore:(ITTTableView *)ittTableView{
    

    [self requestWithType:pageType andPageIndex:pagIndex];
}

#pragma  mark  --  MCTalkListHeaderViewDelegate
//  100最新  101最热
- (void)selectTabAtIndex:(NSInteger)index {


    pagIndex = 1;
    
    switch (index) {
        case 100:
        {
            pageType = 0;
            [self requestWithType:0 andPageIndex:pagIndex];
        }
            break;
        case 101:
        {
            pageType = 1;
            [self requestWithType:1 andPageIndex:pagIndex];
        }
            break;
        default:
            break;
    }
    
    
}
/**
 *  评论 点赞 分享
 */
#pragma  mark  --  MCTalkListCellDelegate
- (void)share_comment_praiseAtIndex:(NSInteger)index {
    NSInteger i = 0;
    NSInteger atIndex = 0;
    NSInteger btnNum = 0;
    
    i = index - 6000;
    atIndex = floorf(i / 3);
    btnNum = i - atIndex * 3;
    
    MCTalkListModel *model = nil;
    model = [self.dataArray objectAtIndex:atIndex];
    clickIndex = atIndex;
    switch (btnNum) {
        case 0:
        {
            //  分享
        }
            break;
        case 1:
        {
            //  评论
        }
            break;
        case 2:
        {
            //  点赞
            [self requestForPariseAtIndex:clickIndex];
        }
            break;
        default:
            break;
    }
    NSLog(@"%ld index -- btn  %ld",atIndex,btnNum);
    
}

#pragma  mark  --  qChoosePicDelegate
/**
 *  浏览图片
 */
- (void)showAllPic:(NSArray *)picArr andImgTag:(NSInteger)index {

    isFirst = NO;
    isSeePhoto = YES;
    NSLog(@"%ld",index);
    self.scrollV.imgArr = picArr;
    self.scrollV.isOne = NO;
    [self.scrollV setUpPageStatusWithIndex:index];
    [self.navigationController presentModalViewController:_scrollV animated:YES];
}

- (void) reloadDataAtIndex:(NSInteger) index {

    __weak MCTalkListViewController *weak = self;
    [self.talkTableView reloadData];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
//    [weak.talkTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    MCTalkListModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    if (model) {
        MCTalkListCell *cell = (MCTalkListCell *)self.prototypeCell;
        CGSize introHeight = [model.content calculateSize:CGSizeMake(cell.contentLab.frame.size.width, FLT_MAX) font:cell.contentLab.font];
        
        if (introHeight.height > 35) {
            cell.contentViewHeight.constant = introHeight.height + 15;
        }
        if ([model.content isEqualToString:@""] || model.content == nil) {
            cell.contentViewHeight.constant = 0;
        }
        int rowNum = ceilf(model.images.count/3.0);
        cell.pickViewHeight.constant = rowNum * PictureWidth + rowNum * 8 ;
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            [cell layoutIfNeeded];
        }];
        
        return cell.headViewHeight.constant + cell.contentViewHeight.constant  + cell.pickViewHeight.constant  + cell.shareViewHeight.constant ;
    } else {
        return 0;
    }
}



/**
 *  rightBtnClick
 */
- (void)rightBarButtonClick:(UIButton *)button {

//    MCTalkPublishController *publish = [[MCTalkPublishController alloc]initWithNibName:@"MCTalkPublishController" bundle:nil];
//    
//    publish.titleStr = self.titleStr;
//    [self.navigationController pushViewController:publish animated:YES];
    isFirst = YES;
    ASCCPersonEditViewController *as = [[ASCCPersonEditViewController alloc]initWithNibName:@"ASCCPersonEditViewController" bundle:nil];
    as.titls = self.titleStr;
    as.bar_id = self.headModel.bar_id;
    [self.navigationController pushViewController:as animated:YES];
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
