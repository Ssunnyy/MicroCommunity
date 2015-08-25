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
@property (weak, nonatomic) IBOutlet UIButton *addHeadBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyConnect;
@property (weak, nonatomic) IBOutlet UITextField *companyPhone;
@property (weak, nonatomic) IBOutlet UITextField *companyAddress;
@property (weak, nonatomic) IBOutlet UITextField *idCard;

@property (weak, nonatomic) IBOutlet UIButton *companyCard;
@property (weak, nonatomic) IBOutlet UIButton *idCardBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (strong, nonatomic) NSString *headPath;// 头像
@property (nonatomic, strong) NSString *idPath;//   身份证
@property (nonatomic, strong) NSString *companyPath;//  企业执照

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
    [self enableKeyboardManger];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [self disableKeyboardManager];
    
}

- (void) requestForConfirm{
    
    if (_companyName.text.length <= 0) {
        [ITTPromptView showMessage:@"商家名称不能为空"];
        return;
    }
    if (_companyIntro.text.length <= 0) {
        [ITTPromptView showMessage:@"企业介绍不能为空"];
        return;
    }
    if (_companyConnect.text.length <= 0) {
        [ITTPromptView showMessage:@"联系人不能为空"];
        return;
    }
    if (![CommonHelp isvalidateMobile:self.companyPhone.text]) {
        [ITTPromptView showMessage:@"请输入正确的手机号码!"];
        return;
    }
    if (_companyAddress.text.length <= 0) {
        [ITTPromptView showMessage:@"地址不能为空"];
        return;
    }
    if (_idCard.text.length <= 0) {
        [ITTPromptView showMessage:@"身份证号不能为空"];
        return;
    }
    if ([CommonHelp checkUserIdCard:_idCard.text]) {
        [ITTPromptView showMessage:@"请输入正确的手机号码"];
    }
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCCompanyConfirmController *weak = self;
    if (user) {
        
        NSString *lon = [USER_DEFAULT objectForKey:MMLastLongitude];
        NSString *lat = [USER_DEFAULT objectForKey:MMLastLatitude];
        
        NSString *address = [USER_DEFAULT objectForKey:MMLastAddress];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:user.phone ForKey:@"phone"];
        [param safeString:_companyName.text ForKey:@"seller_name"];
        [param safeString:_companyIntro.text ForKey:@"seller_content"];
        [param safeString:_companyConnect.text ForKey:@"linkman"];
        [param safeString:_companyPhone.text ForKey:@"linkphone"];
        [param safeString:address ForKey:@"address"];
        [param safeString:lon ForKey:@"a_lng"];
        [param safeString:lat ForKey:@"a_lat"];
        [param safeString:_idCard.text ForKey:@"id_card"];
        
        NSMutableArray *images = [NSMutableArray array];
        
        NSMutableDictionary *picDic = [NSMutableDictionary dictionary];
        NSMutableDictionary *picDic1 = [NSMutableDictionary dictionary];
        NSMutableDictionary *picDic2 = [NSMutableDictionary dictionary];
        
        if (self.headPath != nil) {
            [picDic safeString:self.headPath ForKey:@"path"];
            [picDic safeString:@"seller_image" ForKey:@"image"];
            [images addObject:picDic];
        } else{
            [param safeString:@"" ForKey:@"seller_image"];
        }
        
        if (self.headPath != nil) {
            [picDic1 safeString:self.idPath ForKey:@"path"];
            [picDic1 safeString:@"idcard_script" ForKey:@"image"];
            [images addObject:picDic1];
        }else {
            [param safeString:@"" ForKey:@"idcard_script"];
        }
        
        if (self.headPath != nil) {
            [picDic2 safeString:self.companyPath ForKey:@"path"];
            [picDic2 safeString:@"business_card" ForKey:@"image"];
            [images addObject:picDic2];
        }else {
            [param safeString:@"" ForKey:@"business_card"];
        }
        
        if (_isConfirm) {
            //  商家认证
            
            [[MCHomeManager shareManager] requestHome_seller_publishWithParamDic:param updateFiles:images withIndicatorView:self.view withCancelRequestID:Home_request_seller_publish onRequestFinish:^(MKNetworkOperation *operation) {
                if (operation.isSuccees) {
                    [ITTPromptView showMessage:@"提交认证成功"];
                    [weak.navigationController popViewControllerAnimated:YES];
                }else {
                    [ITTPromptView showMessage:@"提交认证失败,请重新提交"];
                }

            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"提交认证失败,请重新提交"];
            }];
            
//            [[MCHomeManager shareManager]requestHome_seller_publishWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_seller_publish withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
//                
//                if (operation.isSuccees) {
//                    [ITTPromptView showMessage:@"提交认证成功"];
//                    [weak.navigationController popViewControllerAnimated:YES];
//                }else {
//                    [ITTPromptView showMessage:@"提交认证失败,请重新提交"];
//                }
//            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
//                [ITTPromptView showMessage:@"提交认证失败,请重新提交"];
//            }];
        }else {
            //  修改商家信息
            [[MCHomeManager shareManager]requestHome_update_sellerWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_update_seller withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    [ITTPromptView showMessage:@"修改成功成功"];
                    [weak.navigationController popViewControllerAnimated:YES];
                }else {
                    [ITTPromptView showMessage:@"修改失败,请重新提交"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"修改失败,请重新提交"];
            }];
            
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
    [self setNavigationBarStatus];
    
    [self setPersonActionView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignfirst)];
    [self.view addGestureRecognizer:tap];
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
    
    if (_isConfirm) {
        [self setNavigationBarTitle:@"商家认证"];
    } else {
        [self setNavigationBarTitle:@"编辑企业资料"];
    }
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
            {
                self.headImage.image = thumbImg;
                
                [_addHeadBtn setImage:ImageNamed(@"") forState:UIControlStateNormal];
            }
                
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
            [_idCardBtn setImage:image forState:UIControlStateNormal];
            break;
        case 2:
             [_companyCard setImage:image forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
- (void)getImagePath:(NSMutableArray *)paths {

    if (paths.count > 0) {
        NSString *thumbImg = [paths objectAtIndex:0];
        switch (selectType) {
            case 0:
            {
                self.headPath = thumbImg;
            }
                break;
            case 1:
                self.idPath = thumbImg;
                break;
            case 2:
                self.companyPath = thumbImg;
                break;
            default:
                break;
        }
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
    
    [self requestForConfirm];
}

- (void) resignfirst{

    [self.view endEditing:NO];
    
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
