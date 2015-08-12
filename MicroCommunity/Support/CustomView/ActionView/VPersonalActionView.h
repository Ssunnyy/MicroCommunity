//
//  VPersonalActionView.h
//  Mimi
//
//  Created by ligh on 14-6-3.
//
//
//  Sunny repair 自制actionView
#import <UIKit/UIKit.h>

#pragma  mark  --  使用方法

/**
 #pragma  mark  --  VPersonalActionView

 初始化方法
 - (void) setPersonActionView {
     _actionViews = [VPersonalActionView getVPersonalActionView];
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
 */

@protocol VActionViewDelegate <NSObject>

@optional
- (void)blackListOrCancelClick:(NSInteger)tag;
@end

@interface VPersonalActionView : UIView
@property (nonatomic, assign) id<VActionViewDelegate> actionDelegate;
@property (nonatomic, retain) IBOutlet UIView *bgView;
@property (nonatomic, assign) BOOL isFriendCircle;

/**
 *  获取视图
 *
 *  @return VPersonalActionView
 */
+ (VPersonalActionView *) getVPersonalActionView;
/**
 *  设置标题
 *
 *  @param strArr
 */
- (void) setUpBtnTitle:(NSArray *)strArr;
/**
 *  显示视图
 */
- (void) showActionView;
/**
 *  隐藏视图
 */
- (void) hidenActionView;

@end
