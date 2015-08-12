//
//  CropImageViewController.h
//  Camera
//
//  Created by carbon on 13-10-25.
//  Copyright (c) 2013年 Carbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropImageView.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"

@protocol CropImageViewControllerDelegate <NSObject>

- (void)CropImageViewControllerDidCropSuccessfully:(UIImage*)image;

@end

@interface CropImageViewController : UIViewController <UIScrollViewDelegate,MBProgressHUDDelegate>
{
    UIScrollView *filtersScrollView;
    CropImageView *cropImageView;
    UIImageView *imageView;
}

@property (nonatomic,assign) id <CropImageViewControllerDelegate> delegate;

@property (nonatomic,assign) CGSize cropSize;

@property (nonatomic,retain) UIImage *cropImage;
@end
