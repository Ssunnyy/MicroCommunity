//
//  DataCacheManager.h
//  iTotemFrame
//  轻量级缓存管理器，利用UserDefault进行缓存管理，大数据量是效率有问题
//  两种数据缓存的方式 ITTUserDefaultCacheDao 和 ITTFileCacheDao 方式
//  修改setup方法可改变Dao
//
//  Created by lian jie on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  Modified by Sword on 9/9/2013
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
	DataCacheManagerCacheTypeMemory,
	DataCacheManagerCacheTypePersist
} DataCacheManagerCacheType;

typedef enum : NSUInteger{
    ITTDataCacheNone,
	ITTDataCacheUserDefault,
	ITTDataCacheFile
} ITTDataCacheType;

@interface ITTDataCacheManager : NSObject
{
    
}

@property (nonatomic, assign) ITTDataCacheType dataCacheType;

+ (ITTDataCacheManager *)sharedManager;

/*!
 * @param key the key
 * @returns Returns a Boolean value that indicates whether a given object is present in the local disk and memory cache pool
 */
- (BOOL)hasObjectInCacheByKey:(NSString*)key;

/*!
 * Returns a Boolean value that indicates whether a given object is present in the local disk and memory cache pool
 * @param key the key
 */
- (id)getCachedObjectByKey:(NSString*)key;

/*!
 * restore all cached objects
 */
- (void)restore;

/*!
 * clear all cached objects in disk and memory
 */
- (void)clearAllCache;

/*!
 * clear all cached objects in disk
 */
- (void)clearAllDiskCache;

/*!
 * clear all memory cached objects
 */
- (void)clearMemoryCache;

/*!
 *	cache object in memory and disk, all cache object will when user exit the app
 *	@param	obj	The object to add to the memory cache pool. This value must not be nil
 *	@param	key The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol).
 *          If aKey already exists in the dictionary anObject takes its place.
 */
- (void)addObject:(NSObject*)obj forKey:(NSString*)key;

/*!
 *	cache object in memory, all cache object will when user exit the app
 *	@param	obj	The object to add to the memory cache pool. This value must not be nil
 *	@param	key The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol).
 *          If aKey already exists in the dictionary anObject takes its place.
 */
- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key;

/*!
 *	remove cached object with specified key
 *	@param	key	The key to remove from the memory cache pool. This value must not be nil, otherwise nothing will happen
 */
- (void)removeObjectInCacheByKey:(NSString*)key;

/*!
 *	save all cached objects to disk
 */
- (void)doSave;

//by keke
/**
 *  @brief  更新已存信息
 *  @param  objClass    存储的model类型
 *  @param  key         存储的model对应的key
 @param  propertyDic 更新的model的属性 key对应属性名字 value对应属性对象
 *  @return result      返回结果。
 */
- (BOOL)updateObject:(Class)objClass forKey:(NSString*)key byPropertyDic:(NSDictionary*)propertyDic;

@end
