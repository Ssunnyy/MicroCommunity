//
//  MKNetworkOperation+ITTNetworkOperation.m
//  YiXin
//
//  Created by keke on 14/12/4.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "MKNetworkOperation+ITTNetworkOperation.h"

@implementation MKNetworkOperation (ITTNetworkOperation)

-(BOOL)isSuccees
{
    NSObject* result=self.responseJSON ;
    if ([result isKindOfClass:[NSArray class]]) {
        if ([(NSArray*)result count]!=0) {
            return YES;
        }else
        {
            return NO;
        }
    }
    else if ([result isKindOfClass:[NSDictionary class]])
    {
        NSString * resultStr = [(NSDictionary*)result objectForKey:@"code"];
        if (resultStr) {
            if ([resultStr isKindOfClass:[NSNumber class]]) {
                
                if ([(NSNumber*)resultStr integerValue]==1) {
                    return YES;
                }else
                {
                    return NO;
                }
                
            }else
            {
                if ([resultStr isEqualToString:@"1"]) {
                    return YES;
                }else
                {
                    return NO;
                }
            }
        }else
        {
            if ([(NSDictionary*)result allKeys].count!=0)
            {
                return YES;
            }else
            {
                return NO;
            }
        }
    }
    else
    {
        if (!result||[result isKindOfClass:[NSNull class]]) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}
-(NSDictionary*)resultDic
{
    NSError * error;
    NSObject* result= [[[CJSONDeserializer deserializer] deserializeAsDictionary:[self responseData] error:&error] objectForKey:@"data"];
    if ([result isKindOfClass:[NSArray class]]) {
        NSMutableArray * tempArr = [NSMutableArray arrayWithArray:(NSArray*)result];
        for (NSObject * item in tempArr) {
            if ([item isKindOfClass:[NSNull class]]) {
                [tempArr removeObject:item];
            }
        }
        return @{@"data":tempArr};
    }else if ([result isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary* tempDic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)result];
        for (NSString* itemKey in [tempDic allKeys]) {
            if ([[tempDic objectForKey:itemKey] isKindOfClass:[NSNull class]]) {
                [tempDic safeString:@"" ForKey:itemKey];
//                [tempDic removeObjectForKey:itemKey];
            }
        }
        return tempDic;
    }else
    {
        if (!result||[result isKindOfClass:[NSNull class]]) {
            return nil;
        }
        else
        {
            return @{@"data":result};
        }
    }
}
-(NSString*)message
{
    NSObject* result=self.responseJSON ;
    if ([result isKindOfClass:[NSArray class]]) {
        return @"";
    }
    else if ([result isKindOfClass:[NSDictionary class]])
    {
        NSString * msgStr = [(NSDictionary*)result objectForKey:@"msg"];
        if (msgStr) {

            return [NSString stringWithFormat:@"%@",msgStr];

        }else
        {
            return @"";
        }
    }
    else
    {
        return @"";
    }
}



@end
