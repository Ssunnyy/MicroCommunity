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

@property (nonatomic,strong) MCTalkListCell *headView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) QShowImgViewController *scrollV;//    大图浏览
@property (nonatomic, strong) MCTalkCommentCell *prototypeCell;
@property (nonatomic, strong) MCSendMessageView *senderView; //发送view

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCTalkDetailController

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [_senderView removeKeyboardLison];
    
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

    
    MCTalkPariseModel *parise = [[MCTalkPariseModel alloc]init];
    parise.comment = @"睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf";;
    [_dataArray addObject:parise];
    
    
    MCTalkListModel *model = [[MCTalkListModel alloc]init];
    model.content = @"睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf睡觉啊烦阿姐发疯afjasfja;jfaafajf;ajflajd;lfja;ldjf;lamdflamdljfaljdfajjadjf;lakjd;lfjajfl;aj;lf";
    model.images = [NSMutableArray array];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    [model.images addObject:@"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg"];
    
    [_headView setCellWithTalkListModel:model AtIndex:0];
    
    _headView.delegate = self;
    _headView.picV.delegate = self;
    _headView.frameheight = [self calculateCellHeight:model];
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
    model = self.model;
    
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
        CGSize introHeight = [model.comment calculateSize:CGSizeMake(cell.commentLab.frame.size.width, FLT_MAX) font:cell.commentLab.font];
        
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
    report.reportId = @"";
    [self.navigationController pushViewController:report animated:YES];
    
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
