//
//  MCMyCellModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCMyCellModel : ITTBaseModelObject


@property (nonatomic, assign) NSInteger myId;
@property (nonatomic, strong) NSString *myHeadPic;
@property (nonatomic, strong) NSString *myNickName;
@property (nonatomic, strong) NSString *myCount;

@end
