//
//  MCShopPublicController.m
//  MicroCommunity
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCRecruitPublicController.h"

#import "MCProductCityChooseController.h"
#import "RADataObject.h"

@interface MCRecruitPublicController ()<MCProductCityChooseControllerDelegate,UITextFieldDelegate>

{
    NSInteger payType;//    支付类型 0 现金  1金豆
}


@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UITextView *shopDes;
@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (weak, nonatomic) IBOutlet UITextField *shopName;
@property (weak, nonatomic) IBOutlet UITextField *shopPrice;
@property (weak, nonatomic) IBOutlet UITextField *pricePaiMing;
@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UIButton *moneyPay;
@property (weak, nonatomic) IBOutlet UIButton *goldPayBtn;


@property (nonatomic,strong) NSMutableArray *cityArray;

@end

@implementation MCRecruitPublicController



- (void) requestForPublic {
    
    if (_shopName.text.length <= 0) {
        [ITTPromptView showMessage:@"标题不能为空"];
        return;
    }
    if (_shopPrice.text.length <= 0) {
        [ITTPromptView showMessage:@"薪资不能为空"];
        return;
    }
    
    NSString *pay ;
    if (payType == 0) {
        pay = @"现金";
    }else {
        pay = @"金豆";
    }
    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak MCRecruitPublicController *weak = self;
    if (user) {
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:user.user_id ForKey:@"user_id"];
        
        [param safeString:_shopName.text ForKey:@"titile"];
        [param safeString:_shopPrice.text ForKey:@"money"];
        [param safeString:_shopDes.text ForKey:@"content"];
        [param safeString:_pricePaiMing.text ForKey:@"price"];
        [param safeString:pay ForKey:@"pay_type"];
        [param safeString:_address.text ForKey:@"area_name"];
        
        
        [[MCHomeManager shareManager]requestHome_zhaopin_publishWithParam:param withIndicatorView:self.view withCancelRequestID:Home_request_zhaopin_publish withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
           
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"发布成功"];
                [weak.navigationController popViewControllerAnimated:YES];
            }else {
                [ITTPromptView showMessage:@"发布失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"发布失败"];
        }];
        
    }
    
}


- (void)awakeFromNibs {

    
    payType = 0;
    _cityArray = [[NSMutableArray alloc]init];
    [_shopView makeCornerRadius:7];
    [_priceView makeCornerRadius:7];
    [_shopDes makeCornerRadius:7];
    [_addressView makeCornerRadius:7];
    _shopPrice.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignfirst)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self awakeFromNibs];
    
    [self setNavigationBarStatus];
    
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
    
    [self setNavigationBarTitle:@"招聘发布"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"发布" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
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

#pragma mark --

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validateNumber:string];
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    
    [self requestForPublic];
//    [self.navigationController popViewControllerAnimated:YES];
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
