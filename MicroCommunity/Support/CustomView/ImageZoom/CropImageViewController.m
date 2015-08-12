//
//  CropImageViewController.m
//  Camera
//
//  Created by carbon on 13-10-25.
//  Copyright (c) 2013年 Carbon. All rights reserved.
//

#import "CropImageViewController.h"

@interface CropImageViewController ()

@property (nonatomic,retain) UIImage *originalImage;
@end

@implementation CropImageViewController
@synthesize cropImage,cropSize,delegate,originalImage;

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        [self setTitle:@"缩放裁剪"];
        
        CGRect rect = CGRectMake(0, 9.5, 75, 25);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:rect];
        [button setHidden:YES];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cropImageDoneAndBaceButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:leftItem];
        [leftItem release];
      
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:rect];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cropImageButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setRightBarButtonItem:rightItem];
        [rightItem release];
    }
    return self;
}


- (void)cropImageDoneAndBaceButtonDidPressed
{
    if ([delegate respondsToSelector:@selector(CropImageViewControllerDidCropSuccessfully:)])
    {
        UIImage *image = [imageView image];
        [delegate CropImageViewControllerDidCropSuccessfully:image];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)cropImageButtonDidPressed
{
    /*
    if ([delegate respondsToSelector:@selector(CropImageViewControllerDidCropSuccessfully:)])
    {
        UIImage *image = [cropImageView cropImage];
        [delegate CropImageViewControllerDidCropSuccessfully:image];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
     */
    UIImage *image = [cropImageView cropImage];
    [cropImageView removeFromSuperview];
    [cropImageView release];
    cropImageView = nil;
    
    [self setOriginalImage:image];
    if (!imageView)
    {
        CGRect frame = CGRectMake((320-cropSize.width)/2, (self.view.bounds.size.height-cropSize.height)/2, cropSize.width, cropSize.height);
        imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.view addSubview:imageView];
        [imageView setBackgroundColor:[UIColor clearColor]];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.15f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        [imageView.layer removeAllAnimations];
        [imageView.layer addAnimation:animation forKey:@"animation"];
    }
    [imageView setImage:self.originalImage];
    
    [[[self.navigationItem leftBarButtonItem] customView] setHidden:NO];
    [[[self.navigationItem rightBarButtonItem] customView] setHidden:YES];
    
    CGRect frame = filtersScrollView.frame;
    frame.origin.x = (self.view.bounds.size.width-300)/2;
    [filtersScrollView setFrame:frame];
    
    CATransition *transition = [CATransition animation];
    //        [transition setDuration:1.25f];
    [transition setType:kCATransitionPush];
    [transition setSubtype: kCATransitionFromRight];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [filtersScrollView.layer removeAllAnimations];
    [filtersScrollView.layer addAnimation:transition forKey:@"animation"];
    [filtersScrollView.layer setMasksToBounds:YES];
    [filtersScrollView.layer setCornerRadius:5.0];
    
    NSArray *array = [NSArray arrayWithObjects:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐色",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    for (int index = 0; index < [array count]; index++)
    {
        CGRect frame = CGRectMake(5+index*55, 2.5, 50, 40);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:frame];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTag:index];
        [button setShowsTouchWhenHighlighted:YES];
        [button setTitle:[array objectAtIndex:index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(filtersSelectButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
        [filtersScrollView addSubview:button];
    }
    [filtersScrollView setContentSize:CGSizeMake([array count]*55+5, 45)];
}


- (void)filters:(NSNumber*)number
{
    UIImage *image = nil;
    switch (number.intValue)
    {
        case 0:
        {
            image= self.originalImage;
            break;
        }
        case 1:
        {
            image = [self.originalImage lomo];
            break;
        }
        case 2:
        {
            image = [self.originalImage blackWhite];
            break;
        }
        case 3:
        {
            image = [self.originalImage missOld];
            break;
        }
        case 4:
        {
            image = [self.originalImage geTe];
            break;
        }
        case 5:
        {
            image = [self.originalImage ruiHuai];
            break;
        }
        case 6:
        {
            image = [self.originalImage danYa];
            break;
        }
        case 7:
        {
            image = [self.originalImage jiuHong];
            break;
        }
        case 8:
        {
            image = [self.originalImage qingNing];
            break;
        }
        case 9:
        {
            image = [self.originalImage langMan];
            break;
        }
        case 10:
        {
            image = [self.originalImage guangYun];
            break;
        }
        case 11:
        {
            image = [self.originalImage lanDiao];
            break;
        }
        case 12:
        {
            image = [self.originalImage mengHuan];
            break;
        }
        case 13:
        {
            image = [self.originalImage yeSe];
            break;
        }
        default:
            break;
    }
    [imageView setImage:image];
}

- (void)filtersSelectButtonDidPressed:(UIButton*)btn
{
    MBProgressHUD *waitView = [[MBProgressHUD alloc] initWithFrame:self.view.frame];
    [waitView setDelegate:self];
    [self.view addSubview:waitView];
    [waitView showWhileExecuting:@selector(filters:) onTarget:self withObject:[NSNumber numberWithInt:(int)btn.tag] animated:YES];
    [waitView release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setNavigationBarStatus];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    cropImageView = [[CropImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+500, SCREEN_HEIGHT - 64)];
    cropImageView.backgroundColor = [UIColor grayColor];
    [cropImageView setImage:cropImage cropType:CropImageFillRect size:cropSize];
    [self.view addSubview:cropImageView];
    
    CGRect frame = CGRectMake(self.view.bounds.size.width, cropImageView.frame.origin.y+cropSize.height+(cropImageView.frame.size.height-cropSize.height)/2+10, SCREEN_WIDTH, 45);
    filtersScrollView = [[UIScrollView alloc] initWithFrame:frame];
//    [filtersScrollView setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1.0]];
    filtersScrollView.backgroundColor = [UIColor yellowColor];
    [filtersScrollView setShowsHorizontalScrollIndicator:NO];
    [filtersScrollView setShowsVerticalScrollIndicator:NO];
//    [self.view addSubview:filtersScrollView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    if (cropImageView)
    {
        [cropImageView removeFromSuperview];
        [cropImageView release];
    }
    if (imageView)
    {
        [imageView release];
    }
    if (filtersScrollView)
    {
        [filtersScrollView release];
    }
    [originalImage release];
    [cropImage release];
    [super dealloc];
}



#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}
@end
