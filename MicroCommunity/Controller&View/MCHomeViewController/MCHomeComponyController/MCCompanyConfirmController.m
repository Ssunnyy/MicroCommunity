//
//  MCCompanyConfirmController.m
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCCompanyConfirmController.h"
#import "VPersonalActionView.h"
#import "ITTImagePickView.h"

@interface MCCompanyConfirmController ()<VActionViewDelegate,ITTImagePickDelegate>
{
    NSInteger selectType; // 0 企业头像  1身份证  2企业证书
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *textBg1;
@property (weak, nonatomic) IBOutlet UITextView *companyIntro;
@property (weak, nonatomic) IBOutlet UIView *textBg2;
@property (weak, nonatomic) IBOutlet UIView *textBg3;
@property (weak, nonatomic) IBOutlet UIView *textBg4;
@property (weak, nonatomic) IBOutlet UIView *textBg5;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyConnect;
@property (weak, nonatomic) IBOutlet UITextField *companyPhone;
@property (weak, nonatomic) IBOutlet UITextField *companyAddress;
@property (weak, nonatomic) IBOutlet UITextField *idCard;

@property (weak, nonatomic) IBOutlet UIButton *companyCard;
@property (weak, nonatomic) IBOutlet UIButton *idCardBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;


/**
 *  actionView
 */
@property (nonatomic, strong) VPersonalActionView *actionViews;
/**
 *  拍照或是选择照片的类的实例
 */
@property (nonatomic,strong) ITTImagePickView *imagePickerView;
@end

@implementation MCCompanyConfirmController

- (void)awakeFromNibs {

    [_textBg1 makeCornerRadius:7];
    [_textBg2 makeCornerRadius:7];
    [_textBg3 makeCornerRadius:7];
    [_textBg4 makeCornerRadius:7];
    [_textBg5 makeCornerRadius:7];
    [_repairBtn makeCornerRadius:7];
    [_companyIntro makeCornerRadius:7];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
    [self setNavigationBarStatus];
    
    [self setPersonActionView];
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
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:@"商家认证"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
//    [self setButtonStyle:UIButtonStyleRegister andTitle:@"提交认证" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
}

#pragma  mark  --  VPersonalActionView
- (void) setPersonActionView {
    
    _actionViews = [[[NSBundle mainBundle] loadNibNamed:@"VPersonalActionView" owner:self options:nil] lastObject];
    _actionViews.actionDelegate =self;
    NSArray *arr = @[@"从相册中选择",@"拍摄",@"取消"];
    [_actionViews setUpBtnTitle:arr];
    _actionViews.frameheight = SCREEN_HEIGHT;
    _actionViews.frametop = SCREEN_HEIGHT;
}


#pragma  mark  --  VActionViewDelegate
- (void)blackListOrCancelClick:(NSInteger)tag {
    
    [_actionViews hidenActionView];
    
    //0 是从相册选择  1是拍照
    if (self.imagePickerView == nil) {
        self.imagePickerView = [[ITTImagePickView alloc]init];
        self.imagePickerView.imgScale = 12./10;
        self.imagePickerView.pickDelegate = self;
    }
    //100 是照片  101是拍照
    switch (tag) {
        case 100:
        {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied)
            {
                [CommonHelp promptMessage:@"请在iphone的\"设置-隐私-相册\" 选项中,允许爱锁访问你的相机" withCancelStr:nil withConfirmStr:@"确定"];
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
                [CommonHelp promptMessage:@"请在iphone的\"设置-隐私-相机\" 选项中,允许爱锁访问你的相机" withCancelStr:nil withConfirmStr:@"确定"];
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
        UIImage *thumbImg = [picArr objectAtIndex:0];
        switch (selectType) {
            case 0:
                self.headImage.image = thumbImg;
                break;
            case 1:
                [_idCardBtn setImage:thumbImg forState:UIControlStateNormal];
                break;
            case 2:
                [_companyCard setImage:thumbImg forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}


/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image {

    switch (selectType) {
        case 0:
            self.headImage.image = image;
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}



//  修改头像
- (IBAction)changeHeadImage:(id)sender {
    
    selectType = 0;
    [_actionViews showActionView];
}

//  100营业执照 101身份证
- (IBAction)idCardUpdate:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            selectType = 2;
        }
            break;
        case 101:
        {
            selectType = 1;
        }
            break;
        default:
            break;
    }
    [_actionViews showActionView];
}
//  地址选择
- (IBAction)addressChoose:(UIButton *)sender {
}


- (IBAction)changeInfo:(id)sender {
    
    
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
