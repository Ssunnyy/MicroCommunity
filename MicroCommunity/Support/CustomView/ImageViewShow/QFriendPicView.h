//
//  QFriendPicView.h
//  Mimi
//
//  Created by qiuyan on 14-8-26.
//
//

#import <UIKit/UIKit.h>

#define PictureWidth (SCREEN_WIDTH - 125) / 3


@protocol qChoosePicDelegate <NSObject>

- (void)showAllPic:(NSArray *)picArr andImgTag:(NSInteger)index;

@end

@interface QFriendPicView : UIView

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, assign) id <qChoosePicDelegate>delegate;

//根据用户上传的图片布局
- (void)setPicView:(NSArray *)picArr;

@end
