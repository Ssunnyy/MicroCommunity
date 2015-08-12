//
//  ITTMKNetWorkOperation.m
//  YiXin
//
//  Created by keke on 14/11/20.
//  Copyright (c) 2014年 com.yixin. All rights reserved.
//

#import "ITTMKNetWorkOperation.h"
@implementation ITTMKNetWorkOperation
-(instancetype)initWithURLString:(NSString *)aURLString params:(NSDictionary *)params httpMethod:(NSString *)method
{

    self = [super initWithURLString:aURLString params:params httpMethod:method];
    if (self) {

    }
    return self;
}

//-(id)responseJSON;
//{
//    if([self responseData] == nil) return nil;
//    NSError *error = nil;
//    id resultJson = [[CJSONDeserializer deserializer] deserialize:[self responseData] error:&error];
//    return resultJson;
//}
//-(NSData *)formatterResponseData
//{
//    NSData *jsonData;
//    NSMutableString *responseString = [NSMutableString stringWithString:[self responseString]];
//    NSString *character = nil;
//    for (int i = 0; i < responseString.length; i ++) {
//        character = [responseString substringWithRange:NSMakeRange(i, 1)];
//        if ([character isEqualToString:@"\\"])
//        {
//            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
//    }
//    jsonData = [responseString  dataUsingEncoding:NSUTF8StringEncoding];
//    return jsonData;
//}
@end
