//
//  MMLocationManager.h
//  MMLocationManager
//
//  Created by Chen Yaoqiang on 13-12-24.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define  MMLastLongitude @"MMLastLongitude"
#define  MMLastLatitude  @"MMLastLatitude"
#define  MMLastCity      @"MMLastCity"
#define  MMLastAddress   @"MMLastAddress"
#define  MMLastState     @"MMLastState"

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void (^LocationZBlock) (CLLocationCoordinate2D locationCorrrdinate);
typedef void(^ CityBlock)(NSString *cityString);
typedef void(^ AddressBlock)(NSString *addressString);
typedef void(^ StateBlock) (NSString *state);
typedef void(^ StateAndCity) (NSString *state,NSString * city);

@interface MMLocationManager : NSObject<MKMapViewDelegate>

@property(nonatomic,strong) MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
@property(nonatomic,strong)NSString *lastCity;
@property (nonatomic,strong) NSString *lastAddress;
@property (nonatomic,strong) NSString *state;

@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;

+ (MMLocationManager *)shareLocation;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock ;

/**
 *  获取坐标和地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(AddressBlock) addressBlock;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(AddressBlock)addressBlock;

/**
 *  获取省份
 *
 *  @param stateBlock stateBlock description
 */
- (void) getState:(StateBlock)stateBlock;


/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(CityBlock)cityBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getProvince:(StateAndCity)stateandcityBlock ;


/**
 *  获取城市和定位失败
 *
 *  @param cityBlock  cityBlock description
 *  @param errorBlock errorBlock description
 */
- (void) getCity:(CityBlock)cityBlock error:(LocationErrorBlock) errorBlock;
/**
 *  定时获取位置
 */
- (void)startGetUserLocation:(LocationZBlock )block ;



@end
