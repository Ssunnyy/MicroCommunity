//
//  MKNetworkOperation+ITTNetworkOperation.h
//  YiXin
//
//  Created by keke on 14/12/4.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "MKNetworkOperation.h"
#import "CJSONDeserializer.h"

@interface MKNetworkOperation (ITTNetworkOperation)
//业务上逻辑是否成功
-(BOOL)isSuccees;
//返回data数据
-(NSDictionary*)resultDic;
//返回说明
-(NSString*)message;

@end
