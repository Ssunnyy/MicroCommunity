//
//  CommonHelp.m
//  HaierJiaDian
//
//  Created by wangjiangjiao on 14-4-28.
//
//

#import "CommonHelp.h"
#import "KeychainItemWrapper.h"

#define UUIDIdentifier @"UUIDIdentifier"

@implementation CommonHelp

+ (NSString *)getStringFromNetWorKString:(id)networkString
{
    NSString *value = nil;
    if ([networkString isKindOfClass:[NSNumber class]]) {
        value = [networkString stringValue];
    }else if([networkString isKindOfClass:[NSNull class]]){
        value = nil;
    }else{
        value = networkString;
    }
    if (!value || ![value length]) {
        value = @"";
    }
    return value;
}

#define aMinute 60
#define aHour 3600
#define aDay 86400
#define aWeek  (86400*7)
#define aMouth 86400* 30
#define aYear 60 * 60 * 24 * 365

+ (CGSize)getSizeFromString:(NSString *)string WithFont:(UIFont *)font withSize:(CGSize)size
{
    if (!string || ![string length]) {
        return CGSizeZero;
        
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000      //(IOS 7以上用这个方法，以下用else方法)
    if (IOS_VERSION_CODE >= 7) {
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        CGRect frame = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGSize titleSize = CGSizeMake(frame.size.width,frame.size.height);
        
        return titleSize;
        
    }else{
        CGSize titleSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        return titleSize;
    }
#else
    CGSize titleSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return titleSize;
#endif
    
}


+ (BOOL)isValidValue:(NSString*)value
{
    if (value && [value length] > 0) {
        return YES;
    }
    return NO;
}

/*车牌号验证 MODIFIED BY HELENSONG*/
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


#pragma mark - 根据尺寸压缩图片
+(UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  提示框
 *
 *  @param string 提示的内容
 */
+ (void)showMessageString:(NSString *)string
{
    if (!string || ![string length]) {
        return;
    }
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}



#pragma mark --- UUID

#pragma mark 使用KeyChain保存和获取UDID
+(NSString*)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//    NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


+ (NSString *)getUUIDFromKeychainItemWrapper
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:UUIDIdentifier accessGroup:nil];
    //从keychain里取出帐号密码
    NSString * uuidString = [wrapper objectForKey:(__bridge id)kSecValueData];
    if (!uuidString || ![uuidString length]) {
         uuidString = [CommonHelp getUUID];
        [wrapper setObject:uuidString forKey:(__bridge id)kSecValueData];
    }
    return uuidString;
}

/*
 截屏
 */
+ (UIImage *)screenShotsWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.framewidth, view.frameheight), YES, 0);
    //设置截屏大小
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

///提示信息
+ (void)promptMessage:(NSString *)message withCancelStr:(NSString *)cancelStr withConfirmStr:(NSString *)confirmStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:cancelStr otherButtonTitles:confirmStr, nil];
    [alert show];
}

+ (NSString *)getDateTimeString
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)[dat timeIntervalSince1970]];
    return timeString;
}

+(NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}



+(UIImage*)getImageByName:(NSString*)imageName{
    NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:path];
    return image;
}
+ (NSString *)getTimeFromTimestamp:(NSString *)datetime
{
    if (datetime) {
        NSTimeInterval  timeInterVal = [[NSDate date] timeIntervalSince1970];
        double publicTime = [datetime doubleValue];
        if (timeInterVal - publicTime < aMinute) {
            return @"刚刚";
        }else if (timeInterVal- publicTime < aHour){
            int minuteNum = (timeInterVal - publicTime)/aMinute;
            return [NSString stringWithFormat:@"%d分钟前",minuteNum];
        }else if(timeInterVal - publicTime < aDay){
            int hourNum = (timeInterVal - publicTime)/aHour;
            return [NSString stringWithFormat:@"%d小时前",hourNum];
        }else if(timeInterVal - publicTime < aWeek){
            int dayNum = (timeInterVal - publicTime)/aDay;
            return [NSString stringWithFormat:@"%d天前",dayNum];
        }else if(timeInterVal - publicTime < aMouth){
            int MouthNum = (timeInterVal - publicTime)/aWeek;
            return [NSString stringWithFormat:@"%d周前",MouthNum];
        }else{
            NSString *string;
            
            NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            }
            string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([datetime doubleValue])]];
            return string;
        }    }
    return @"";
    
}


+ (NSString *)getSinceTimeFromTimestamp:(NSString *)datetime
{
    if (datetime) {
        NSTimeInterval  timeInterVal = [[NSDate date] timeIntervalSince1970];
        double publicTime = [datetime doubleValue];
        if (timeInterVal - publicTime < aMinute) {
            return @"刚刚";
        }else if (timeInterVal- publicTime < aHour){
            int minuteNum = (timeInterVal - publicTime)/aMinute;
            return [NSString stringWithFormat:@"%d分钟前",minuteNum];
        }else if(timeInterVal - publicTime < aDay){
            int hourNum = (timeInterVal - publicTime)/aHour;
            return [NSString stringWithFormat:@"%d小时前",hourNum];
        }else if(timeInterVal - publicTime < aWeek){
            int dayNum = (timeInterVal - publicTime)/aDay;
            return [NSString stringWithFormat:@"%d天前",dayNum];
        }else if(timeInterVal - publicTime < aMouth){
            int MouthNum = (timeInterVal - publicTime)/aWeek;
            return [NSString stringWithFormat:@"%d周前",MouthNum];
        }else{
            NSString *string;
            
            NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            }
            string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([datetime doubleValue])]];
            return string;
        }    }
    return @"";
    
}

+ (NSString *)getMMWishDeadLineTimeFromDieTime:(NSString *)dietimeString
{
    NSInteger dietime = dietimeString.intValue;
    NSString *dayString = [NSString stringWithFormat:@"%d",(int)dietime/(3600*24)];
    NSString *hourString = [NSString stringWithFormat:@"%d",(int)dietime%(3600*24)/3600];
    NSString *minuteString = [NSString stringWithFormat:@"%d",(int)dietime/60];
    if ([dietimeString isEqualToString:@"0"]) {
        dayString = @"";
        hourString = @"";
        minuteString = @"0分钟";
    } else {
        if (dayString.intValue == 0 && hourString.intValue == 0) {
            dayString = @"";
            if (minuteString.integerValue == 0) {
                minuteString = @"1分钟";
            } else if (minuteString.integerValue == 59) {
                hourString = @"1小时";
                minuteString = @"";
            } else {
                hourString = @"";
                minuteString = [NSString stringWithFormat:@"%@分钟",minuteString];
            }
        } else {
            if (dayString.integerValue == 0) {
                dayString = @"";
            } else {
                dayString = [NSString stringWithFormat:@"%@天",dayString];
            }
            if (hourString.integerValue == 0) {
                hourString = @"";
            } else if (hourString.integerValue == 23) {
                dayString = [NSString stringWithFormat:@"%d天",(int)dayString.integerValue + 1];
                hourString = @"";
            } else {
                hourString = [NSString stringWithFormat:@"%@小时",hourString];
            }
            minuteString = @"";
        }
    }
    return [NSString stringWithFormat:@"%@%@%@",dayString,hourString,minuteString];
}

/*!
 @class
 @abstract 判断是不是手机号
 */


+ (BOOL)isvalidateMobile:(NSString *)mobile
{
    NSString *regex = @"^[1][\\d]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

+ (BOOL)isValidValueOrMobile:(NSString *)mobile
{
    if (mobile == nil || [mobile length] == 0 ) {
        [self showMessageString:@"手机号不能为空"];
        return NO;
    }
    
    if (![self isvalidateMobile:mobile]) {
        [self showMessageString:@"请输入正确的手机号"];
        return NO;
    }
    
    return YES;
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:idCard];
}
///*!
// @class
// @abstract 判断2个UserID是否相等
// */
//+(BOOL)judgeUserId:(NSString *)userId;
//{
//    if ([userId isEqualToString:DATA_USERID]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}


/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  字符串是NSNull类型的情况
 */
+ (NSString *)changeStr:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
        return string;
}


@end
