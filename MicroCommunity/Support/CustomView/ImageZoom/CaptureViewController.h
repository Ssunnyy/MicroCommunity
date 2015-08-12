//
//  CaptureViewController.h
//  ITotem
//
//  Created by qiuyan on 15-3-17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "BaseViewController.h"

@protocol CaptureViewDelegate <NSObject>

- (void)getThumbImg:(UIImage *)img;

@end

@interface CaptureViewController : BaseViewController

@property (nonatomic, strong) UIImage *image;
/**
 *是否是拍照片 yes 是 no 从相册选择
 */
@property (nonatomic, assign) BOOL isTakePic;
@property (nonatomic, strong) id<CaptureViewDelegate>delegate;
/**
 *  图片的缩放比例
 */
@property (nonatomic, assign) float scale;
@end
