//
//  Mycell.m
//  CollectionViewTest1.0
//
//  Created by itotem on 14-10-28.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import "Mycell.h"
#import "UIImageView+ITTAddtions.h"
@interface Mycell ()


@end


@implementation Mycell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _addImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_addImageView];
    }
    return self;
}

-(void)updateCellWithImage:(UIImage *)image
{
    
    _imageView.image = [_imageView thumbnailWithImageWithoutScale:image size:_imageView.frame.size];
    
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
