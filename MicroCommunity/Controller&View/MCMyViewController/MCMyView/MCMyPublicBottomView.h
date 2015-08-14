//
//  MCMyPublicBottomView.h
//  MicroCommunity
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCMyPublicBottomViewDelegate  <NSObject>

//  200 删除 201 重新发布
- (void) deleteOrPublic:(NSInteger) tag;

@end

@interface MCMyPublicBottomView : UITableViewCell
@property (nonatomic, assign) id <MCMyPublicBottomViewDelegate> delegate;

@end
