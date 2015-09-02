//
//  MCMyInfoController.m
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyInfoController.h"
#import "ZHPickView.h"
#import "HZAreaPickerView.h"
#import "VPersonalActionView.h"
#import "ITTImagePickView.h"

@interface MCMyInfoController ()<ZHPickViewDelegate,HZAreaPickerDelegate,VActionViewDelegate,ITTImagePickDelegate>
{
    BOOL choosePlace;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *headBgImage;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *cityID;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *hunLab;
@property (weak, nonatomic) IBOutlet UITextField *zhiyeTextField;
@property (weak, nonatomic) IBOutlet UILabel *birthLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *xingZuoLab;
@property (weak, nonatomic) IBOutlet UILabel *xueLiLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *guanJiLab;
@property (weak, nonatomic) IBOutlet UITextField *likeLab;
@property (weak, nonatomic) IBOutlet UITextField *likeBook;
@property (weak, nonatomic) IBOutlet UITextField *likeMove;

@property (nonatomic, strong) NSString *imagePath;

@property (strong, nonatomic) HZAreaPickerView *locatePicker;//城市选择
@property (nonatomic, strong) ZHPickView *pickview;//




/**
 *  actionView
 */
@property (nonatomic, strong) VPersonalActionView *actionViews;
/**
 *  拍照或是选择照片的类的实例
 */
@property (nonatomic,strong) ITTImagePickView *imagePickerView;


/**
 * 性别
 */
- (IBAction)sexBtnClick:(id)sender;
/**
 *  婚姻
 */
- (IBAction)hunBtnClick:(id)sender;
/**
 *  生日
 */
- (IBAction)birthClick:(id)sender;
/**
 *  学历
 */
- (IBAction)xueLiClick:(id)sender;
/**
 *  所在地
 */
- (IBAction)addressClick:(id)sender;
/**
 *  贯籍
 */
- (IBAction)guanJiClick:(id)sender;
/**
 *  兴趣爱好
 */
- (IBAction)likeClick:(id)sender;

@end

@implementation MCMyInfoController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)awakeFromNibs {

    [_headImage makeCircleView];
    
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignfirst)];
    [self.view addGestureRecognizer:tap];
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
    [self setNavigationBarTitle:@"个人信息"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"保存" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}


#pragma  mark  --  VPersonalActionView
- (void) setPersonActionView {
    
    _actionViews = [[[NSBundle mainBundle] loadNibNamed:@"VPersonalActionView" owner:self options:nil] lastObject];
    _actionViews.actionDelegate =self;
    NSArray *arr = @[@"从相册中选择",@"拍摄",@"取消"];
    [_actionViews setUpBtnTitle:arr];
}


#pragma  mark  --  VActionViewDelegate
- (void)blackListOrCancelClick:(NSInteger)tag {
    
    //  移除视图
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
        UIImage *thumbImg = [picArr objectAtIndex:0];
        self.headImage.image = thumbImg;
        self.headBgImage.image = thumbImg;
    }
}


/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image {
    
    if (image) {
        self.headImage.image = image;
        self.headBgImage.image = image;
    }
}
- (void)getImagePath:(NSMutableArray *)paths {
    
    if (paths.count > 0) {
        NSString *thumbImg = [paths objectAtIndex:0];
        _imagePath = thumbImg;
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

#pragma  mark  --  ZHPickViewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {

    switch (pickView.tag) {
            /**
             * 性别
             */
        case 400:
        {
            _sexLab.text = resultString;
        }
            break;
            /**
             *  婚姻
             */
        case 401:
        {
            _hunLab.text = resultString;
        }
            break;
            /**
             *  生日
             */
        case 402:
        {
            NSString *borth = [[resultString componentsSeparatedByString:@" "] objectAtIndex:0];
            
            NSArray *borthYear = [borth componentsSeparatedByString:@"-"];
            
            _birthLab.text = borth;
            
            _xingZuoLab.text = [NSString stringWithFormat:@"%@座",[CommonHelp getAstroWithMonth:[[borthYear objectAtIndex:1] intValue] day:[[borthYear objectAtIndex:2] intValue]]];
            
            NSDate *date = [NSDate dateWithString:borth formate:@"yyyy-mm-dd"];
            
            NSTimeInterval dateDiff = [date timeIntervalSinceNow];
            
            int age=-1 * trunc(dateDiff/(60*60*24))/365;

            if (age >= 0) {
                _ageLab.text = [NSString stringWithFormat:@"%d",age];
            }else{
                _ageLab.text = @"0";
            }
            
            
        }
            break;
            /**
             *  学历
             */
        case 403:
        {
            _xueLiLab.text = resultString;
        }
            break;
        default:
            break;
    }
}

/**
 *  选择城市
 */
- (void)chooseCityBtnClick {
    
    [self.locatePicker showInView:self.view];
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    
    NSString * test = @"";
    NSString * ids = @"";
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        
        test = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        
        ids = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.stateId, picker.locate.cityId, picker.locate.districtId];
        
        if (choosePlace) {
            _addressLab.text = test;
        } else {
            _guanJiLab.text = test;
        }
        
    } else{
        test = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
        ids = [NSString stringWithFormat:@"%@ %@", picker.locate.stateId, picker.locate.cityId];
    }
}


/**
 * 性别
 */
- (IBAction)sexBtnClick:(id)sender {
    
    if (_pickview) {
        [_pickview remove];
    }
    
    NSArray *array=@[@"男",@"女"];
    _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 400;
    _pickview.delegate = self;
    [_pickview show];
}
/**
 *  婚姻
 */
- (IBAction)hunBtnClick:(id)sender{
    if (_pickview) {
        [_pickview remove];
    }
    
    NSArray *array=@[@"未婚",@"已婚"];
    _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 401;
    _pickview.delegate = self;
    [_pickview show];
}
/**
 *  生日
 */
- (IBAction)birthClick:(id)sender{
    if (_pickview) {
        [_pickview remove];
    }
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:0];
    ZHPickView *pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    pickview.tag = 402;
    pickview.delegate = self;
    [pickview show];
}
/**
 *  学历
 */
- (IBAction)xueLiClick:(id)sender{
    if (_pickview) {
        [_pickview remove];
    }
    NSArray *array=@[@"小学",@"初中",@"高中及大专",@"大专",@"本科",@"硕士及以上"];
    _pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _pickview.tag = 403;
    _pickview.delegate = self;
    [_pickview show];
}
/**
 *  所在地
 */
- (IBAction)addressClick:(id)sender{
    choosePlace = YES;
    [self chooseCityBtnClick];
}
/**
 *  贯籍
 */
- (IBAction)guanJiClick:(id)sender{
    choosePlace = NO;
    [self chooseCityBtnClick];
}
/**
 *  兴趣爱好
 */
- (IBAction)likeClick:(id)sender{

}
/**
 *  修改头像
 *
 *  @param sender
 */
- (IBAction)changeHeadBtn:(id)sender {
    
    [self.actionViews showActionView];
}

- (void) resignfirst{
    
    [self.view endEditing:NO];
}

- (void)leftBarButtonClick:(id)sender {

    if (_pickview) {
        [_pickview remove];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
