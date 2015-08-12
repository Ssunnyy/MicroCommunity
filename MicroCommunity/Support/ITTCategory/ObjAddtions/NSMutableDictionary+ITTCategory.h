//
//  NSMutableDictionary+ITTCategory.h
//
//  Created by keke on 14-7-4.
//
//

#import <Foundation/Foundation.h>
#define UNKEY   @"unkey"
#define SMALL   @"retSmallPicName"
#define MIDDLE  @"retMiddlePicName"
#define LARGE   @"retBigPicName"
#define ORIGION @"originalPicName"
@interface NSMutableDictionary (ITTCategory)
-(void)safeString:(NSString*)string ForKey:(NSString*)key;
-(BOOL)isSuccessForRequest;
-(NSString*)errorInfo;
-(NSString*)errorCode;
+(NSString*)getPicURL:(NSDictionary*)picDic;
+(NSString *)getOrigionPicUrl:(NSDictionary *)dic;
+(NSString*)getTurnPicURL:(NSDictionary*)picDic;
+(NSString*)getKnowlegdePicURL:(NSDictionary*)picDic;

//-(NSMutableDictionary*)formateDictionary;
@end
