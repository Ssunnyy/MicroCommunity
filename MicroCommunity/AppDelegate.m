//
//  AppDelegate.m
//  ITotem
//
//  Created by qiuyan on 15-3-2.
//  Copyright (c) 2015年 qiuyan. All rights reserved.
//

#import "AppDelegate.h"
#import "ITTCustomTabBarView.h"
#import "ITTHiddenTabBarViewController.h"

#import "MCLoginViewController.h"
#import "MCMyViewController.h"
#import "MCHomeViewController.h"
#import "MCTalkViewController.h"
#import "MCIMViewController.h"


@interface AppDelegate()

@property (nonatomic, retain) BaseViewController* currentViewController;

/**
 *  tab
 */

@end

#pragma mark - Public Methods
AppDelegate *_appDelegate;
BOOL iscustomTabBarViewHide = NO;

@implementation AppDelegate

+ (void)HideTabBar
{
    if (!iscustomTabBarViewHide) {
        iscustomTabBarViewHide = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _appDelegate.customTabBarView.frametop = SCREEN_HEIGHT;
        }];
    }
}
+ (void)DisplayTabBar
{
    if (iscustomTabBarViewHide) {
        iscustomTabBarViewHide = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _appDelegate.customTabBarView.frametop = SCREEN_HEIGHT - _appDelegate.customTabBarView.frameheight;
        }];
    }
}

+ (AppDelegate *)GetAppDelegate {
    return _appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  注册通知
     */
    [self registNotification];
    /**
     *  viewDidLoad中基本方法
     */
    _appDelegate = self;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    /**
     *  初始化控制器和添加用户在其他客户端登陆后当前用户被顶下去
     *
     *  @param setUpTabbarController
     *
     *  @return
     */
    
    [self setUpTabbarController];
    
//    [self performSelector:@selector(setUpTabbarController) withObject:self afterDelay:.1f];
    
    return YES;
}

/**
 *  注册通知
 */
- (void) registNotification{

    // 设置群组信息提供者。
    double version = [[[UIDevice currentDevice] systemVersion]floatValue];
    if (version >= 8.0) {
        // 在 iOS 8 下注册苹果推送，申请推送权限。
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                             |UIUserNotificationTypeSound
                                                                                             |UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else {
        // 注册苹果推送，申请推送权限。
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
}

#pragma mark - 定位
#pragma mark 更新用户自身位置

- (void)updatePostion
{
    if ([self checkLocationIsValid]) {
        [[MMLocationManager shareLocation]startGetUserLocation:^(CLLocationCoordinate2D locationCorrrdinate)
         {
             NSString *_lon=[NSString stringWithFormat:@"%f",locationCorrrdinate.longitude];
             NSString *_lat=[NSString stringWithFormat:@"%f",locationCorrrdinate.latitude];
             
             [USER_DEFAULT setObject:_lon forKey:MMLastLongitude];
             [USER_DEFAULT setObject:_lat forKey:MMLastLatitude];
         }];
        [[MMLocationManager shareLocation]getAddress:^(NSString *addressString) {
            NSLog(@"%@",addressString);
        }];
    }
}

#pragma mark 是否开启定位功能
-(BOOL)checkLocationIsValid
{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            
            return YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        return NO;
    }
    return NO;
}

#pragma mark - 初始化控制器

- (void)setUpTabbarController
{
    _tabbarController = [[ITTHiddenTabBarViewController alloc] init];
    NSMutableArray *navControllers = [NSMutableArray array];
    [self addViewController:[MCHomeViewController class] toArray:navControllers];
    [self addViewController:[MCTalkViewController class] toArray:navControllers];
    [self addViewController:[MCIMViewController class] toArray:navControllers];
    [self addViewController:[MCMyViewController class] toArray:navControllers];
    [self addViewController:[MCLoginViewController class] toArray:navControllers];
    
    _tabbarController.viewControllers = navControllers;
    self.window.rootViewController = _tabbarController;
    _customTabBarView = [ITTCustomTabBarView loadFromXib];
    _customTabBarView.framewidth = SCREEN_WIDTH;
    _customTabBarView.frametop = SCREEN_HEIGHT - _customTabBarView.frameheight;
    _customTabBarView.tabBarController = _tabbarController;
    [_tabbarController.view addSubview:_customTabBarView];
//     [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:0];
    
    MCUserModel *user = [[MCUserManager shareManager] getCurrentUser];
    if (user) {
        if (user.phone && user.password) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic safeString:user.phone ForKey:@"phone"];
            [dic safeString:user.password ForKey:@"password"];
            
            [[MCUserManager shareManager] requestLoginWithParam:dic withIndicatorView:nil withCancelRequestID:@"Login" onRequestFinish:^(MKNetworkOperation *operation) {
                if ([operation isSuccees]) {
                    
                    [ITTPromptView showMessage:@"自动登录成功"];

                    MCUserModel *model = [[MCUserModel alloc]initWithDataDic:operation.resultDic];
                    model.password = user.password;
                    [[MCUserManager shareManager]safeAccountToLocal:model];
                    [[MCUserManager shareManager] setAutoLogin:YES];
                    
                    [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:0];
                    
                }else{
                    [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:4];
                    [ITTPromptView showMessage:@"自动登录失败"];
                }
            } onRequestFailed:^(MKNetworkOperation *operation, NSError *error) {
                
                [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:4];
                [ITTPromptView showMessage:@"自动登录失败"];
                
            } doSaveAccount:^UserModel *{
                UserModel * model = [[UserModel alloc]init];
                model.password = user.password;
                model.mobile = user.phone;
                return model;
            }];
        }
    }else {
            [[AppDelegate GetAppDelegate] customTabBarViewselectTabAtIndex:4];
    }
}

- (void)customTabBarViewselectTabAtIndex:(NSInteger)index
{
    [_customTabBarView selectTabAtIndex:index];
    [_customTabBarView.tabBarController setSelectedTabIndex:index];
    [_customTabBarView.superview bringSubviewToFront:_customTabBarView];
}

- (void)addViewController:(Class)ViewController toArray:(NSMutableArray*)array{
    UIViewController *vc = [[ViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
  //  [nvc setNavigationBarHidden:YES];
    [array addObject:nvc];
}

-(void)getCurrentController:(BaseViewController*)controller
{
    if (controller) {
        self.currentViewController = (BaseViewController*)controller;
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 每次打开应用就更新地理坐标
    [self updatePostion];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

# pragma mark - IM
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // Register to receive notifications.
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    
}
#endif

// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{

}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}
//  支付宝客户端返回
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return  YES;
}
@end
