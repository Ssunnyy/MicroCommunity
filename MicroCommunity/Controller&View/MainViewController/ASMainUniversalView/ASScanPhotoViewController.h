//
//  YXScanPhotoViewController.h
//  YiXin
//
//  Created by Lisa on 14-12-23.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "BaseViewController.h"


typedef enum : NSUInteger{
    ASScanPhotoStory = 0,   //我的故事
    ASScanPhotoMaterial,    //素材
    ASScanPhotoBCTackPhoto, //bc 摄影作品
    ASScanPhotoCC   ,        //照片展示
    ASScanCollection        //  收藏
} ASScanPhoto;


@protocol ASScanPhotoViewControllerDelegate <NSObject>

-(void)backForeVCWithArray:(NSMutableArray *)resultArray;

@end

@interface ASScanPhotoViewController : BaseViewController

/**
 *  从什么类型的控制器进入
 */
@property (nonatomic, assign) ASScanPhoto scanPhoto;

@property (nonatomic,assign)id<ASScanPhotoViewControllerDelegate>delagate;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSMutableArray *imageCollectArray;
/**
 *  展示的图片数组和从第几张显示
 *
 *  @param imgArr 图片数组
 *  @param select select
 */
- (void)setShowImageArr:(NSArray *)imgArr andSelect:(NSInteger)select;

@end
