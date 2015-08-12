//
//  QShowImgViewController.h
//  Mimi
//
//  Created by qiuyan on 14-9-2.
//
//


@interface QShowImgViewController : UIViewController

@property (nonatomic, retain) NSArray *imgArr;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, retain) NSString *imgUrl; //从心愿上传图片的情况
@property (nonatomic, assign) BOOL isOne; // 展示的是否从心愿发来的图片

- (void)setUpPageStatusWithIndex:(NSInteger)index;

@end
