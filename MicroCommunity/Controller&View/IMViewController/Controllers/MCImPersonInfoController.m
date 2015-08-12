//
//  MCImPersonInfoController.m
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCImPersonInfoController.h"
#import "MCImPersonHeadView.h"
#import "MCImGroupRoomCell.h"
#import "MCIMFriendBottomView.h"
#import "QShowImgViewController.h"
#import "MCTalkListCell.h"

@interface MCImPersonInfoController ()<UITableViewDataSource,UITableViewDelegate,MCIMFriendBottomViewDelegate,MCTalkListCellDelegate,qChoosePicDelegate>
{
    BOOL isFriend;
}

@property (weak, nonatomic) IBOutlet UITableView *personTableView;
@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (nonatomic, strong) MCImPersonHeadView *headView ;
@property (nonatomic, strong) MCIMFriendBottomView *bottomView;
@property (nonatomic, strong) QShowImgViewController *scrollV;
@property (nonatomic, strong) MCTalkListCell *talkCell;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCImPersonInfoController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFriend = YES;
    
    [self setUpData];
    
    [self setNavigationBarStatus];
    
    [self configHeadView];
    
    [self configFootView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化数据
 */
/**
 *  初始化数据
 */
- (void) setUpData {
    
    _dataArray = [[NSMutableArray alloc]init];
    
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
    [_dataArray addObject:model];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    
    [self setNavigationBarTitle:self.titleName];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}
/**
 *  configHeadView
 */

- (void) configHeadView {
    
    _scrollV = [[QShowImgViewController alloc] initWithNibName:@"QShowImgViewController" bundle:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"MCTalkListCell" bundle:nil];
    [_personTableView registerNib:cellNib forCellReuseIdentifier:@"MCTalkListCellIdentifier"];
    self.talkCell  = [_personTableView dequeueReusableCellWithIdentifier:@"MCTalkListCellIdentifier"];

    _personTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCImPersonHeadView" owner:self options:nil]lastObject];
    _personTableView.tableHeaderView = _headView;
}

- (void) configFootView {

    _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"MCIMFriendBottomView" owner:nil options:nil]lastObject];
    _bottomView.delegate = self;
    if (isFriend) {
        [_bottomView changeToTwoBtn];
    }
    _bottomView.frameheight = 64;
    _bottomView.framewidth = SCREEN_WIDTH;
    [self.bottom addSubview:_bottomView];
}

#pragma  mark  --  UITableViewDelegate

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFriend) {
        return _dataArray.count;
    } else {
        return 0;
    }
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    lab.text = @"非好友没有动态内容";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor grayColor];

    return lab;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (isFriend) {
        return 0;
    }else {
        return 100;
    }
}
#pragma  mark  --  MCIMFriendBottomViewDelegate

- (void)clickAtIndex:(NSInteger)index {

    switch (index) {
        case 300:
        {
            if (isFriend) {
                    //  清楚历史记录
            }else {
                    //  对话
            }
        }
            break;
        case 301:
        {
            if (isFriend) {
                //  删除好友
            }else {
                //  申请好友
                [ITTPromptView showMessage:@"好友申请提交成功"];
            }
            
        }
            break;
        case 302:
        {
            
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

/**
 *  计算cell的高度
 */
- (float)calculateCellHeight:(NSIndexPath*)indexPath
{
    MCTalkListModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    if (model) {
        MCTalkListCell *cell = (MCTalkListCell *)self.talkCell;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
