//
//  MCHomeViewCell.m
//  MicroCommunity
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "MCHomeViewCell.h"
#import "MCHomeModel.h"


@interface MCHomeViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;

@property (weak, nonatomic) IBOutlet UILabel *oneLable;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;
@property (weak, nonatomic) IBOutlet UILabel *threeLab;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;

@end

@implementation MCHomeViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [_oneImage makeCornerRadius:15];
    [_twoImage makeCornerRadius:15];
    [_threeImage makeCornerRadius:15];
    
    _viewWidth.constant = SCREEN_WIDTH / 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnClick:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(btnClickAtIndex:)]) {
        [_delegate btnClickAtIndex:sender.tag];
    }
}
/**
 *  设置cell
 */

- (void)setContentCell:(NSArray *)modelArr andIndex:(NSInteger)index;
{
    self.oneView.hidden = NO;
    self.twoView.hidden = NO;
    self.threeView.hidden = NO;
    
//    int num = ceilf(modelArr.count /3.0) ; //一共有几行
//    MCHomeModel *model1 = (MCHomeModel *)[modelArr objectAtIndex:index*3];
//    
//    self.oneLable.text = model1.title;
//    [self.oneImage sd_setImageWithURL:[NSURL URLWithString:model1.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
//    
//    if (index == num - 1) {
//        
//        int yushu = modelArr.count % 3;
//        switch (yushu) {
//            case 0:
//            {
//                MCHomeModel *model2 = (MCHomeModel *)[modelArr objectAtIndex:index*3 + 1];
//                MCHomeModel *model3 = (MCHomeModel *)[modelArr objectAtIndex:index*3 + 2];
//                
//                [self.twoImage sd_setImageWithURL:[NSURL URLWithString:model2.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                }];
//                [self.threeImage sd_setImageWithURL:[NSURL URLWithString:model3.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                }];
//                self.twoLab.text = model2.title;
//                self.threeLab.text = model3.title;
//                
//            }
//            case 1:
//            {
//                self.threeView.hidden = YES;
//                MCHomeModel *model2 = (MCHomeModel *)[modelArr objectAtIndex:index*3 + 1];
//                [self.twoImage sd_setImageWithURL:[NSURL URLWithString:model2.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                }];
//                self.twoLab.text = model2.title;
//            }
//                break;
//            case 2:
//            {
//                self.twoView.hidden = YES;
//                self.threeView.hidden = YES;
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }else{
//        MCHomeModel *model2 = (MCHomeModel *)[modelArr objectAtIndex:index*3 + 1];
//        MCHomeModel *model3 = (MCHomeModel *)[modelArr objectAtIndex:index*3 + 2];
//        
//        [self.twoImage sd_setImageWithURL:[NSURL URLWithString:model2.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
//        [self.threeImage sd_setImageWithURL:[NSURL URLWithString:model3.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
//        self.twoLab.text = model2.title;
//        self.threeLab.text = model3.title;
//    }
    
    _oneBtn.tag = index * 3 + 200;
    _twoBtn.tag = index * 3 + 201;
    _threeBtn.tag = index * 3 + 202;
}


@end
