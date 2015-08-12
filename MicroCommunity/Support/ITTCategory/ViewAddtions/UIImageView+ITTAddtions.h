//
//  UIImageView+ITTAddtions.h
//  iTotemFrame
//
//  Created by itotem on 14-10-27.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapGestureBlock)(UIImageView *imageView);

@interface UIImageView (ITTAddtions)


- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

+(void)startImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;

+(void)stopImageViewRotateAnimation:(UIImageView *)currentImg forKey:(NSString*)key;

/*
    [imgView addTapGesture:^(UIImageView *imageView) {
        NSLog(@"imageView tap");
    }];
 */

- (void)addTapGesture:(tapGestureBlock)tapBlock;

@end
