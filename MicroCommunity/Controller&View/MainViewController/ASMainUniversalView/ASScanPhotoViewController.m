//
//  YXScanPhotoViewController.m
//  YiXin
//
//  Created by Lisa on 14-12-23.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "ASScanPhotoViewController.h"
#import "ASStoryShowView.h"
#import "ASBCStoryModel.h"
#import "ASMainRequestManager.h"
#import "ASCollectModel.h"
#import "ASMaterialThirdModel.h"
#import "ASCCImageShowModel.h"
#import "ASBCStoryModel.h"
#import "ASBCShowImgsModel.h"
#import "Masonry.h"

@interface ASScanPhotoViewController ()<UIScrollViewDelegate>
{
    
    CGFloat offset;

}
@property (nonatomic,strong) NSMutableArray *arrays;
@property(nonatomic,assign)  NSInteger selectIndex;//选中的
@property(nonatomic,strong)  NSMutableArray *imageArray;//传过来的可显示的图片数组
@property (strong, nonatomic)  UIScrollView *mainScrollView;
@property (nonatomic, strong)  ASStoryShowView *showView;
/**
 *  从素材页面进入的长按住图片手势
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic, strong) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
@end

@implementation ASScanPhotoViewController

#pragma  mark -- 取消请求
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [[ASMainRequestManager shareManager]cancelAllRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    offset = 0.0;
    self.view.backgroundColor = RGBCOLOR(32, 32, 32);
    
    float height = 0;
    if (IOS_SDK_6) {
        height = 64;
    }else{
        height = 64;
    }
    
    UIView *bkview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];

    UIView *zeroView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:zeroView];
    
//    _scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,height, SCREEN_WIDTH, SCREEN_HEIGHT - height)];
    _scroView .backgroundColor = [UIColor clearColor];
    _scroView .scrollEnabled = YES;
    _scroView .pagingEnabled = YES;
    _scroView .delegate = self;
    _scroView.userInteractionEnabled = YES;
    _scroView.showsHorizontalScrollIndicator = NO;
    _scroView.showsVerticalScrollIndicator = NO;
    [_scroView addSubview:bkview];
//    [_scroView addSubview:_scroView];
    
    [self setNavigationBarStatus];
    [self changeContentViewHeight];
}

- (void)setShowImageArr:(NSArray *)imgArr andSelect:(NSInteger)select
{
    if (_scanPhoto == ASScanPhotoStory) {
        self.arrays = [NSMutableArray arrayWithArray:(NSArray *)imgArr];
    } else {
        self.imageArray = [NSMutableArray arrayWithArray:(NSArray *)imgArr];
    }
    self.selectIndex = select;
}

-(void)changeContentViewHeight
{
    float height = 0;
    if (IOS_SDK_6) {
        height = 64;
    }else{
        height = 44;
    }
    if (_scanPhoto == ASScanPhotoMaterial || _scanPhoto == ASScanPhotoCC || _scanPhoto == ASScanPhotoBCTackPhoto||_scanPhoto == ASScanCollection) {
        _scroView.contentSize = CGSizeMake(SCREEN_WIDTH *self.imageArray.count, 0);
        for (int i = 0; i<_imageArray.count; i++) {
            
            UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
            [doubleTap setNumberOfTapsRequired:2];
            CGRect frame = CGRectMake(SCREEN_WIDTH * i, height, SCREEN_WIDTH, SCREEN_HEIGHT-height);
            UIScrollView *s = [[UIScrollView alloc] initWithFrame:frame];
            s.backgroundColor = [UIColor clearColor];
            s.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-height);
            s.delegate = self;
            s.minimumZoomScale = 1.0;
            s.maximumZoomScale = 3.0;
            [s setZoomScale:1.0];
            s.userInteractionEnabled = YES;
            s.showsVerticalScrollIndicator = NO;
            s.showsHorizontalScrollIndicator = NO;
            UIImageView *imageview = [[UIImageView alloc] init];
            NSString *imgName = self.imageArray[i];
            if (_scanPhoto != ASScanCollection) {
                UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
                longPressGr.minimumPressDuration = .3f;
                [s addGestureRecognizer:longPressGr];
            }
            [imageview sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imgName] andPlaceholderImage:ImageNamed(@"") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (imageview.image) {
                    float thumbHeight = (SCREEN_WIDTH) * imageview.image.size.height / imageview.image.size.width;
                    imageview.frame =CGRectMake(0,  (SCREEN_HEIGHT - height - thumbHeight)/2, SCREEN_WIDTH, thumbHeight);
                }
            }];
            
            if (imageview.image) {
                float thumbHeight = (SCREEN_WIDTH)* imageview.image.size.height / imageview.image.size.width;
                imageview.frame =CGRectMake(0,(SCREEN_HEIGHT - height - thumbHeight)/2, SCREEN_WIDTH, thumbHeight);
            }
            
            imageview.userInteractionEnabled = YES;
            [imageview addGestureRecognizer:doubleTap];
            [s addSubview:imageview];
            [_scroView addSubview:s];
        }
    }else if(_scanPhoto == ASScanPhotoStory) {
        
        _scroView.contentSize = CGSizeMake(SCREEN_WIDTH *_arrays.count, 0);
        for (int i = 0; i < _arrays.count; i ++) {
            UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
            [doubleTap setNumberOfTapsRequired:2];
            ASBCStoryModel *story = [_arrays objectAtIndex:i];
            CGRect frame = CGRectMake(SCREEN_WIDTH * i, height, SCREEN_WIDTH, SCREEN_HEIGHT-height);
            UIScrollView *s = [[UIScrollView alloc] initWithFrame:frame];
            s.backgroundColor = [UIColor clearColor];
            s.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-height);
            s.delegate = self;
            s.minimumZoomScale = 1.0;
            s.maximumZoomScale = 3.0;
            [s setZoomScale:1.0];
            s.userInteractionEnabled = YES;
            s.showsVerticalScrollIndicator = NO;
            s.showsHorizontalScrollIndicator = NO;
            UIImageView *imageview = [[UIImageView alloc] init];
            [imageview sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:story.storyImg] andPlaceholderImage:ImageNamed(@"") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (imageview.image) {
                    float thumbHeight = (SCREEN_WIDTH) * imageview.image.size.height / imageview.image.size.width;
                    imageview.frame =CGRectMake(0,  (SCREEN_HEIGHT - height - thumbHeight)/2, SCREEN_WIDTH, thumbHeight);
                }
            }];
            
            if (imageview.image) {
                float thumbHeight = (SCREEN_WIDTH) * imageview.image.size.height / imageview.image.size.width;
                imageview.frame =CGRectMake(0,  (SCREEN_HEIGHT - height - thumbHeight)/2, SCREEN_WIDTH, thumbHeight);
            }

//            UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//            longPressGr.minimumPressDuration = .3f;
//            [s addGestureRecognizer:longPressGr];
            
            imageview.userInteractionEnabled = YES;
            [imageview addGestureRecognizer:doubleTap];
            imageview.tag = i+1;
            [s addSubview:imageview];
            [_scroView addSubview:s];
        }
        /**
         *  我的故事中使用
         */
        [self imgDescription];
    }
    self.scroView.contentOffset = CGPointMake((SCREEN_WIDTH *self.selectIndex), self.scroView.frametop);
    [self configCollectView];
}

/**
 *  设置导航栏
 */
- (void)setNavigationBarStatus
{
    [self setNavigationBarTitle:_titleStr];
    [self setButtonStyle:UIButtonStyleBack andImage:ImageNamed(@"back_icon_.png") highImage:ImageNamed(@"back_pre.png")];
}


#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
}

#pragma mark - Utility methods

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}



/**
 *  我的故事中使用
 */
- (void)imgDescription
{
    _showView = [[[NSBundle mainBundle] loadNibNamed:@"ASStoryShowView" owner:self options:nil] lastObject];
    _showView.framewidth = SCREEN_WIDTH;
    _showView.framebottom = SCREEN_HEIGHT - 40;
    [self.showView changeNum:[NSString stringWithFormat:@"%d / %ld", 1,_imageArray.count]];
    [self.view addSubview:_showView];
    if (_arrays.count > 0) {
        ASBCStoryModel *model = [_arrays objectAtIndex:self.selectIndex];
        [_showView setContent:model.desc];
    }
    [self.showView changeNum:[NSString stringWithFormat:@"%ld / %ld",self.selectIndex + 1,_arrays.count]];

}

/*
    bug　 不能通过scrollview的偏移量算页数
 */

#pragma mark--UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_scanPhoto == ASScanPhotoStory) {
        
        if (_selectIndex <= _arrays.count - 1) {
            
            ASBCStoryModel *model = [_arrays objectAtIndex:self.selectIndex];
            [_showView setContent:model.desc];
            int num = scrollView.contentOffset.x/SCREEN_WIDTH;
            if (num != self.selectIndex) {
                self.selectIndex = num;
                [self.showView changeNum:[NSString stringWithFormat:@"%d / %ld",num + 1,_arrays.count]];
                [self configCollectView];
            }
        }
    }
}

#pragma  mark  --  collectBtn选中效果
- (void) configCollectView{

    ASCollectModel *collect = nil;
    switch (_scanPhoto) {
            //  素材
        case ASScanPhotoMaterial:
        {
            ASMaterialThirdModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
            collect = model.collect;
        }
            break;
            //  cc图片展示
        case ASScanPhotoCC:
        {
            ASCCImageShowModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
            collect = model.collect;
        }
            break;
            //  bc我的故事
        case ASScanPhotoStory:
        {
            if (_imageCollectArray.count) {//修改的
                if (self.selectIndex < _imageCollectArray.count - 1) {
                    ASBCStoryModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                    collect = model.collect;
                }
            }
        }
            break;
            //  bc摄影
        case ASScanPhotoBCTackPhoto:
        {
            ASBCShowImgsModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
            collect = model.collect;
        }
            break;
        default:
            break;
    }
    if (collect != nil) {
        self.collectBtn.selected = NO;
    }else {
        self.collectBtn.selected = YES;
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
//        [UIView animateWithDuration:.3f animations:^{
//            v.frametop = 0;
//        }];
        return v;
    }
    return nil;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
//    if (scale == 1.0) {
//        for (UIView *v in scrollView.subviews){
//            [UIView animateWithDuration:.3f animations:^{
//                v.framecenterY = SCREEN_HEIGHT   /   2;
//            }];
//       }
//    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _scroView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        return;
        
    } else if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.collectionView.hidden = NO;
    }
}


- (IBAction)collectBtnClick:(UIButton *)sender
{
    
//来源    4、BC 我的故事  2 CC  3 素材 、1 bc素材集
    
    __weak ASScanPhotoViewController *weak = self;
    //
    NSString *userId = [[UserManager shareManager] getCurrentUser].userId;
    __block ASCollectModel *collect = nil;
    NSString *collectId = @"";
    
    if ([[UserManager shareManager]isAutoLoginResult]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //  通过不同的进入选取不同的 收藏对象 根据是不是有对象进行判断是收藏还是取消收藏
        switch (_scanPhoto) {
                //  素材
            case ASScanPhotoMaterial:
            {
                ASMaterialThirdModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                collect = model.collect;
            }
                break;
                //  cc图片展示
            case ASScanPhotoCC:
            {
                ASCCImageShowModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                collect = model.collect;
            }
                break;
                //  bc我的故事
            case ASScanPhotoStory:
            {
                ASBCStoryModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                collect = model.collect;
            }
                break;
                //  bc摄影
            case ASScanPhotoBCTackPhoto:
            {
                ASBCShowImgsModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                collect = model.collect;
            }
                break;
            default:
                break;
        }
        
        //  取消收藏
        if (collect != nil) {
            
            NSString *collectId = @"";
            if ([collect isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)collect;
                collectId = [dic objectForKey:@"id"];
            }else {
                collectId = collect.ids;
            }
            [dic safeString:collectId  ForKey:@"id"];
        
            [[ASMainRequestManager shareManager] requestCollectionCancelWithParam:dic withIndicatorView:self.view withCancelRequestID:@"Collection" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    switch (_scanPhoto) {
                            //  素材
                        case ASScanPhotoMaterial:
                        {
                            ASMaterialThirdModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = nil;
                        }
                            break;
                            //  cc图片展示
                        case ASScanPhotoCC:
                        {
                            ASCCImageShowModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = nil;
                        }
                            break;
                            //  bc我的故事
                        case ASScanPhotoStory:
                        {
                            ASBCStoryModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = nil;
                        }
                            break;
                            //  bc摄影
                        case ASScanPhotoBCTackPhoto:
                        {
                            ASBCShowImgsModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = nil;
                        }
                            break;
                    }
                    [ITTPromptView showMessage:@"取消成功"];
                    sender.selected = YES;
                }else {
                    sender.selected = NO;
                    [ITTPromptView showMessage:@"取消失败"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                [ITTPromptView showMessage:@"取消失败"];
                sender.selected = NO;
            }];
        }else {
            //  收藏
            
            switch (_scanPhoto) {
                    //  素材
                case ASScanPhotoMaterial:
                {
                    ASMaterialThirdModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                    collectId = model.ids;
                    [dic safeString:@"3" ForKey:@"collectType"];
                    [dic safeString:@"3" ForKey:@"collectSource"];
                }
                    break;
                    //  cc图片展示
                case ASScanPhotoCC:
                {
                    ASCCImageShowModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                    collectId = model.ids;
                    [dic safeString:@"3" ForKey:@"collectType"];
                    [dic safeString:@"2" ForKey:@"collectSource"];
                }
                    break;
                    //  bc我的故事
                case ASScanPhotoStory:
                {
                    ASBCStoryModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                    collectId = model.ids;
                    [dic safeString:@"3" ForKey:@"collectType"];
                    [dic safeString:@"4" ForKey:@"collectSource"];
                }
                    break;
                    //  bc摄影
                case ASScanPhotoBCTackPhoto:
                {
                    ASBCShowImgsModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                    collectId = model.ids;
                    [dic safeString:@"3" ForKey:@"collectType"];
                    [dic safeString:@"1" ForKey:@"collectSource"];
                }
                    break;
                default:
                    break;
            }
            
            [dic safeString:userId ForKey:@"appUserId"];
            [dic safeString:collectId ForKey:@"collectedId"];
        
            [[ASMainRequestManager shareManager] requestCollectionWithParam:dic withIndicatorView:self.view withCancelRequestID:@"Collection" withHttpMethod:kHTTPMethodPost onRequestFinish:^(MKNetworkOperation *operation) {
                
                if (operation.isSuccees) {
                    
                    NSDictionary *collect = [operation.resultDic objectForKey:@"collect"];
                    
                    switch (weak.scanPhoto) {
                            //  素材
                        case ASScanPhotoMaterial:
                        {
                            ASMaterialThirdModel *model = [weak.imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = [[ASCollectModel alloc]initWithDataDic:collect];
                        }
                            break;
                            //  cc图片展示
                        case ASScanPhotoCC:
                        {
                            ASCCImageShowModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = [[ASCollectModel alloc]initWithDataDic:collect];
                        }
                            break;
                            //  bc我的故事
                        case ASScanPhotoStory:
                        {
                            ASBCStoryModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = [[ASCollectModel alloc]initWithDataDic:collect];
                        }
                            break;
                            //  bc摄影
                        case ASScanPhotoBCTackPhoto:
                        {
                            ASBCShowImgsModel *model = [_imageCollectArray objectAtIndex:self.selectIndex];
                            model.collect = [[ASCollectModel alloc]initWithDataDic:collect];
                        }
                            break;
                        default:
                            break;
                    }
                    sender.selected = NO;
                    [ITTPromptView showMessage:@"收藏成功"];
                }else {
                    [ITTPromptView showMessage:@"收藏失败"];
                    sender.selected = YES;
                }
                
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                sender.selected = YES;
                [ITTPromptView showMessage:@"收藏失败"];
            }];
        }
        }else {
        [ITTPromptView showMessage:@"您还未登录"];
    }
    self.collectionView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
