//
//  ASMainHeadCell.h
//  ITotem
//
//  Created by qiuyan on 15-3-4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASMainHeadCell : UITableViewCell

/**
 *  改变标题的图片
 *
 *  @param sectionIndex 0 素材库 1 新人秀 2 商家
 */
- (void)changeHeadViewContent:(NSInteger)sectionIndex;


@end
