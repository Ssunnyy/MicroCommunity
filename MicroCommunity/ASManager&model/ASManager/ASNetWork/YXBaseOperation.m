//
//  YXBaseOperation.m
//  YiXin
//
//  Created by keke on 14/11/20.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "YXBaseOperation.h"
#import "NSData+ITTAdditions.h"
@implementation YXBaseOperation

-(instancetype)initWithURLString:(NSString *)aURLString params:(NSDictionary *)params httpMethod:(NSString *)method
{
    self = [super initWithURLString:aURLString params:params httpMethod:method];
    if (self) {

    }
    return self;
}



//加密串
-(NSDictionary*)formateParams:(NSDictionary*)params withHttpMethod:(NSString*)method
{
    NSMutableDictionary * _params = [NSMutableDictionary dictionary];
    return _params;
}
-(NSDictionary*)getStaticParams
{
    return @{};
}
@end
