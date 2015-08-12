//
//  CaptureViewController.m
//  ITotem
//
//  Created by qiuyan on 15-3-17.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "CaptureViewController.h"
#import "AGSimpleImageEditorView.h"


@interface CaptureViewController ()
{
//    KICropImageView *_cropImageView;

}

@property (nonatomic, strong) AGSimpleImageEditorView *editerView;
@property (nonatomic, strong) IBOutlet UIView *alphaView;
@end

@implementation CaptureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideNavBar];
    [self setUpEditerView];
}

- (void)setUpEditerView
{
    _editerView = [[AGSimpleImageEditorView alloc] initWithImage:self.image];
    _editerView.ratio = _scale;
    _editerView.frame = CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT);
    //外边框的宽度及颜色
    _editerView.borderWidth = 1.f;
    _editerView.borderColor = [UIColor blackColor];
    
    //截取框的宽度及颜色
    _editerView.ratioViewBorderWidth = 2.f;
    _editerView.ratioViewBorderColor = BaseColor;
    
    [self.alphaView addSubview:_editerView];
    
//    _cropImageView = [[KICropImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
//    [_cropImageView setCropSize:CGSizeMake(320, 200)];
//    [_cropImageView setImage:_image];
//    [self.view addSubview:_cropImageView];
}


- (IBAction)chooseImgClick:(UIButton *)sender
{
    if (sender.tag == 502) {
//        NSData *data = UIImagePNGRepresentation([_cropImageView cropImage]);
        UIImage *resultImage = [_editerView output];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getThumbImg:)]) {
            [_delegate getThumbImg:resultImage];
        }
    }
  
    if (!_isTakePic) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
