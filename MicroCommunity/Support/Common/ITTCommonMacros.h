//
//  ITTCommonMacros.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#ifndef iTotemFrame_ITTCommonMacros_h
#define iTotemFrame_ITTCommonMacros_h
////////////////////////////////////////////////////////////////////////////////
#pragma mark - shortcuts

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define DATA_CATHE [ITTDataCacheManager sharedManager]

#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

#define DEVICE_TOKEN @"device_token"

#define DEVICE_TOKENNUM @"device_token_num"

#define UISCREEN            [[UIScreen mainScreen] bounds]
#define SCREEN_HEIGHT       UISCREEN.size.height
#define SCREEN_WIDTH        UISCREEN.size.width
//////////////////////
//融云测试 mgb7ka1nbs0mg 上线 8w7jv4qb70u8y appkey
//上线 KEFU1431396396940 //测试 KEFU1426140298589 客服
#define customerServiceId @"KEFU1426140298589"
#define rongCloudAppKey @"mgb7ka1nbs0mg"

///友盟的分享和统计的Key
#define kUMengKey       @"54b89b44fd98c5b7c9000d81"
#define kWeiboAppID     @"543021190"
#define kWXAppID        @"wx992cb9b5c837e83c"
#define kQQAppID        @"1104337022"
#define kWeiboAppKey    @"d018df00f11d6c701819e7de16c0fd3b"
#define kWXAppKey       @"f4df7cb3824de1d5af990acb8a5d1a53"
#define kQQAppKey       @"uz9FVfI1xGLpl57v"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - iphone 5 detection functions

#define SCREEN_HEIGHT_OF_IPHONE5 568

#define IS_IOS7     (IOS_VERSION_CODE >= 7.0 && IOS_VERSION_CODE <= 8.0)

#define IS_IOS8     (IOS_VERSION_CODE >= 8.0 )

#define ISLESS_IOS7 (IOS_VERSION_CODE < 7.0)

#define is35InchScreen() ([UIScreen mainScreen].bounds.size.height == 480)

#define is4InchScreen() ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

////////////////////////////////////////////////////////////////////////////////

#define IOS_VERSION_CODE   [[[UIDevice currentDevice] systemVersion] intValue]

#define IOS_SDK_3          IOS_VERSION_CODE==3
#define IOS_SDK_4          IOS_VERSION_CODE==4
#define IOS_SDK_5          IOS_VERSION_CODE==5
#define IOS_SDK_6          IOS_VERSION_CODE==6
#define IOS_SDK_7          IOS_VERSION_CODE==7
#define IOS_SDK_8          IOS_VERSION_CODE==8



////////////////////////////////////////////////////////////////////////////////
#pragma mark - degrees/radian functions 

#pragma mark - common functions

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////////////////////////////////////////////////////////////////////////////////
#pragma mark - color functions 

#define BaseColor    RGBCOLOR(0, 0, 0) 

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//16进制颜色值
#define RGBFromColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

////////////////////////////////////////////////////////////////////////////////
#define UIFontSize(CGFloat) [UIFont systemFontOfSize:CGFloat]
#define UIBoldFontSize(CGFloat)  [UIFont boldSystemFontOfSize:CGFloat]

#define FONT_S             [UIFont systemFontOfSize:12]
#define FONT_M             [UIFont systemFontOfSize:14]
#define FONT_L             [UIFont systemFontOfSize:17]
#define FONT_HTMLTEXT      [UIFont systemFontOfSize:17]

#define BOLD_FONT_S  [UIFont boldSystemFontOfSize:12]
#define BOLD_FONT_M  [UIFont boldSystemFontOfSize:14]
#define BOLD_FONT_L  [UIFont boldSystemFontOfSize:17]


////////////////////////////////////////////////////////////////////////////////
#pragma mark - 返回指定的ViewController
#define popToThisContrller(obj,num)  NSArray * viewControllerArray = obj.navigationController.viewControllers;\
UIViewController * controller = [viewControllerArray objectAtIndex:num];\
[obj.navigationController popToViewController:controller animated:YES];

#define pushToDestinationController(viewController,DestinationController)\
DestinationController * controller = [[DestinationController alloc] init];\
[viewController.navigationController pushViewController:controller animated:YES];\

////////////////////////////////////////////////////////////////////////////////

#define SHOULDOVERRIDE(basename, subclassname){ NSAssert([basename isEqualToString:subclassname], @"subclass should override the method!");}
#endif