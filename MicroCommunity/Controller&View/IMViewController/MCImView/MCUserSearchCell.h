//
//  MCUserSearchCell.h
//  MicroCommunity
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCUserSearchCellDelegate <NSObject>

- (void) searchConditionSex:(NSString *)sex AndHunYin:(NSString *) hunyin AndAge:(NSString *) age AndCollege:(NSString *) college AndConstellation:(NSString *)Constellation AndTag:(NSInteger)tag;

@end

@interface MCUserSearchCell : UITableViewCell

@property (nonatomic, assign) id <MCUserSearchCellDelegate> delegate;

- (void) reset;

@end
