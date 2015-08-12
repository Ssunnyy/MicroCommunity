//
//  QFriendPicView.m
//  Mimi
//
//  Created by qiuyan on 14-8-26.
//
//

#import "QFriendPicView.h"
@implementation QFriendPicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgArr = [[NSArray alloc] init];
    }
    return self;
}

- (void)setPicView:(NSArray *)picArr
{
    self.imgArr = picArr;
    
    for (int i = 0; i < picArr.count; i ++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((PictureWidth + 9) * (i%3), (PictureWidth + 9) * floorf(i/3), PictureWidth, PictureWidth)];
        [img sd_setImageWithURL:[picArr objectAtIndex:i] placeholderImage:ImageNamed(@"")];

        img.userInteractionEnabled = YES;
        img.tag = i + 900;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSingleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [img addGestureRecognizer:singleTap];
        [self addSubview:img];
    }
}

- (void)doSingleTap:(UITapGestureRecognizer*)gesture
{
    UIImageView *imgV = (UIImageView *)gesture.view;
    
    if (_delegate && [_delegate respondsToSelector:@selector(showAllPic:andImgTag:)]) {
        [_delegate showAllPic:self.imgArr andImgTag:imgV.tag - 900];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
