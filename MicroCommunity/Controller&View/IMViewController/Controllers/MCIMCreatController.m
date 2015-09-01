//
//  MCIMCreatController.m
//  MicroCommunity
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCIMCreatController.h"
#import "MCIMCreatHeadView.h"

#import "MCCreatTalkGroupController.h"
#import "QRemindLookModel.h"

#import "VPersonalActionView.h"
#import "ITTImagePickView.h"

#import "MCChangeInfoController.h"

@interface MCIMCreatController ()<UITableViewDelegate,UITableViewDataSource,MCIMCreatHeadViewDelegate,VActionViewDelegate,ITTImagePickDelegate,MCChangeInfoControllerDelegate,MCCreatTalkGroupControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *groupTable;
@property (nonatomic, strong) MCIMCreatHeadView *headView;

/**
 *  actionView
 */
@property (nonatomic, strong) VPersonalActionView *actionViews;
/**
 *  拍照或是选择照片的类的实例
 */
@property (nonatomic,strong) ITTImagePickView *imagePickerView;

@end

@implementation MCIMCreatController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    
    [self setPersonActionView];
    
    [self configHeadView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    UINib *cellNib = [UINib nibWithNibName:@"MCIMCreatHeadView" bundle:nil];
    [_groupTable registerNib:cellNib forCellReuseIdentifier:@"MCIMCreatHeadViewIdentifier"];
    self.headView  = [_groupTable dequeueReusableCellWithIdentifier:@"MCIMCreatHeadViewIdentifier"];
    
    
    _groupTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self setNavigationBarTitle:@"创建聊天室"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"完成" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}
/**
 *  headView
 */

- (void) configHeadView {

    
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"MCIMCreatHeadView" owner:self options:nil]lastObject];
    [_headView configCellWith:nil andIsSelf:YES];
    _headView.delegate = self;
    _groupTable.tableHeaderView = _headView;
    _headView.framewidth = SCREEN_WIDTH;
    _headView.frameheight = 573;
    
}

#pragma  mark  --  VPersonalActionView
- (void) setPersonActionView {
    _actionViews = [VPersonalActionView getVPersonalActionView];
    _actionViews.actionDelegate =self;
    NSArray *arr = @[@"从相册中选择",@"拍摄",@"取消"];
    [_actionViews setUpBtnTitle:arr];
}

#pragma  mark  --  UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 573;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"MCIMCreatHeadViewIdentifier";
    MCIMCreatHeadView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCIMCreatHeadView" owner:self options:nil]lastObject];
    }
    [cell configCellWith:nil andIsSelf:YES];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma  mark  --  MCIMCreatHeadViewDelegate

/*
 *  400小组头像 401聊天室名称 402 进入聊天 403删除群组  405 添加好友
 */

- (void)currentBtnClickAtIndex:(NSInteger)index {

    switch (index) {
        case 400:
        {
            [_actionViews showActionView];
        }
            break;
        case 401:
        {
            [self changeGroupName];
        }
            break;
        case 402:
            
            break;
        case 403:
            
            break;
        case 405:
        {
            [self addFriend];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark  --  MCCreatTalkGroupControllerDelegate 

- (void)aite:(NSArray *)aiteArr {

    
    
}

/// 添加好友到群组
- (void) addFriend{

    MCCreatTalkGroupController *creat = [[MCCreatTalkGroupController alloc] initWithNibName:@"MCCreatTalkGroupController" bundle:nil];
    creat.qremindDelegate = self;
    NSMutableArray *array = [NSMutableArray array];

    QRemindLookModel *model1 = [[QRemindLookModel alloc] init];
    model1.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model1.sex = @"1";
    model1.userid = @"1";
    model1.username = @"萌萌";
    model1.isChoose = @"2";

    QRemindLookModel *model2 = [[QRemindLookModel alloc] init];
    model2.headpic = @"http://123.57.248.101/sendwhere/Public/images/26P58PICeEA.jpg";
    model2.sex = @"2";
    model2.userid = @"2";
    model2.username = @"小明";
    model2.isChoose = @"2";

    [array addObject:model1];
    [array addObject:model2];

    creat.exitArr = array;
    [self.navigationController pushViewController:creat animated:YES];
    
}


/// 修改群组昵称

- (void) changeGroupName {

    
    MCChangeInfoController *change = [[MCChangeInfoController alloc]initWithNibName:@"MCChangeInfoController" bundle:nil];
    change.currentTitle = @"聊天室名称";
    change.currenContent = self.headView.talkName.text;
    change.delegate = self;
    [self.navigationController pushViewController:change animated:YES];
    
}


#pragma  mark  --  MCChangeInfoControllerDelegate

- (void)getCurrenContent:(NSString *)content {

    self.headView.talkName.text = content;
}

#pragma  mark  --  VActionViewDelegate
- (void)blackListOrCancelClick:(NSInteger)tag {
    //  移除视图
    [_actionViews hidenActionView];
    //0 是从相册选择  1是拍照
    if (self.imagePickerView == nil) {
        self.imagePickerView = [[ITTImagePickView alloc]init];
        self.imagePickerView.imgScale = 12./ 12;
        self.imagePickerView.pickDelegate = self;
    }
    //100 是照片  101是拍照
    switch (tag) {
        case 100:
        {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied)
            {
                [CommonHelp promptMessage:@"请在iphone的\"设置-隐私-相册\" 选项中,允许访问你的相机" withCancelStr:nil withConfirmStr:@"确定"];
                return;
            }
            
            ITTDPRINT(@"照片");
            //        这里传几 就是最多选几张图片--- 这个数值应该是动态决定的
            [self.imagePickerView chooseImageFromAblum:1 withObject:self];
            [AppDelegate HideTabBar];
        }
            break;
        case 101:
        {
            ITTDPRINT(@"拍照");
            //判断有无调用相机权限
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
                [CommonHelp promptMessage:@"请在iphone的\"设置-隐私-相机\" 选项中,允许访问你的相机" withCancelStr:nil withConfirmStr:@"确定"];
                return;
            }
            [self.imagePickerView takePictureWithObject:self];
            [AppDelegate HideTabBar];
        }
            break;
        default:
            break;
    }
}

#pragma mark---ITTImagePickerViewDelegate--


/*!
 @brief 得到选中的图片
 */
- (void)getImageMedia:(NSArray *)picArr{
    
    [AppDelegate HideTabBar];
    if (picArr.count > 0) {
        UIImage *img = [picArr objectAtIndex:0];
        [self.headView setHeadImage:img];
    }
}


/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image{
    [AppDelegate HideTabBar];
    if (image) {
        [self.headView setHeadImage:image];
    }
}


- (void)rightBarButtonClick:(UIButton *)button {

    [self.navigationController popViewControllerAnimated:YES];
    
}
//- (void)getImgThumb:(UIImage *)thumbImg
//{
//    [AppDelegate HideTabBar];
//    [self.headView setHeadImage:thumbImg];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
