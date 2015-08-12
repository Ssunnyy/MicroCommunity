//
//  MCRecruitCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCRecruitCellDelegate <NSObject>

- (void) selectAtIndex :(NSInteger) index;

@end
@interface MCRecruitCell : UITableViewCell

@property (nonatomic,assign) id <MCRecruitCellDelegate> delegate;

- (void) configCurrenTitle:(NSString *)title1 andRightBtn:(NSString *) title2;

@end
