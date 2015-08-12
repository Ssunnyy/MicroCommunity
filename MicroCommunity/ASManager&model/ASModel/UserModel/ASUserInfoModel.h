//
//  ASUserInfoModel.h
//  ITotem
//
//  Created by adims on 15/4/2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "UserModel.h"

@interface ASUserInfoModel : ITTBaseModelObject

@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *personalSign;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *backImg;
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *loverNickname;
@property (nonatomic, strong) NSString *marryDate;
@property (nonatomic, strong) NSString *jobId;
@property (nonatomic, strong) NSString *bornYear;
@property (nonatomic, strong) NSString *workYear;
@property (nonatomic, strong) NSString *serviceDoor;
@property (nonatomic, strong) NSString *serviceRemote;
@property (nonatomic, strong) NSString *serviceLanguage;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *realname;

@property (nonatomic, strong) NSString *praiseNum;
@property (nonatomic, strong) NSString *hasContentNum;
@property (nonatomic, strong) NSString *badReviewNum;


@end
