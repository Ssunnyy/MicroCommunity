//
//  ASCCPersonEditViewController.m
//  aisuo
//
//  Created by adims on 15/3/12.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASCCPersonEditViewController.h"
#import "ITTImagePickView.h"
#import "Mycell.h"

@interface ASCCPersonEditViewController ()<ITTImagePickDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,UITextViewDelegate>

{
    int iMaxIamgeNum;
    BOOL _hasPhoto;
}
@property (nonatomic,strong) NSMutableArray *imageArray;//选择的图片的数组
@property (nonatomic,strong) NSMutableArray *imagePath;

@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;//显示图片的collectionView
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *placehoder;

@property (nonatomic,strong)ITTImagePickView *imagePickerView;//拍照或是选择照片的类的实例

@end

@implementation ASCCPersonEditViewController


- (void)viewWillDisappear:(BOOL)animated {

    [_contentTextView resignFirstResponder];
    
}

- (void)setCircleBorder {

    [_circleView makeCornerRadius:10];
    [_circleView setBorderWidth:1 andBorderColor:[UIColor whiteColor]];
    
    [_contentTextView makeCornerRadius:10];
    [_contentTextView setBorderWidth:1 andBorderColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registMyCell];
    [self setUpData];
    [self setNavigationBarTitle:self.titls];
    [self setNavigationBarStatus];
    [self configHeagView];
    [self setCircleBorder];
    [self configCircleVIewHeight];
    // Do any additional setup after loading the view from its nib.
}

- (void) configCircleVIewHeight{
    
    int num = 1;
    if (iPhone6) {
        num = 5;
    } else if (iPhone6Plus) {
        num = 6;
    } else {
        num = 4;
    }
    NSInteger yu = _imageArray.count % num;
    NSInteger line = _imageArray.count / num;
    if (yu != 0) {
        line = line + 1;
    }
    _circleViewHeight.constant = (line) * 60 + 20;
}

- (void) configHeagView{
    
    iMaxIamgeNum = 10;
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [AppDelegate HideTabBar];
    
    [self setNavigationBarTitle:_titls];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
    [self setButtonStyle:UIButtonStyleRegister andTitle:@"提交" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
}

- (void) registMyCell{

    [self.imageCollectionView registerClass:[Mycell class] forCellWithReuseIdentifier:@"CollectionCell"];
}

- (void) setUpData {

    _imagePath = [[NSMutableArray alloc]init];
    _imageArray = [[NSMutableArray alloc]init];
    [_imageArray addObject:[UIImage imageNamed:@"btn_add3"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addPhoto{
    
    int canSelectNum = 0;
    int imageNum = (int)self.imageArray.count;
    if (imageNum >= iMaxIamgeNum) {
        //弹出提示 不能在添加图片---
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"最多可选%d张图片",iMaxIamgeNum - 1] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterView show];
        return;
    }
    else{
        canSelectNum = iMaxIamgeNum - imageNum;
    }
    if (self.imagePickerView == nil) {
        self.imagePickerView = [[ITTImagePickView alloc]init];
        self.imagePickerView.isUseCutController = NO;
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
        _hasPhoto = NO;
    }
    else
    {
        _hasPhoto = YES;
        //将这里面的对象添加到imageArray数组中
    }
    [self.imageArray removeLastObject];
    for (UIImage *tempImage in picArr) {
        [self.imageArray addObject:tempImage];
    }
    [_imageArray addObject:[UIImage imageNamed:@"btn_add3"]];
    ITTDPRINT(@"选中--picArr = %@,arr.count= %d",picArr,(int)picArr.count);
    [self updatePhotoViewWithHasPhoto:_hasPhoto];
}

/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image
{
    ITTDPRINT(@"拍照 -image=%@",image);
    if (image  == nil) {
        _hasPhoto = NO;
    }
    else
    {
        _hasPhoto = YES;
        [self.imageArray addObject:image];
    }
    
    [self updatePhotoViewWithHasPhoto:_hasPhoto];
    
}
- (void) getImagePath:(NSMutableArray *)paths {
    
    
    [_imagePath addObjectsFromArray:paths];
}

/**
 *  更新photoView的布局设置
 *
 *  @param photo
 */
-(void)updatePhotoViewWithHasPhoto:(BOOL)photo
{
    //需要显示图片
    [_imageCollectionView reloadData];
    [self configCircleVIewHeight];
}

#pragma  mark --  collectionDelegate

#pragma mark---UICollectionViewDelegate && UICollectionViewDataSource
//定义展示的UICollectionViewCell的行数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionCell";
    Mycell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImage *image = [self.imageArray objectAtIndex:(indexPath.section *4 +indexPath.row)];
    if (_imageArray.count - 1 == indexPath.section *4 +indexPath.row) {
        cell.addImageView.hidden = NO;
        cell.addImageView.image = [_imageArray objectAtIndex:indexPath.row];
        cell.addImageView.frame = CGRectMake((cell.framewidth - 30)/2, (cell.frameheight - 30) / 2, 30, 30);
    }else {
        cell.addImageView.hidden = YES;
        [cell updateCellWithImage:image];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_imageArray.count - 1 == indexPath.section *4 +indexPath.row)  {
        [self addPhoto];
    }
    ITTDPRINT(@"indexPath.row = %d section =%d",(int)indexPath.row,(int)indexPath.section);
//    YXScanPhotoViewController *scanVC = [[YXScanPhotoViewController alloc]initWithNibName:@"YXScanPhotoViewController" bundle:nil andImageArray:self.imageArray andSelect:indexPath.row];
//    scanVC.delagate = self;
//    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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

- (void)rightBarButtonClick:(UIButton *)button {

    [_contentTextView resignFirstResponder];
    if (_contentTextView.text.length <= 0 && _imageArray.count <= 0) {
        [ITTPromptView showMessage:@"发布内容不能为空"];
    }
    
    [self publishTalk];
}


- (void) publishTalk {

    MCUserModel *user = (MCUserModel *)[[MCUserManager shareManager]getCurrentUser];
    
    __weak ASCCPersonEditViewController *weak = self;
    
    if (user) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param safeString:self.bar_id ForKey:@"bar_id"];
        [param safeString:user.user_id ForKey:@"user_id"];
        [param safeString:user.nickname ForKey:@"nickname"];
        [param safeString:_contentTextView.text ForKey:@"content"];
        
        
        NSMutableArray *images = [NSMutableArray array];
        
        for (int i = 0 ; i < _imagePath.count ; i ++) {
            NSMutableDictionary *picDic = [NSMutableDictionary dictionary];
            [picDic safeString:[_imagePath objectAtIndex:i] ForKey:@"path"];
            [picDic safeString:[NSString stringWithFormat:@"image%d",i] ForKey:@"image"];
            [images addObject:picDic];
        }
        
        [[MCTalkManager shareManager]requestTalk_PublishWithParamDic:param updateFiles:images withIndicatorView:self.view withCancelRequestID:Talk_Request_Public onRequestFinish:^(MKNetworkOperation *operation) {
            
            if (operation.isSuccees) {
                [ITTPromptView showMessage:@"话题发布成功"];
                [weak.navigationController popViewControllerAnimated:YES];
            }else {
                [ITTPromptView showMessage:@"话题发布失败"];
            }
        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
            [ITTPromptView showMessage:@"话题发布失败"];
        }];
        
//        [[MCTalkManager shareManager] requestTalk_PublishWithParam:param withIndicatorView:self.view withCancelRequestID:Talk_Request_Public withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
//            if (operation.isSuccees) {
//                [ITTPromptView showMessage:@"话题发布成功"];
//                [weak.navigationController popViewControllerAnimated:YES];
//            }
//        } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
//                [ITTPromptView showMessage:@"话题发布失败"];
//        }];
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
