//
//  DataCacheManager.m
//  iTotemFrame
//
//  Created by lian jie on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ITTDataCacheManager.h"
#import "ITTObjectSingleton.h"
#import "ITTCacheDao.h"
#import <objc/runtime.h>

@interface ITTDataCacheManager()
{
    ITTCacheDao *_cacheDao;
}

- (void)registerMemoryWarningNotification;

@end

@implementation ITTDataCacheManager

ITTOBJECT_SINGLETON_BOILERPLATE(ITTDataCacheManager, sharedManager)

#pragma mark - lifecycle methods


- (id)init
{
    self = [super init];
    if(self){
        [self setup];
        [self restore]; 
        [self registerMemoryWarningNotification];
    }
    return self;
}

#pragma mark - private methods
- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemoryCache)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];    
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemoryCache)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif        
}

- (void)setup
{
    _dataCacheType = ITTDataCacheFile;
    [self setupDao];
}

- (void)setupDao
{
    switch (_dataCacheType) {
        case ITTDataCacheFile:
            _cacheDao = [[NSClassFromString(@"ITTFileCacheDao") alloc] init];
            break;
        case ITTDataCacheUserDefault:
            _cacheDao = [[NSClassFromString(@"ITTUserDefaultCacheDao") alloc] init];
            break;
        default:
            _cacheDao = [[NSClassFromString(@"ITTFileCacheDao") alloc] init];
            break;
    }
}

- (void)restore
{
    [_cacheDao restore];
}

- (BOOL)hasObjectInCacheByKey:(NSString*)key
{
    return [_cacheDao hasObjectInCacheByKey:key];
}

- (NSObject*)getCachedObjectByKey:(NSString*)key
{
    return [_cacheDao getCachedObjectByKey:key];
}

- (void)clearAllCache
{
    [_cacheDao clearAllCache];
}

- (void)clearAllDiskCache
{
    [_cacheDao clearAllDiskCache];
}

- (void)clearMemoryCache
{
    [_cacheDao clearMemoryCache];
}

- (void)addObject:(NSObject*)obj forKey:(NSString*)key
{
    [_cacheDao addObject:obj forKey:key];
}

- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key
{
    [_cacheDao addObjectToMemory:obj forKey:key];
}

- (void)removeObjectInCacheByKey:(NSString*)key
{
    [_cacheDao removeObjectInCacheByKey:key];
}

- (void)doSave
{
    [_cacheDao doSave];
}

- (void)setDataCacheType:(ITTDataCacheType)dataCacheType
{
    if (_dataCacheType != dataCacheType) {
        _dataCacheType = dataCacheType;
        [self setupDao];
    }
}
- (BOOL)isValidKey:(NSString*)key{
    if (!key || [key length] == 0 || (NSNull*)key == [NSNull null]) {
        return NO;
    }
    return YES;
}
- (BOOL)updateObject:(Class)objClass forKey:(NSString*)key byPropertyDic:(NSDictionary*)propertyDic
{
    if (![self isValidKey:key]) {
        return NO;
    }
    if (!propertyDic||[propertyDic allKeys].count==0) {
        return NO;
    }
    if ([self hasObjectInCacheByKey:key]) {
        id cachedObj = [self getCachedObjectByKey:key];
        if ([cachedObj isKindOfClass:[objClass class]])
        {
            NSArray * arrPropertyName = [self propertyOfClass:cachedObj];
            for (int i =0; i<arrPropertyName.count; i++)
            {
                for (int j = 0; j<propertyDic.allKeys.count; j++) {
                    NSString * propertyName =   [arrPropertyName objectAtIndex:i];
                    NSString * changeName   =   [propertyDic.allKeys objectAtIndex:j];
                    if ([propertyName isEqualToString:changeName]) {
                        const char* char_f  =  [[NSString stringWithFormat:@"_%@",propertyName] cStringUsingEncoding:NSASCIIStringEncoding];
                        Ivar ivar = class_getInstanceVariable([objClass class],char_f);
                        
                        object_setIvar(cachedObj, ivar, [[propertyDic objectForKey:changeName] copy]);
                        break;
                    }
                }
            }
            [self addObject:cachedObj forKey:key];
            [self doSave];
            return YES;
        }
        else
        {
            return NO;
        }
        return YES;
    }else
    {
        return NO;
    }
}
- (NSMutableArray *)propertyOfClass:(NSObject*)object
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
        //        id propertyValue = [object valueForKey:(NSString *)propertyName];
        //        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
@end
