//
//  ASMaterialCell.h
//  ITotem
//
//  Created by qiuyan on 15-3-3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASMaterialCell : UITableViewCell

/**
 *  素材库的文字介绍
 *
 *  @param imgName 图片名字
 */
- (void)setContentCellTitle:(NSString *)imgName andImage:(NSString *)image;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
