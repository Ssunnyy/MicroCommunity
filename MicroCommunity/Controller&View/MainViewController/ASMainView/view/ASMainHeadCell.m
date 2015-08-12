//
//  ASMainHeadCell.m
//  ITotem
//
//  Created by qiuyan on 15-3-4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ASMainHeadCell.h"

@interface ASMainHeadCell ()

@property (nonatomic, strong) IBOutlet UIImageView *headImgView;

@end

@implementation ASMainHeadCell

- (void)awakeFromNib
{
}

- (void)changeHeadViewContent:(NSInteger)sectionIndex
{
    switch (sectionIndex) {
        case 0:
        {
            self.headImgView.image = ImageNamed(@"Title_sucaiku_");
        }
            break;
        case 1:
        {
            self.headImgView.image = ImageNamed(@"Title_xinrenxiu_");
        }
            break;
        case 2:
        {
            self.headImgView.image = ImageNamed(@"Title_remenshangpu_");
        }
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
