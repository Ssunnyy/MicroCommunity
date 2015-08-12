//
//  ADMyPageView.h
//  ADSystem
//
//  Created by qiuyan on 13-10-17.
//
//

#import <UIKit/UIKit.h>

@interface ADMyPageView : UIView

@property (nonatomic, assign) NSInteger nomalDotWH;//小点点的宽和高
@property (nonatomic, assign) NSInteger selectCarW;//小车的宽
@property (nonatomic, assign) NSInteger selectCarH;//小车的高
@property (nonatomic, strong) UIImage *nomalImg;
@property (nonatomic, strong) UIImage *selectImg;
@property (nonatomic,assign)int currentPage;
@property (nonatomic) NSInteger pageNum;

@property (nonatomic, assign) int lastPage;

@end
