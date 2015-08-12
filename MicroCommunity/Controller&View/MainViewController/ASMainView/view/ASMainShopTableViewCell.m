//
//  ASMainShopTableViewCell.m
//  ITotem
//
//  Created by qiuyan on 15-3-4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMainShopTableViewCell.h"

@interface ASMainShopTableViewCell ()

//屏幕适配相关
/**
 *  头像透明view
 */
@property (nonatomic, strong) IBOutlet UIView *headAlphaView;
/**
 *   个人信息透明view的height
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *alphaViewHeight;

/**
 *  头像背景的宽高
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headImgWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headImgHeight;
/**
 *  头像背景透明view
 */
@property (nonatomic, strong) IBOutlet UIView *alphaHeadView;
/**
 *  透明view的宽高
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *alphaWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *alphaHeight;
/**
 *  头像容器的宽高
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headContainWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headContainHeight;

/**
 *  headView距离底部之间的间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headViewBottom;
/**
 *  名字和职业之间的垂直间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameAndWorkSpace;

/**
 *   名字距离左侧的距离
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;
/**
 *  职业距离左侧的间距
 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *workLeft;


//页面逻辑
/**
 *  头像
 */
@property (nonatomic, strong) IBOutlet UIImageView *headImgView;
/**
 *  名字
 */
@property (nonatomic, strong) IBOutlet UILabel *nameLab;
/**
 *  职业
 */
@property (nonatomic, strong) IBOutlet UILabel *workLab;

/**
 *  性别
 */
@property (nonatomic, strong) IBOutlet UIImageView *sexImgV;
/**
 *  背景图
 */
@property (nonatomic, strong) IBOutlet UIImageView *bgImgV;
//  收藏
@property (weak, nonatomic) IBOutlet UIButton *collection;
@property (weak, nonatomic) IBOutlet UILabel *collectionLab;
//  成交量
@property (weak, nonatomic) IBOutlet UIImageView *signBg;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UIButton *zan;
@property (weak, nonatomic) IBOutlet UILabel *zanLab;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;


@end

@implementation ASMainShopTableViewCell

- (void)awakeFromNib
{
    [self adapteScreen];
    [self.headAlphaView makeCircleView];
    [self.headImgView makeCircleView];
}

/**
 *  适配相关
 */
- (void)adapteScreen
{
    if (iPhone6Plus) {
        self.alphaViewHeight.constant = 60;
        self.headViewBottom.constant = 10;
        self.alphaHeight.constant = 100;
        self.alphaWidth.constant = 100;
        self.alphaHeadView.framewidth = 100;
        self.alphaHeadView.frameheight = 100;
        self.headContainWidth.constant = 110;
        self.headContainHeight.constant = 110;
        self.headImgHeight.constant = 100;
        self.headImgWidth.constant = 100;
        self.headImgView.framewidth = 100 - 8;
        self.headImgView.frameheight = 100 - 8;
        self.nameLeft.constant = 120;
        self.workLeft.constant = 120;
    }
    
    [_signBg makeCornerRadius:10];
}

- (void)setContentCell:(ASMainBCCCModel *)model
{
    
    [_signLab contentTest:model.user.personalSign];
    
    if ([model.user.gender isEqualToString:@"0"]) {//男
        self.sexImgV.image = ImageNamed(@"boy_.png");
    }else if([model.user.gender isEqualToString:@"1"]){
        self.sexImgV.image = ImageNamed(@"Girls_icon_.png");
    }else{
        self.sexImgV.image = ImageNamed(@"Girls_icon_.png");
    }
    if ([model.collected isEqualToString:@"1"]) {
        _collectionLab.textColor = BaseColor;
        [_collection setImage:ImageNamed(@"shoucang_huang_icon_.png")forState:UIControlStateNormal];
    }else {
        [_collection setImage:ImageNamed(@"xingx.png")forState:UIControlStateNormal];
        _collectionLab.textColor = [UIColor whiteColor];
    }
    
    if ([model.collectNum isKindOfClass:[NSNull class]] || model.collectNum == nil) {
//        _collectionLab.hidden = YES;
//        _collection.hidden = YES;
        [_collectionLab contentTest:@"0"];

    }else {
        [_collectionLab contentTest:model.collectNum];
        _collectionLab.hidden = NO;
        _collection.hidden = NO;

    }
    if ([model.praiseNum isKindOfClass:[NSNull class]] || model.praiseNum == nil) {
//        _zan.hidden = YES;
//        _zanLab.hidden = YES;
        [_zanLab contentTest:@"0"];

    }else {
        [_zanLab contentTest:model.praiseNum];
        _zan.hidden = NO;
        _zanLab.hidden = NO;

    }
    self.nameLab.text = model.user.nickname;
    
    if (_useType == MainUse) {
        [self.workLab contentTest:model.jobName];
    }else {
//        [self.workLab contentTest:model.job.jobName];
    }
    if (model.user.distance) {
        // 处理当model.user.distance的小数部分长度多于两位时，将后面部分去除
        CGFloat distance = floorf([model.user.distance floatValue] * 100) /100;
        NSString * distanceStr = @"";
        if (distance >= 999999.99) {
            distanceStr = @"未知距离";

        }else
        {
            distanceStr = [NSString stringWithFormat:@"%.2lfkm",distance];

        }
        _distanceLabel.text = distanceStr;
    }
   
    [self.headImgView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.user.headImg] andPlaceholderImage:ImageNamed(@"huazhuang_bg_") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!_headImgView.image) {
            _headImgView.image = ImageNamed(@"huazhuang_bg_.png");
        }
    }];
    [self.bgImgV sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.user.backImg] andPlaceholderImage:ImageNamed(@"main_default.png") options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!_bgImgV.image) {
            _bgImgV.image = ImageNamed(@"main_default.png");
        }
    }];
}

- (IBAction)enterBCCenter:(id)sender
{
    if (_bcdelegate && [_bcdelegate respondsToSelector:@selector(enterCenterBC:)]) {
        [_bcdelegate enterCenterBC:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
