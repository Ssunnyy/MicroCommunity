//
//  MCCompanyInfoModel.h
//  MicroCommunity
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MCCompanyInfoModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *companyIntro;
@property (nonatomic, strong) NSString *erweiMaUrl;


@end
