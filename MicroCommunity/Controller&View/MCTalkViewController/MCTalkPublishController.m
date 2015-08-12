//
//  MCTalkPublishController.m
//  MicroCommunity
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCTalkPublishController.h"
#import "ITTImagePickView.h"

@interface MCTalkPublishController ()<UITextViewDelegate,ITTImagePickDelegate>
{

    NSInteger iMaxIamgeNum;
}

@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (weak, nonatomic) IBOutlet UIView *picView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *placehoder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;

@property (nonatomic,strong) ITTImagePickView *imagePickerView;//拍照或是选择照片的类的实例
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation MCTalkPublishController

- (void)awakeFromNib {

    [_bgView makeCornerRadius:10];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    
    [self setNavigationBarStatus];
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
    
    iMaxIamgeNum = 9;
    _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObject:[UIImage imageNamed:@"btn_add3.png"]];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:_titleStr];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"提交" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

#pragma  mark  --  UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {

    _placehoder.hidden = YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {

    if (textView.text.length > 0) {
        _placehoder.hidden = YES;
    }else{
        _placehoder.hidden = NO;
    }
}

- (IBAction)addImage:(UIButton *)sender {
    
    
    
}

- (void)addPhoto{
    
    NSInteger canSelectNum = 0;
    NSInteger imageNum = (NSInteger)self.imageArray.count;
    if (imageNum >= iMaxIamgeNum) {
        //弹出提示 不能在添加图片---
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"最多可选%ld张图片",iMaxIamgeNum - 1] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterView show];
        return;
    }
    else{
        canSelectNum = iMaxIamgeNum - imageNum;
    }
    if (self.imagePickerView == nil) {
        self.imagePickerView = [[ITTImagePickView alloc]init];
        self.imagePickerView.pickDelegate = self;
        
    }
    [self.imagePickerView chooseImageFromAblum:canSelectNum withObject:self];
    
    //100 是照片  101是拍照
    //    ITTDPRINT(@"tapGesture.view.tag= %d",(int)tapGesture.view.tag);
    //    int tag = (int)tapGesture.view.tag;
    //    if (tag == 100) {
    //        ITTDPRINT(@"照片");
    //
    //        这里传几 就是最多选几张图片--- 这个数值应该是动态决定的
    //        [self.imagePickerView chooseImageFromAblum:canSelectNum withObject:self];
    //    }
    //    if (tag == 101) {
    //        ///能能
    //        NSString *mediaType = AVMediaTypeVideo;
    //        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    //        if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
    //            [CommonHelp promptMessage:@"相机权限受限" withCancelStr:nil withConfirmStr:@"确定"];
    //            return;
    //        }
    //        ITTDPRINT(@"拍照");
    //        [self.imagePickerView takePictureWithObject:self];
    //    }
    
}
#pragma mark---ITTImagePickerViewDelegate--
/*!
 @brief 得到选中的图片
 */
- (void)getImageMedia:(NSArray *)picArr
{
    if(picArr.count <=0)
    {
//        _hasPhoto = NO;
    }
    else
    {
//        _hasPhoto = YES;
        //将这里面的对象添加到imageArray数组中
    }
    [self.imageArray removeLastObject];
    for (UIImage *tempImage in picArr) {
        [self.imageArray addObject:tempImage];
    }
    [_imageArray addObject:[UIImage imageNamed:@"btn_add3"]];
    ITTDPRINT(@"选中--picArr = %@,arr.count= %d",picArr,(int)picArr.count);
//    [self updatePhotoViewWithHasPhoto:_hasPhoto];
    
}
/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image
{
    ITTDPRINT(@"拍照 -image=%@",image);
    if (image  == nil) {
//        _hasPhoto = NO;
    }
    else
    {
//        _hasPhoto = YES;
        [self.imageArray addObject:image];
    }
    
//    [self updatePhotoViewWithHasPhoto:_hasPhoto];
    
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
