//
//  MCProductModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCProductModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *productIntro;
@property (nonatomic, strong) NSString *productPic;
@property (nonatomic, strong) NSString *productSeeCount;
@property (nonatomic, strong) NSString *productAddress;
@property (nonatomic, strong) NSString *productCommentCount;
@property (nonatomic, strong) NSString *productDate;

@end
