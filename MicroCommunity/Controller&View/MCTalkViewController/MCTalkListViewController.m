//
//  MCTalkListViewController.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkListViewController.h"

#import "MCTalkListHeadView.h"
#import "MCTalkListCell.h"
#import "MCTalkListModel.h"
#import "QShowImgViewController.h"
#import "QFriendPicView.h"
#import "MCTalkPublishController.h"
#import "MCTalkDetailController.h"

#import "ASCCPersonEditViewController.h"


@interface MCTalkListViewController ()<UITableViewDataSource,UITableViewDelegate,MCTalkListHeadViewDelegate,MCTalkListCellDelegate,qChoosePicDelegate>

@property (weak, nonatomic) IBOutlet UITableView *talkTableView;
@property (nonatomic, strong) MCTalkListHeadView *headView;
@property (nonatomic, strong) MCTalkListCell *prototypeCell;
@property (nonatomic, strong) QShowImgViewController *scrollV;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MCTalkListViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
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
    
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"MCTalkListHeadView" owner:self options:nil]lastObject];
    
    float height = 180;
    if (iPhone6) {
        height = 212;
    }else if (iPhone6Plus){
        height = 234;
    }
    _headView.frameheight = height;
    _headView.framewidth = SCREEN_WIDTH;
    
    _headView.delegate = self;
    
    
//    [_headView setNeedsUpdateConstraints];
//    [_headView updateConstraintsIfNeeded];
//    [UIView animateWithDuration:0.5 animations:^{
//        [_headView layoutIfNeeded];
//    }];
//    [_headView setNeedsLayout];
//    [_headView layoutIfNeeded];
    _talkTableView.tableHeaderView = _headView;
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

//    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//    MCTalkListCell *cell = (MCTalkListCell *)[_talkTableView cellForRowAtIndexPath:path];
    

    
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
    
    
    MCTalkDetailController *detail = [[MCTalkDetailController alloc]initWithNibName:@"MCTalkDetailController" bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"%ld",indexPath.row);
    
}

#pragma  mark  --  MCTalkListHeadViewDelegate
//  100最新  101最热
- (void)selectTabAtIndex:(NSInteger)index {

    switch (index) {
        case 100:
        {
        
        }
            break;
        case 101:
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
    
    ASCCPersonEditViewController *as = [[ASCCPersonEditViewController alloc]initWithNibName:@"ASCCPersonEditViewController" bundle:nil];
    as.titls = @"失恋";
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
