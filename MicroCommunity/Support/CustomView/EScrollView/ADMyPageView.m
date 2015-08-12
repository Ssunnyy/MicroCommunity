//
//  ADMyPageView.m
//  ADSystem
//
//  Created by qiuyan on 13-10-17.
//
//

#import "ADMyPageView.h"

@interface ADMyPageView(){
    UIImageView *_selectedImageView;
}
- (CGFloat)getDotXWithIndex:(int)index;
@end

@implementation ADMyPageView

- (CGFloat)getDotXWithIndex:(int)index
{
    return index * self.selectCarW * 1.5;
}

- (id)init
{
    self = [super init];
    if (self) {
        _currentPage = 0;
        _lastPage = 0;
        if (iPhone6Plus) {
            self.nomalDotWH = 8;
            self.selectCarW = 16;
            self.selectCarH = 8;
            //            self.selectCarW = 8;
            
        }else{
            self.nomalDotWH = 6;
            self.selectCarW = 12;
            self.selectCarH = 6;
            //            self.selectCarW = 6;
        }
        self.nomalImg = ImageNamed(@"Switching_bai_.png");
        self.selectImg = ImageNamed(@"Switching_hong_.png");
        
    }
    return self;
}

- (void)setPageNum:(NSInteger)pageNum
{
    [self removeAllSubviews];
    self.frame = CGRectMake(0, 0,self.selectCarW * 1.5 * (pageNum - 1) + self.nomalDotWH ,self.nomalDotWH + 10);
    _pageNum = pageNum;
    
    for (int i = 0; i < _pageNum; i++) {
        CGRect dotFrame = CGRectMake([self getDotXWithIndex:i], self.frameheight/2, self.nomalDotWH, self.nomalDotWH);
        UIImageView *dotView = [[UIImageView alloc] initWithFrame:dotFrame];
        dotView.tag = i + 1000;
        dotView.image = self.nomalImg;
        [self addSubview:dotView];
        [dotView release];
        
        //        UIImageView *normalSelectView = [[UIImageView alloc] initWithFrame:CGRectMake([self getDotXWithIndex:i], self.frameheight/2, self.selectCarW * 2, self.selectCarH)];
        //        normalSelectView.tag = 10000 + i;
        //        normalSelectView.hidden = YES;
        //        normalSelectView.image = ImageNamed(@"Switching_bai_tuoyuan_");
        //        [self addSubview:normalSelectView];
    }
    
    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-(self.nomalDotWH/2), self.frameheight/2, self.selectCarW , self.selectCarH)];
    //    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frameheight/2, self.selectCarW * 2, self.selectCarH)];
    
    _selectedImageView.image = self.selectImg;
    [self addSubview:_selectedImageView];
}

- (void)setCurrentPage:(int)currentPage
{
    [UIView animateWithDuration:0.3f animations:^{
        _currentPage = currentPage;
        CGRect frame = _selectedImageView.frame;
        _selectedImageView.frame = frame;
        _selectedImageView.framecenterX = [self getDotXWithIndex:_currentPage] + self.nomalDotWH/2;
    }];
    
    
    //    if (iPhone6Plus) {
    //        dotImgView.framewidth = 2 * self.selectCarW;
    //    }else{
    //        dotImgView.framewidth = 1.5 * self.selectCarW;
    //    }
    //    _selectedImageView.frame = CGRectMake([self getDotXWithIndex:_currentPage], self.frameheight/2, self.selectCarW, self.selectCarH);
    //    _currentPage = currentPage;
    //
    //
    //    UIImageView *dotImgView;
    //    UIImageView *normalImgView;
    //    if ((currentPage == 0 && _lastPage == _pageNum - 1)|| (currentPage == _pageNum - 1 && _lastPage == 0)) {
    //        dotImgView = nil;
    //        normalImgView = nil;
    //        [UIView animateWithDuration:0.3f animations:^{
    //            _selectedImageView.framewidth = self.selectCarW * 2;
    //            _selectedImageView.framecenterX = [self getDotXWithIndex:_currentPage] + self.nomalDotWH/2;
    //        }];
    //
    //    }else{
    //        if (currentPage > _lastPage) {//向右滑动
    //            dotImgView = (UIImageView *)[self viewWithTag: currentPage-1 + 1000];
    //            normalImgView = (UIImageView *)[self viewWithTag: currentPage-1 + 10000];
    //
    //        }else{//向左滑动
    //            dotImgView = (UIImageView *)[self viewWithTag: currentPage+1 + 1000];
    //            normalImgView = (UIImageView *)[self viewWithTag: currentPage+1 + 10000];
    //        }
    //    }
    //    normalImgView.framewidth = 2 * self.selectCarW;
    //    normalImgView.hidden = NO;
    //
    //    [UIView animateWithDuration:0.5f animations:^{
    //
    //        if (currentPage > _lastPage) {//向右滑动
    //            _selectedImageView.frame = CGRectMake([self getDotXWithIndex:_currentPage] - self.selectCarW , self.frameheight/2, self.selectCarW* 2, self.selectCarH);
    //
    //        }else{//向左滑动
    //            _selectedImageView.frame = CGRectMake([self getDotXWithIndex:_currentPage] , self.frameheight/2, self.selectCarW* 2, self.selectCarH);
    //        }
    //
    //        normalImgView.framewidth = self.selectCarW;
    //    }completion:^(BOOL finished) {
    //        normalImgView.hidden = YES;
    //    }];
    //    
    //    
    //    _lastPage = currentPage;
    
}

- (void)dealloc
{
    [_selectedImageView release];
    [super dealloc];
}


@end
