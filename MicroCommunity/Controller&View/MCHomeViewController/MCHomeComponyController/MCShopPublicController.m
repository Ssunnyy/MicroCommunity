//
//  MCShopPublicController.m
//  MicroCommunity
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCShopPublicController.h"

#import "VPersonalActionView.h"
#import "ITTImagePickView.h"

#import "MCProductCityChooseController.h"
#import "RADataObject.h"

@interface MCShopPublicController ()<ITTImagePickDelegate,VActionViewDelegate,MCProductCityChooseControllerDelegate>

{
    NSInteger payType;//    支付类型 0 现金  1金豆
}

@property (weak, nonatomic) IBOutlet UIView *addHeadImageView;

@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UITextView *shopDes;
@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *shopName;
@property (weak, nonatomic) IBOutlet UITextField *shopPrice;
@property (weak, nonatomic) IBOutlet UITextField *pricePaiMing;
@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UIButton *moneyPay;
@property (weak, nonatomic) IBOutlet UIButton *goldPayBtn;
/**
 *  actionView
 */
@property (nonatomic, strong) VPersonalActionView *actionViews;
/**
 *  拍照或是选择照片的类的实例
 */
@property (nonatomic,strong) ITTImagePickView *imagePickerView;

@property (nonatomic,strong) NSMutableArray *cityArray;

@end

@implementation MCShopPublicController

- (void)awakeFromNibs {

    _cityArray = [[NSMutableArray alloc]init];
    [_shopView makeCornerRadius:7];
    [_priceView makeCornerRadius:7];
    [_shopDes makeCornerRadius:7];
    [_addressView makeCornerRadius:7];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self enableKeyboardManger];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [self disableKeyboardManager];
    
}

- (void) publicShoping {
    
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    if (user) {
        
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:self.seller_id ForKey:@"seller_id"];
        [param safeString:_shopName.text ForKey:@"goods_name"];
        [param safeString:_shopPrice.text ForKey:@"goods_price"];
        [param safeString:_shopDes.text ForKey:@"goods_message"];
        [param safeString:_pricePaiMing.text ForKey:@"goods_money"];
        [param safeString:@"" ForKey:@"pay_type"];
        [param safeString:@"" ForKey:@"city_id"];
        [param safeString:@"" ForKey:@"province_id"];
        [param safeString:@"" ForKey:@"logo"];
        
        [[MCHomeManager shareManager]requestHome_goods_publishWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_goods_publish withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
            
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            
        }];
    }
    
    
    
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
    
    [self setNavigationBarTitle:@"商品发布"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"发布" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
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
        self.headImage.image = thumbImg;

    }
}


/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image {
    
    if (image) {
        self.headImage.image = image;
    }
}


#pragma  mark  --  MCProductCityChooseControllerDelegate
- (void)chooseCitys:(NSArray *)citys {

    
    [_cityArray removeAllObjects];
    [_cityArray addObjectsFromArray:citys];
    NSMutableString *city = [NSMutableString string];
    for (RADataObject *data in citys) {
        [city appendFormat:@"%@,",data.name];
    }
    
    _address.text = city;
}

/**
 *  增加排名
 */
- (IBAction)upOrMinusPrice:(UIButton *)sender {
    
    NSInteger value = [_pricePaiMing.text integerValue];
    
    switch (sender.tag) {
        case 100:
        {
            if (value == 0) {
                value = 0;
            }else {
                value -- ;
            }
        }
            break;
        case 101:
        {
            value ++;
        }
        default:
            break;
    }
    _pricePaiMing.text = [NSString stringWithFormat:@"%ld",value];
}

/**
 *  支付类型
 */
- (IBAction)choosePayType:(UIButton *)sender {
    
    switch (sender.tag) {
        case 200:
        {
            _moneyPay.selected = YES;
            _goldPayBtn.selected = NO;
            payType = 0;
        }
            break;
        case 201:
        {
            _moneyPay.selected = NO;
            _goldPayBtn.selected = YES;
            payType = 1;
        }
            break;
        default:
            break;
    }
}

/**
 *  产品图片
 */
- (IBAction)addShopHeadImage:(id)sender {
    
    [_actionViews showActionView];
}
/**
 *  选择地址
 */
- (IBAction)chooseAddress:(id)sender {
    MCProductCityChooseController *city = [[MCProductCityChooseController alloc]initWithNibName:@"MCProductCityChooseController" bundle:nil];
    city.delegate = self;
    [self.navigationController pushViewController:city animated:YES];
}
/**
 *  充值
 */
- (IBAction)alipay:(id)sender {
    
    
}
/**
 *  发布
 */
- (void)rightBarButtonClick:(UIButton *)button {

    [self publicShoping];
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
