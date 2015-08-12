//
//  ASMaterialCell.m
//  ITotem
//
//  Created by qiuyan on 15-3-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMaterialCell.h"
#import "ASMaterialModel.h"
@interface ASMaterialCell ()

/**
 *  背景图
 */
@property (nonatomic, strong) IBOutlet UIImageView *bgImgView;

@end

@implementation ASMaterialCell

- (void)awakeFromNib
{
    
    
}
- (void)setContentCellTitle:(NSString *)imgName andImage:(NSString *)image
{
    if (imgName) {
        
        [self.bgImgView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imgName] andPlaceholderImage:ImageNamed(@"materDefault(1000).png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!_bgImgView.image) {
                _bgImgView.image = ImageNamed(@"materDefault(1000).png");
            }
        }];
        
    }else {
        if (image) {
            [self.bgImgView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_small",image]] andPlaceholderImage:ImageNamed(@"materDefault(1000).png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!_bgImgView.image) {
                    _bgImgView.image = ImageNamed(@"materDefault(1000).png");
                }
            }];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
