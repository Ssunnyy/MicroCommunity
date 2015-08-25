//
//  ITTImagePickView.m
//  iTotemFrame
//
//  Created by qiuyan on 14-10-23.
//  Copyright (c) 2014年 qiuyan. All rights reserved.
//

#import "ITTImagePickView.h"


@implementation ITTImagePickView

/*!
 @brief 从相册选择照片
 */

- (void)chooseImageFromAblum:(NSInteger)picNum withObject:(UIViewController *)object
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = picNum;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    currentViewControl = object;
    [object presentViewController:picker animated:YES completion:nil];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSMutableArray *tempArr = [NSMutableArray array];
    //  图片路径
    NSMutableArray *tempImagePath = [NSMutableArray array];
    
    for (int i = 0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        [tempArr addObject:tempImg];
        
        NSData *data = UIImagePNGRepresentation(tempImg);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [NSString stringWithFormat:@"%@/%@",[paths objectAtIndex:0],[NSString stringWithFormat:@"images%d.png",i]];
        
        [data writeToFile:cachesDir atomically:YES];
        // UIImage *iamge=[UIImage imageWithData:data];
        [tempImagePath addObject:cachesDir];
    }
    
    if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getImageMedia:)]) {
        [_pickDelegate getImageMedia:tempArr];
    }
    
    if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getImagePath:)]) {
        [_pickDelegate getImagePath:tempImagePath];
    }
    
    if (_isUseCutController) {
        if (tempArr.count > 0) {
            CaptureViewController *captureVC = [[CaptureViewController alloc] initWithNibName:@"CaptureViewController" bundle:nil];
            captureVC.image = [tempArr objectAtIndex:0];
            captureVC.isTakePic = YES;
            captureVC.delegate = self;
            captureVC.scale = _imgScale;
            [currentViewControl.navigationController pushViewController:captureVC animated:NO];
        }
    }
}

/*!
 @brief 从相册选择视频
 */
- (void)chooseVideoFromAblumWithObject:(UIViewController *)object
{
    [self chooseVideoOrtakeVideo:YES andisTake:NO andObject:object];
}

/*!
 @brief 拍摄视频
 */
- (void)takeVideoWithObject:(UIViewController *)object
{
    [self chooseVideoOrtakeVideo:NO andisTake:NO andObject:object];
}

/*!
 @brief 拍摄照片
 */
- (void)takePictureWithObject:(UIViewController *)object
{
    [self chooseVideoOrtakeVideo:NO andisTake:YES andObject:object];
    currentViewControl = object;
}

//拍照片或者从相册选择照片 ischoose 是否是从相册选择  istake 是否是拍摄照片
- (void)chooseVideoOrtakeVideo:(BOOL)isChoose andisTake:(BOOL)istake  andObject:(UIViewController *)controller
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    picker.videoMaximumDuration = 20;
	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum ])
	{
        NSArray *arrMediaTypes;
        if (!isChoose) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        if (istake) {//拍照片
            NSString *requirdType = (NSString *)kUTTypeImage;
            arrMediaTypes=[NSArray arrayWithObjects:requirdType,nil];
        }else{//拍视频 或从 相册选视频
            NSString *requirdType = (NSString *)kUTTypeMovie;
            arrMediaTypes=[NSArray arrayWithObjects:requirdType,nil];
        }
        picker.mediaTypes = arrMediaTypes;
        [self performSelector:@selector(takePicImagePicker:) withObject:picker afterDelay:.2f];
    }
}

- (void)takePicImagePicker:(UIImagePickerController *)picker
{
    [currentViewControl presentViewController:picker animated:YES completion:^{}];
}

#pragma mark -- UIImagePickerController回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (!picker) {
        return;
    }
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
	{
        //视频地址
		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        
        //视频时长
        AVAsset *avAsset = [AVAsset assetWithURL:url];
        CMTime assetTime = [avAsset duration];
        Float64 duration = CMTimeGetSeconds(assetTime);
        
        CGFloat f = [self getFileSize:[url path]];
        if (f / 1024 > 150) {
//            [ITTCustomAlertView showMessage:@"视频文件太大，请重新选择"];
            return;
        } else {
            [self getVideoMessage:duration andVideoUrl:url];
            [picker dismissViewControllerAnimated:YES completion:^{}];
        }
	}else if([mediaType isEqualToString:@"public.image"]){
        [picker dismissViewControllerAnimated:NO completion:^{}];

        //获取照片实例
		UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        image = [self compressImage:image];
        //保存到相册
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:nil];
        if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getTakePicture:)]) {
            [_pickDelegate getTakePicture:image];
        }
        
        // 裁剪
        if (_isUseCutController) {
            [self performSelector:@selector(thumbImgVcInit:) withObject:image afterDelay:0.3f];
        }
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)thumbImgVcInit:(UIImage *)image
{
    CaptureViewController *captureVC = [[CaptureViewController alloc] initWithNibName:@"CaptureViewController" bundle:nil];
    captureVC.image = image;
    captureVC.isTakePic = NO;
    captureVC.delegate = self;
    captureVC.scale = _imgScale;
    [currentViewControl.navigationController presentViewController:captureVC animated:NO completion:nil];
    
//    
//    CropImageViewController *controller = [[CropImageViewController alloc] init];
////    [controller.navigationItem setHidesBackButton:YES];
//    [controller setDelegate:self];
//    [controller setCropImage:image];
//    [controller setCropSize:CGSizeMake(SCREEN_WIDTH, 200)];
////    [controller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
//    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2.png"] forBarMetrics:UIBarMetricsDefault];
//    [currentViewControl presentViewController:navController animated:YES completion:^{}];
////
////    [currentViewControl presentViewController:controller animated:YES completion:^{}];
}


#pragma mark -- capture img delegate

- (void)CropImageViewControllerDidCropSuccessfully:(UIImage*)image
{
    if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getImgThumb:)]) {
        [_pickDelegate getImgThumb:image];
    }

    
//    [imageView setImage:image];
}

- (void)getThumbImg:(UIImage *)img
{
    if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getImgThumb:)]) {
        [_pickDelegate getImgThumb:img];
    }
}

//视频的预览图 时长 视频数据
- (void)getVideoMessage:(Float64)videoTime andVideoUrl:(NSURL *)url
{
    //得到预览图
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
   
//   将mov格式的视频转换成MP4
    __block NSData *videoData;
    AVURLAsset *mediaAsset = [AVAsset assetWithURL:url];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:mediaAsset
                                                                           presetName:AVAssetExportPresetMediumQuality];
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/outputAlbum.mp4"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
    }
    exportSession.outputURL = [NSURL fileURLWithPath:path];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusFailed:
            case AVAssetExportSessionStatusCancelled:
            {
                break;
            }

            case AVAssetExportSessionStatusCompleted:
            {
                NSFileManager *manager = [NSFileManager defaultManager];
                videoData = [manager contentsAtPath:path];
                
                if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(getPreViewVideo:andMediaData:andVideoTime:)]) {
                    [_pickDelegate getPreViewVideo:img andMediaData:videoData andVideoTime:videoTime];
                }

            }
                break;
            default:
                break;
        }
    }];
}

//获取视频文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}

//对图片进行压缩
- (UIImage *)compressImage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(300, 300);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
