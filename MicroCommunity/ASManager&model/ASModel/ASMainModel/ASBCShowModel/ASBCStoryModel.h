//
//  ASBCStoryModel.h
//  ITotem
//
//  Created by adims on 15/3/16.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "ASCollectModel.h"

@interface ASBCStoryModel : ITTBaseModelObject

@property (nonatomic, strong) NSString*appUserId;
@property (nonatomic, strong) NSString*desc;
@property (nonatomic, strong) NSString*ids;
@property (nonatomic, strong) NSString*storyImg;
@property (nonatomic, strong) ASCollectModel *collect;//收藏

@end
