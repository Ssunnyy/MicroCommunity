//
//  NSString+Base64.m
//  WenYiTing
//
//  Created by huawei.zhang on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Base64.h"
#import "GTMBase64.h"

@implementation NSString(Base64)

- (NSString *) stringEncodeBase64
{
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    // 转换到base64 
    data = [GTMBase64 encodeData:data]; 
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]; 
}

- (NSString *) stringDecodeBase64
{
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    // 转换到string
    data = [GTMBase64 decodeData:data]; 
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]; 
}

@end
