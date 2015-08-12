//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>
@class ADMyPageView;


@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end

@interface EScrollerView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	NSArray *imageArray;
    NSArray *titleArray;
    id<EScrollerViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
    BOOL isTimeRun; // 定时器的状态 yes运行状态
}
@property (nonatomic , retain) NSTimer *animationTimer;
@property(nonatomic,retain)id<EScrollerViewDelegate> delegate;

@property (nonatomic, retain) 	UIScrollView *scrollView;
@property (nonatomic, retain)   UIPageControl *pageControl;
//@property (nonatomic, retain)   ADMyPageView *pageControl;

@property (nonatomic, retain) UIView *noteView;

-(id)initWithFrameRect:(CGRect)rect;

- (void)setScrollViewContent:(NSArray *)imgArr; // 根据网络返回的数据，设置scrollview上显示的图片 及 pageControl的个数

@end
