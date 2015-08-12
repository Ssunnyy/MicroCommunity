//
//  QShowImgViewController.m
//  Mimi
//
//  Created by qiuyan on 14-9-2.
//
//

#import "QShowImgViewController.h"

@interface QShowImgViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollV;
@property (nonatomic, retain) IBOutlet UIPageControl *pageCon;


@end

@implementation QShowImgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pageCon.hidden = NO;
    [self setUpPageStatusWithIndex:_currentIndex];
}

- (void)setUpPageStatusWithIndex:(NSInteger)index
{
    
    self.pageCon.currentPage = index;
    if (_isOne) {
        [self showVideoImg];
    }else{
        [self setShowImg];
    }
}

- (void)setShowImg
{
    if (_imgArr.count > 1) {
        self.pageCon.numberOfPages = _imgArr.count;
    }else{
        _pageCon.hidden = YES;
    }
    [self.scrollV setContentSize:CGSizeMake(SCREEN_WIDTH * _imgArr.count, SCREEN_HEIGHT)];
    for (int i = 0; i < _imgArr.count; i++) {
        UIImageView *showImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [showImgV sd_setImageWithURL:[_imgArr objectAtIndex:i] placeholderImage:ImageNamed(@"")];
        showImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSingleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [showImgV addGestureRecognizer:singleTap];
        
        UIImage *img = showImgV.image;
        if (img.size.width >= img.size.height) {
            float thumbHeight = SCREEN_WIDTH * img.size.height / img.size.width;
            showImgV.frame =CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, thumbHeight);
        }else{
            float thumbWidth = img.size.width * SCREEN_HEIGHT / img.size.height;
            if (thumbWidth > SCREEN_WIDTH) {
                showImgV.frame = CGRectMake(SCREEN_WIDTH * i, 0,SCREEN_WIDTH, SCREEN_HEIGHT - 20);
            }else{
                showImgV.frame = CGRectMake(SCREEN_WIDTH * i, 0,thumbWidth, SCREEN_HEIGHT-20);
            }
        }
        showImgV.framecenterY = SCREEN_HEIGHT / 2;
        showImgV.framecenterX = SCREEN_WIDTH * i + SCREEN_WIDTH / 2;
        [self.scrollV addSubview:showImgV];
    }
    [self.scrollV setContentOffset:CGPointMake(SCREEN_WIDTH * self.currentIndex,0) animated:NO];
}

- (void)showVideoImg
{
    _pageCon.hidden = YES;
    [self.scrollV setContentSize:CGSizeMake(320, SCREEN_HEIGHT)];
    UIImageView *showImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [showImgV sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:ImageNamed(@"")];
    
    showImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [showImgV addGestureRecognizer:singleTap];
    
    UIImage *img = showImgV.image;
    if (img.size.width >= img.size.height) {
        float thumbHeight = 320 * img.size.height / img.size.width;
        showImgV.frame =CGRectMake(0, 0, 320, thumbHeight);
    }else{
        float thumbWidth = img.size.width * SCREEN_HEIGHT / img.size.height;
        if (thumbWidth > 320) {
            showImgV.frame = CGRectMake(0, 0,320, SCREEN_HEIGHT - 20);
        }else{
            showImgV.frame = CGRectMake(0, 0,thumbWidth, SCREEN_HEIGHT - 20);
        }
    }
    showImgV.framecenterY = SCREEN_HEIGHT / 2;
    showImgV.framecenterX = SCREEN_WIDTH / 2;
    [self.scrollV addSubview:showImgV];

}

- (void)doSingleTap:(UITapGestureRecognizer*)gesture
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark -- scrollView delegate and  datasource
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollV.frame.size.width;
    int page = floor((self.scrollV.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageCon.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
