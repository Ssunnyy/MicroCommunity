//
//  UserModel.h
//  YiXin
//
//  Created by keke on 14/12/1.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//


//backImg = "<null>";
//cityId = "<null>";
//citycn = "<null>";
//createTime = 1426918095000;
//gender = "<null>";
//headImg = "<null>";
//id = 15;
//lastLoginTime = "<null>";
//mobile = 13161255646;
//modifiedTime = 1426918095000;
//nickname = "\U574f\U4eba";
//openGps = 1;
//openPush = 1;
//openShow = 1;
//password = 11111111;
//personalSign = "<null>";
//referralId = "<null>";
//showIndex = 1;
//showOrder = 0;
//type = 1;

//authStatus = 1;
//bcNum = 0;
//ccNum = 0;
//picNum = 0;
//waitCommentNum = 15;
//waitConfirmNum = 20;
//waitPayNum = 10;
//waitServiceNum = 5;

#import "ITTBaseModelObject.h"

@interface UserModel : ITTBaseModelObject
@property (nonatomic, strong) NSString *backImg;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *citycn;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *lastLoginTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *modifiedTime;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *openGps;
@property (nonatomic, strong) NSString *openPush;
@property (nonatomic, strong) NSString *openShow;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *personalSign;
@property (nonatomic, strong) NSString *referralId;
@property (nonatomic, strong) NSString *showIndex;
@property (nonatomic, strong) NSString *showOrder;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *authStatus;
@property (nonatomic, strong) NSString *bcNum;
@property (nonatomic, strong) NSString *ccNum;
@property (nonatomic, strong) NSString *picNum;
@property (nonatomic, strong) NSString *waitCommentNum;
@property (nonatomic, strong) NSString *waitConfirmNum;
@property (nonatomic, strong) NSString *waitPayNum;
@property (nonatomic, strong) NSString *waitServiceNum;
@property (nonatomic, strong) NSString *shouhouNum;
@property (nonatomic, strong) NSString *rongToken;
@property (nonatomic, strong) NSString *loverNickname;
@property (nonatomic, strong) NSString *marryDate;

@end
