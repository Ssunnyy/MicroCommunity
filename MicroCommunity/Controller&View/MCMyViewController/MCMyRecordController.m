//
//  MCMyRecordController.m
//  MicroCommunity
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCMyRecordController.h"
#import "ZBarSDK.h"

//设备宽/高/坐标
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceFrame [UIScreen mainScreen].bounds

static const float kLineMinY = 185;
static const float kLineMaxY = 385;
static const float kReaderViewWidth = 200;
static const float kReaderViewHeight = 200;

@interface MCMyRecordController ()<ZBarReaderViewDelegate>

{
    ZBarReaderView *readerView;
}

@property (nonatomic, strong) UIImageView *line;//交互线
@property (nonatomic, strong) NSTimer *lineTimer;//交互线控制

@end

@implementation MCMyRecordController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    [AppDelegate HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStatus];
    
    [self initUI];
    
    [self setOverlayPickerView];
    
    [self startSYQRCodeReading];
    
    [self.view bringSubviewToFront:self.navigationBarView];
    
    // Do any additional setup after loading the view from its nib.
}
/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:@"扫一扫"];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}

- (void)initUI
{
    if (readerView == nil)
    {
        readerView = [[ZBarReaderView alloc] init];
        readerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
        readerView.readerDelegate = self;
        
        //关闭闪光灯
        readerView.torchMode = 0;
        [self.view addSubview:readerView];
    }
}
- (CGRect)getReaderViewBoundsWithSize:(CGSize)asize
{
    return CGRectMake(kLineMinY / readerView.frame.size.height, (abs(readerView.frame.size.width - asize.width) / 2.0) / readerView.frame.size.width, asize.height / readerView.frame.size.height, asize.width / readerView.frame.size.width);
}

- (void)readerView:(ZBarReaderView *)areaderView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for(symbol in symbols)
        break;
    
    NSLog(@"--- qrcode result: %@",symbol.data);
    
    //判断是否包含 头'http:'
    
    NSString *qrText = symbol.data ;
    
    if (qrText && ![qrText isEqualToString:@""] && qrText.length > 0)
    {
        
        [ITTPromptView showMessage:qrText];
//        if ([qrText containsString:@"http"])
//        {
////            if (self.SYQRCodeSuncessBlock) {
////                self.SYQRCodeSuncessBlock(self,qrText);
////            }
//        }
//        else
//        {
////            if (self.SYQRCodeFailBlock) {
////                self.SYQRCodeFailBlock(self);
////            }
//        }
//    }
//    else
//    {
////        if (self.SYQRCodeFailBlock) {
////            self.SYQRCodeFailBlock(self);
////        }
    }
    
    [areaderView stop];
}

- (void)setOverlayPickerView
{
    //画中间的基准线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - 300) / 2.0, kLineMinY, 300, 12 * 300 / 320.0)];
    [_line setImage:[UIImage imageNamed:@"QRCodeLine"]];
    [self.view addSubview:_line];
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kLineMinY)];//80
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMinY, (kDeviceWidth - kReaderViewWidth) / 2.0, kReaderViewHeight)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth - CGRectGetMaxX(leftView.frame), kLineMinY, CGRectGetMaxX(leftView.frame), kReaderViewHeight)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    CGFloat space_h = KDeviceHeight - kLineMaxY;
    
    //底部view
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMaxY, kDeviceWidth, space_h)];
    downView.alpha = 0.3;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    //四个边角
    UIImage *cornerImage = [UIImage imageNamed:@"QRCodeTopLeft"];
    
    //左侧的view
    UIImageView *leftView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    leftView_image.image = cornerImage;
    [self.view addSubview:leftView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodeTopRight"];
    
    //右侧的view
    UIImageView *rightView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    rightView_image.image = cornerImage;
    [self.view addSubview:rightView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomLeft"];
    
    //底部view
    UIImageView *downView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downView_image.image = cornerImage;
    //downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomRight"];
    
    UIImageView *downViewRight_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downViewRight_image.image = cornerImage;
    //downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downViewRight_image];
    
    //说明label
    UILabel *labIntroudction = [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMinY(downView.frame) + 25, kReaderViewWidth, 20);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont boldSystemFontOfSize:13.0];
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.text = @"将二维码置于框内,即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    UIView *scanCropView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - 1,kLineMinY,self.view.frame.size.width - 2 * CGRectGetMaxX(leftView.frame) + 2, kReaderViewHeight + 2)];
    scanCropView.layer.borderColor = [UIColor greenColor].CGColor;
    scanCropView.layer.borderWidth = 2.0;
    [self.view addSubview:scanCropView];
    
    //扫描区域计算
    readerView.scanCrop = CGRectMake(kLineMinY / readerView.bounds.size.height, (CGRectGetMinX(scanCropView.frame) + 25) / readerView.bounds.size.width, scanCropView.frame.size.height / readerView.bounds.size.height, (scanCropView.frame.size.width - 50) / readerView.bounds.size.width);
//    readerView.scanCrop = CGRectMake(kLineMinY / readerView.bounds.size.height, scanCropView.frametop,scanCropView.frame.size.height / readerView.bounds.size.height,scanCropView.frameheight);
    
}


#pragma mark -
#pragma mark 交互事件
//  开始扫描
- (void)startSYQRCodeReading
{
    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 20 target:self selector:@selector(animationLine) userInfo:nil repeats:YES];
    
    [readerView start];
    
    NSLog(@"start reading");
}
//取消扫描
- (void)stopSYQRCodeReading
{
    if (_lineTimer)
    {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    
    [readerView stop];
    
    NSLog(@"stop reading");
}




#pragma mark -
#pragma mark 上下滚动交互线

- (void)animationLine
{
    __block CGRect frame = _line.frame;
    
    static BOOL flag = YES;
    
    if (flag)
    {
        frame.origin.y = kLineMinY;
        flag = NO;
        
        [UIView animateWithDuration:1.0 / 20 animations:^{
            
            frame.origin.y += 5;
            _line.frame = frame;
            
        } completion:nil];
    }
    else
    {
        if (_line.frame.origin.y >= kLineMinY)
        {
            if (_line.frame.origin.y >= kLineMaxY - 12)
            {
                frame.origin.y = kLineMinY;
                _line.frame = frame;
                
                flag = YES;
            }
            else
            {
                [UIView animateWithDuration:1.0 / 20 animations:^{
                    
                    frame.origin.y += 5;
                    _line.frame = frame;
                    
                } completion:nil];
            }
        }
        else
        {
            flag = !flag;
        }
    }
    
    //NSLog(@"_line.frame.origin.y==%f",_line.frame.origin.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//显示提示信息
- (void)showAlertWithMsg:(NSString *)amsg
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    UIAlertView *alerV = [[UIAlertView alloc] initWithTitle:nil message:amsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerV show];
#else
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:nil message:amsg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actCancle = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alerVC addAction:actCancle];
    [self presentViewController:alerVC animated:YES completion:nil];
#endif
}


- (void)leftBarButtonClick:(id)sender {
    [self stopSYQRCodeReading];
    [self.navigationController popViewControllerAnimated:YES];
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
