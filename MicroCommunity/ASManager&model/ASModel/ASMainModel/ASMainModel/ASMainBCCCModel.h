//
//  ASMainBCCCModel.h
//  ITotem
//
//  Created by qiuyan on 15-3-14.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//


//backImg = "http://ionly-other.qiniudn.com/Fs-Zzh4wxeklBm2hW2XogpqMuQs0";
//cityId = 6;
//citycn = "\U4fdd\U5b9a";
//createTime = 1423746814000;
//gender = "<null>";
//headImg = "http://ionly-other.qiniudn.com/Fs-Zzh4wxeklBm2hW2XogpqMuQs0";
//id = 12;
//lastLoginTime = "<null>";
//mobile = 15011393292;
//modifiedTime = 1421197892000;
//nickname = "\U5c0f\U540d";
//openGps = 1;
//openPush = 1;
//openShow = 1;
//password = 123456;
//personalSign = "<null>";
//referralId = 10;
//showIndex = 2;
//showOrder = 1;
//type = 2;


#import "ITTBaseModelObject.h"
#import "UserModel.h"
#import "ASCollectModel.h"
#import "ASBCActivityModel.h"

@interface ASMainBCCCModel : ITTBaseModelObject


@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSString *authStatus;
@property (nonatomic, strong) NSString *appUserId;
@property (nonatomic, strong) NSString *badReviewNum;
@property (nonatomic, strong) NSString *bornYear;
@property (nonatomic, strong) NSString *collectNum;
@property (nonatomic, strong) NSString *collected;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *jobId;
@property (nonatomic, strong) NSString *jobName;
@property (nonatomic, strong) NSString *praiseNum;
@property (nonatomic, strong) NSString *serviceDoor;
@property (nonatomic, strong) NSString *serviceRemote;
@property (nonatomic, strong) NSString *workYear;
@property (nonatomic, strong) NSString *marryDate;
@property (nonatomic, strong) NSString *loverNickname;
@property (nonatomic, strong) NSString *fullGradeCount;
@property (nonatomic, strong) NSString *halfGradeCount;
@property (nonatomic, strong) NSString *noneGradeCount;
@property (nonatomic, strong) ASCollectModel *collec;

@property (nonatomic, strong) ASBCActivityModel *joinActivity;




@end
