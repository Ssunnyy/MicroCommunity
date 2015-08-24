//
//  ITTImagePickView.h
//  iTotemFrame
//
//  Created by qiuyan on 14-10-23.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//


/*！
 
 @brief ------- 引用此类的类要将此类声明为属性,如不-容易过早释放
 
 */

#pragma  mark  --  使用方法
/*
if (self.imagePickerView == nil) {
    self.imagePickerView = [[ITTImagePickView alloc]init];
    self.imagePickerView.imgScale = 12./ 12;
    self.imagePickerView.pickDelegate = self;
}
*/
#import <Foundation/Foundation.h>
#import "ZYQAssetPickerController.h"
#include <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"
#import "CaptureViewController.h"
#import "CropImageViewController.h"


@protocol ITTImagePickDelegate <NSObject>
@optional

/*!
 @brief 得到选中的图片
 */
- (void)getImageMedia:(NSArray *)picArr;


/*!
 @brief 得到拍摄的图片
 */
- (void)getTakePicture:(UIImage *)image;

/*!
 @brief 得到视频的预览图 和 视频数据 和视频时长
 */
- (void)getPreViewVideo:(UIImage *)image andMediaData:(NSData *)videoData andVideoTime:(Float64)videoTime;

/**
 *  得到照片的缩略图
 *
 *  @param thumbImg 缩略图
 */
- (void)getImgThumb:(UIImage *)thumbImg;

/**
 *  得到照片的路径
 *
 *  @param
 */

- (void) getImagePath:(NSMutableArray *) paths;
@end

@interface ITTImagePickView : NSObject<ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CaptureViewDelegate,CropImageViewControllerDelegate>
{
    /**
     *  当前的控制器
     */
    UIViewController *currentViewControl;
}
@property (nonatomic, assign) id<ITTImagePickDelegate> pickDelegate;
@property (nonatomic, assign) float imgScale;

@property (nonatomic, assign) BOOL isUseCutController; // 是不是使用图片裁剪

/*!
 @brief 从相册选择照片
 @param picNum 选择的照片张数
 @param object 由哪个控制器推出ImagePicker
 */
- (void)chooseImageFromAblum:(NSInteger)picNum withObject:(UIViewController *)object;

/*!
 @brief 从相册选择视频
 @param object 由哪个控制器推出ImagePicker
 */
- (void)chooseVideoFromAblumWithObject:(UIViewController *)object;

/*!
 @brief 拍摄视频
 @param object 由哪个控制器推出ImagePicker
 */
- (void)takeVideoWithObject:(UIViewController *)object;

/*!
 @brief 拍摄照片
 @param object 由哪个控制器推出ImagePicker
 */
- (void)takePictureWithObject:(UIViewController *)object;


@end
