//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "NSTimer+Addition.h"
#import "ADMyPageView.h"

@implementation EScrollerView
@synthesize delegate;

- (void)dealloc {
	[_scrollView release];
    [noteTitle release];
	delegate=nil;
    [_pageControl release];
    if (imageArray) {
        [imageArray release];
        imageArray=nil;
    }
    if (titleArray) {
        [titleArray release];
        titleArray=nil;
    }
    [_animationTimer invalidate];
    [_animationTimer release];
    [_noteView release];
    [super dealloc];
}


-(id)initWithFrameRect:(CGRect)rect
{
    
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                           target:self
                                                         selector:@selector(animationTimerDidFired:)
                                                         userInfo:nil
                                                          repeats:YES];

    isTimeRun = YES;
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
		viewSize=rect;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        
        [self.scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        [self addSubview:self.scrollView];
        
//        _noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
        _noteView = [[UIView alloc] init];
        [_noteView setBackgroundColor:[UIColor grayColor]];
        _noteView.alpha = 0.7f;
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,6, 0, 20.0f)];
        
        if (IOS_VERSION_CODE >= 6.0) {
            self.pageControl.currentPageIndicatorTintColor = BaseColor;
            self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        }
        self.pageControl.currentPage=0;

//        if (!_pageControl) {
//            _pageControl=[[ADMyPageView alloc] init];
//        }
//        self.pageControl.currentPage=0;
        [self.noteView addSubview:self.pageControl];
        [self addSubview:self.noteView];
    }
    	return self;
}

// 根据网络返回的数据，设置scrollview上显示的图片 及 pageControl的个数
- (void)setScrollViewContent:(NSArray *)imgArr {

    
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:imgArr];
    [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
    [tempArray addObject:[imgArr objectAtIndex:0]];
    
    imageArray=[[NSArray alloc] initWithArray:tempArray];
    
    [tempArray release];
    
    NSUInteger pageCount=[imageArray count];
    
    _scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
    
    for (int i=0; i<pageCount; i++) {
        
        NSString *imgURL=[imageArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.image = ImageNamed(imgURL);
        [imgView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imgURL] andPlaceholderImage:ImageNamed(@"main_default.png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            [[SDImageCache sharedImageCache]storeImage:imgView.image forKey:imgURL toDisk:YES];
        }];
        [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
        imgView.tag=i;
        UITapGestureRecognizer *tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];

        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:tap];
        [self.scrollView addSubview:imgView];
        [imgView release];
    }
//    self.pageControl.pageNum=(pageCount-2);
    
    float pageControlWidth=(pageCount-2)*10.0f+40.f;
    self.pageControl.frame = CGRectMake((self.frame.size.width-pageControlWidth), 10, pageControlWidth, 20.0f);
    self.pageControl.numberOfPages=(pageCount-2);
    
    self.noteView.framewidth = self.pageControl.framewidth;
    self.noteView.frameheight = self.pageControl.frameheight - 2;
    self.noteView.framecenterX = SCREEN_WIDTH * 1/2;
    self.noteView.frametop = self.bounds.size.height - 30;
    [self.noteView makeCornerRadius:10.0f];
    self.pageControl.frametop = -0.5;
    self.pageControl.frameleft = self.noteView.framewidth / 2 - self.pageControl.framewidth / 2;
}

- (void)animationTimerDidFired:(NSTimer *)timer
{
    [UIView animateWithDuration:0.8f animations:^{
        [self.scrollView setContentOffset:CGPointMake((currentPageIndex+1) * CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y) animated:NO];
    } completion:^(BOOL finished) {
        if (currentPageIndex == imageArray.count-1) {
            CGPoint newset = CGPointMake(CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
            [self.scrollView setContentOffset:newset animated:NO];
        }
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pause];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    self.pageControl.currentPage=(page-1);

    
    if (isTimeRun) {
        if (page-1 >= [imageArray count]-2) {
            self.pageControl.currentPage = 0;
        }else{
            self.pageControl.currentPage = page-1;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self resume];
}

- (void)timeRun
{
    isTimeRun = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    if (currentPageIndex==0) {
        
        [scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
    }
    
    if (!isTimeRun) {
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        currentPageIndex=page;
        self.pageControl.currentPage=(page-1);
    }
}

- (void)pause
{
    [self.animationTimer pauseTimer];
    isTimeRun = NO;
}

- (void)resume
{
    [self.animationTimer resumeTimerAfterTimeInterval:3.0f];
    [self performSelector:@selector(timeRun) withObject:self afterDelay:0.0f];
}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

@end
