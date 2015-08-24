//
//  MCTalkDetailController.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkDetailController.h"
#import "MCTalkListCell.h"
#import "QShowImgViewController.h"
#import "MCTalkCommentCell.h"
#import "MCTalkCommentCell.h"
#import "MCSendMessageView.h"
#import "MCTalkReportController.h"


@interface MCTalkDetailController ()<UITableViewDataSource,UITableViewDelegate,MCTalkListCellDelegate,qChoosePicDelegate,MCSendMessageViewDelegate>

{
    NSInteger pageIndex;
    BOOL isFirst ;
}

@property (nonatomic,strong) MCTalkListCell *headView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) QShowImgViewController *scrollV;//    大图浏览
@property (nonatomic, strong) MCTalkCommentCell *prototypeCell;
@property (nonatomic, strong) MCSendMessageView *senderView; //发送view

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCTalkDetailController

- (void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    if (isFirst) {
        [self requesetDetail];
        isFirst = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [_senderView removeKeyboardLison];

}

- (void) requesetDetail {

    __weak MCTalkDetailController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.currentModel.talk_id ForKey:@"talk_id"];
        [[MCTalkManager shareManager] requestTalk_DetailWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_details withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                NSArray *data = [operation.responseJSON objectForKey:@"data_info"];
                if ([data isKindOfClass:[NSArray class]]) {
                    for (int i = 0 ; i < data.count;  i ++) {
                        MCTalkPariseModel *model = [[MCTalkPariseModel alloc]initWithDataDic:[data objectAtIndex:i]];
                        model.comment_head_image = [NSString stringWithFormat:@"%@%@",Main_URL,model.comment_head_image];
                        [weak.dataArray addObject:model];
                    }
                    [weak.detailTableView reloadData];
                }
            }else {
                [ITTPromptView showMessage:@"网络请求失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"网络请求失败"];
        }];
    }
}

#pragma mark -- 点赞
- (void) requestForParise{
    
    __weak MCTalkDetailController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.currentModel.talk_id ForKey:@"talk_id"];
        
        [[MCTalkManager shareManager]requestTalk_PraiseWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_praise withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {

                weak.currentModel.praise_number = [NSString stringWithFormat:@"%ld",[weak.currentModel.praise_number integerValue] + 1];
                [weak.headView updatePraiseCount:weak.currentModel.praise_number];
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
    
    [self configBottomView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpData {

    pageIndex = 1;
    isFirst = YES;
    _dataArray = [[NSMutableArray alloc]init];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"详情"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"举报" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}


- (void) configBottomView {

    _senderView = [[[NSBundle mainBundle] loadNibNamed:@"MCSendMessageView" owner:self options:nil]lastObject];
    _senderView.delegate = self;
    _senderView.framebottom = SCREEN_HEIGHT;
    [self.view addSubview:_senderView];
    
}

- (void) configHeadView{

    UINib *cellNib = [UINib nibWithNibName:@"MCTalkCommentCell" bundle:nil];
    [_detailTableView registerNib:cellNib forCellReuseIdentifier:@"MCTalkCommentCellIdentifier"];
    self.prototypeCell  = [_detailTableView dequeueReusableCellWithIdentifier:@"MCTalkCommentCellIdentifier"];
    
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"MCTalkListCell" owner:self options:nil]lastObject];
    _scrollV = [[QShowImgViewController alloc] initWithNibName:@"QShowImgViewController" bundle:nil];
    
    [_headView setCellWithTalkListModel:self.currentModel AtIndex:0];
    
    _headView.delegate = self;
    _headView.picV.delegate = self;
    _headView.frameheight = [self calculateCellHeight:self.currentModel];
    _detailTableView.tableHeaderView = _headView;
    
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self calculateCellHeightAtIndex:indexPath];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCTalkCommentCellIdentifier";
    MCTalkCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCTalkCommentCell" owner:self options:nil]lastObject];
    }
    
    MCTalkPariseModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    [cell setUpCellWithMCTalkPariseModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    model = self.currentModel;
    
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
            [self requestForParise];
            //  点赞
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
    
    NSLog(@"%ld",index);
    self.scrollV.imgArr = picArr;
    self.scrollV.isOne = NO;
    [self.scrollV setUpPageStatusWithIndex:index];
    [self.navigationController presentModalViewController:_scrollV animated:YES];
}

#pragma  mark  --  MCSendMessageViewDelegate
/**
 *  发送评论
 */
- (void)sendMessage:(NSString *)message {

    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCTalkDetailController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:user.nickname ForKey:@"nickname"];
        [param safeString:self.currentModel.talk_id ForKey:@"talk_id"];
        [param safeString:message ForKey:@"content"];
        
        [[MCTalkManager shareManager] requestTalk_CommentWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_comment withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"评论成功"];
                weak.currentModel.comment_number = [NSString stringWithFormat:@"%ld",[weak.currentModel.comment_number integerValue] + 1];
                [weak.headView updateCommentCount:weak.currentModel.comment_number];
                [weak.senderView cleafData];
            }else {
                [ITTPromptView showMessage:@"评论失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"评论失败"];
        }];
    }
    
}


/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(MCTalkListModel *)model
{
    if (model) {
        MCTalkListCell *cell = (MCTalkListCell *)self.headView;
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
        return 180;
    }
}

/**
 *  计算cell的高度
 */
- (float)calculateCellHeightAtIndex:(NSIndexPath *)indexPath
{
    MCTalkPariseModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    if (model) {
        MCTalkCommentCell *cell = (MCTalkCommentCell *)self.prototypeCell;
        CGSize introHeight = [model.comment_content calculateSize:CGSizeMake(cell.commentLab.frame.size.width, FLT_MAX) font:cell.commentLab.font];
        
        if (introHeight.height > 32) {
            cell.commentHeight.constant = introHeight.height - 10;
        }
        return cell.dataHeight.constant + cell.bottomViewHeight.constant + cell.commentHeight.constant;
    } else {
        return 104;
    }
}

- (void)rightBarButtonClick:(UIButton *)button {

    MCTalkReportController *report = [[MCTalkReportController alloc]initWithNibName:@"MCTalkReportController" bundle:nil];
    report.reportModel = self.currentModel;
    [self.navigationController pushViewController:report animated:YES];
    
    
}

- (void) deleteTalk:(NSString *) talkId {

    __weak MCTalkDetailController *weak = self;
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.currentModel.talk_id ForKey:@"talk_id"];
        
        [[MCTalkManager shareManager]requestTalk_DeleteWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_Delete withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"话题删除成功"];
            } else {
                [ITTPromptView showMessage:@"话题删除失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"话题删除失败"];
        }];
    }
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
