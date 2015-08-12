//
//  Mycell.h
//  CollectionViewTest1.0
//
//  Created by itotem on 14-10-28.
//  Copyright (c) 2014年 Lisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mycell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *addImageView;
/**
 *  更新cell
 *
 *  @param image 
 */
-(void)updateCellWithImage:(UIImage *)image;
@end

