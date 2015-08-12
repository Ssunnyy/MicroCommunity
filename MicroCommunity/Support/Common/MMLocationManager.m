//
//  MMLocationManager.m
//  MMLocationManager
//
//  Created by Chen Yaoqiang on 13-12-24.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "MMLocationManager.h"

@interface MMLocationManager () <CLLocationManagerDelegate> {
    //    CLLocationManager *locationManager;
}
@property (nonatomic, copy) CLLocationManager *locationManager;
@property (nonatomic, copy) LocationBlock locationBlock;
@property (nonatomic, copy) LocationZBlock locationZBlock;

@property (nonatomic, copy) CityBlock cityBlock;
@property (nonatomic, copy) AddressBlock addressBlock;
@property (nonatomic, copy) StateBlock stateBlock;

@property (nonatomic, copy) LocationErrorBlock errorBlock;
@property (nonatomic, copy) StateAndCity stateAndCityBlock;
@end

@implementation MMLocationManager

+ (MMLocationManager *)shareLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];//创建位置管理器

        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];

        float longitude = [standard floatForKey:MMLastLongitude];
        float latitude = [standard floatForKey:MMLastLatitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.lastCoordinate = CLLocationCoordinate2DMake(longitude,latitude);
        self.state = [standard objectForKey:MMLastState];
        self.lastCity = [standard objectForKey:MMLastCity];
        self.lastAddress=[standard objectForKey:MMLastAddress];
    }
    return self;
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = locaiontBlock;
    [self startToLoction];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(AddressBlock) addressBlock
{
    self.locationBlock = locaiontBlock;
    self.addressBlock = addressBlock;
    [self startToLoction];
}

- (void) getAddress:(AddressBlock)addressBlock
{
    self.addressBlock = addressBlock;
    [self startToLoction];
}

- (void) getProvince:(StateAndCity)stateandcityBlock ;
{
    self.stateAndCityBlock = stateandcityBlock;
    [self startToLoction];
}

- (void) getProvince:(StateBlock)stateBlock andCity:(CityBlock)cityBlock;
{
    self.cityBlock = cityBlock;
    self.stateBlock = stateBlock;
    [self startToLoction];
}

- (void)getState:(StateBlock)stateBlock {
    self.stateBlock = stateBlock;
    [self startToLoction];

}

- (void) getCity:(CityBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = cityBlock;
    self.errorBlock = errorBlock;
    [self startToLoction];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation * newLocation = userLocation.location;
    self.lastCoordinate=mapView.userLocation.location.coordinate;

    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];

    [standard setObject:@(self.lastCoordinate.longitude) forKey:MMLastLongitude];
    [standard setObject:@(self.lastCoordinate.latitude) forKey:MMLastLatitude];

    __block MMLocationManager *mmlocation = self;

    CLGeocoder *clGeoCoder = [CLGeocoder new] ;
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    {
        for (CLPlacemark * placeMark in placemarks)
        {
            NSDictionary *addressDic = placeMark.addressDictionary;

            NSString *state=[addressDic objectForKey:@"State"] ;
            NSString *city= [addressDic objectForKey:@"City"];
            NSString *subLocality= [addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];

            mmlocation.state = state?state:@"";
            mmlocation.lastCity = city?city:state;

            if (!city) {
                city = @"";
            }

            mmlocation.lastAddress=[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
//            NSLog(@"%@-%@-%@-%@",state,city,subLocality,street);


            [standard setObject:mmlocation.state forKey:MMLastState];
            [standard setObject:mmlocation.lastCity forKey:MMLastCity];
            [standard setObject:mmlocation.lastAddress forKey:MMLastAddress];

            //            [mmlocation stopLocation];
        }

        if (_cityBlock) {
            _cityBlock(_state?_state:_lastCity);
            _cityBlock = nil;
        }
        if (_stateAndCityBlock) {
            _stateAndCityBlock(_state?_state:_lastCity,_lastCity);
            _stateAndCityBlock = nil;
        }
        if (_locationBlock) {
            _locationBlock(_lastCoordinate);
            _locationBlock = nil;
        }

        if (_addressBlock) {
            _addressBlock(_lastAddress);
            _addressBlock = nil;
        }

        if (_stateBlock) {
            _stateBlock (_state);
            _stateBlock = nil;
        }
    };
    [[NSUserDefaults standardUserDefaults] synchronize];

    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
}

-(void)startLocation
{
    if (_mapView) {
        _mapView = nil;
    }
    _mapView = [[MKMapView alloc] init];

    _mapView.delegate = self;
}

-(void)stopLocation
{
    _mapView.showsUserLocation = NO;
    _mapView = nil;

    [_locationManager stopUpdatingLocation];

    _locationManager = nil;
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}


#pragma mark ======== newAdd =======

- (void)startGetUserLocation:(LocationZBlock )block {

    self.locationZBlock = block;
    [self startToLoction];
}
//ios8 mkmap 不好使
- (void)startToLoction
{
    if (IS_IOS8)
    {
        [_locationManager requestAlwaysAuthorization];
    }
    _locationManager.delegate=self;
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //    _locationManager.distanceFilter=1000.0f;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //启动位置更新
    [_locationManager startMonitoringSignificantLocationChanges];
    [_locationManager startUpdatingLocation];
    
}
//
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestAlwaysAuthorization];
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            //启动位置更新
            [_locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D locat = [(CLLocation*)[locations objectAtIndex:0] coordinate];

    if (self.locationZBlock) {
        self.locationZBlock(locat);
        self.locationZBlock = nil;
    }

    __block CLLocation * newLocation = [locations objectAtIndex:0];
    //NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];

    //[standard setObject:@(self.lastCoordinate.longitude) forKey:MMLastLongitude];
    //[standard setObject:@(self.lastCoordinate.latitude) forKey:MMLastLatitude];
    
    NSString *_lon=[NSString stringWithFormat:@"%f",locat.longitude];
    NSString *_lat=[NSString stringWithFormat:@"%f",locat.latitude];

    
    [USER_DEFAULT setObject:_lon forKey:MMLastLongitude];
    [USER_DEFAULT setObject:_lat forKey:MMLastLatitude];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    __block MMLocationManager *mmlocation = self;

    CLGeocoder *clGeoCoder = [CLGeocoder new] ;
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
//            NSLog(@"Get location Error! =====%@",error.description);
        }else
        {
            @autoreleasepool {


                NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];

                for (CLPlacemark * placeMark in placemarks)
                {
                    NSDictionary *addressDic = placeMark.addressDictionary;

                    NSString *state=[addressDic objectForKey:@"State"] ;
                    NSString *city= [addressDic objectForKey:@"City"];
                    NSString *subLocality= [addressDic objectForKey:@"SubLocality"];
                    NSString *street=[addressDic objectForKey:@"Street"];

                    mmlocation.state = state?state:@"";
                    mmlocation.lastCity = city?city:state;

                    if (!city) {
                        city = @"";
                    }

                    mmlocation.lastAddress=[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
//                    NSLog(@"%@-%@-%@-%@",state,city,subLocality,street);


                    [standard setObject:mmlocation.state forKey:MMLastState];
                    [standard setObject:mmlocation.lastCity forKey:MMLastCity];
                    [standard setObject:mmlocation.lastAddress forKey:MMLastAddress];

                    //            [mmlocation stopLocation];
                }

                if (_cityBlock) {
                    _cityBlock(_state?_state:_lastCity);
                    _cityBlock = nil;
                }
                if (_stateAndCityBlock) {
                    _stateAndCityBlock(_state?_state:_lastCity,_lastCity);
                    _stateAndCityBlock = nil;
                }
                if (_locationBlock) {
                    _locationBlock(_lastCoordinate);
                    _locationBlock = nil;
                }

                if (_addressBlock) {
                    _addressBlock(_lastAddress);
                    _addressBlock = nil;
                }

                if (_stateBlock) {
                    _stateBlock (_state);
                    _stateBlock = nil;
                }
                mmlocation =nil;

            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

    }];
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error  {
    NSString *errorMessage = nil;
    
    if ([error code] == kCLErrorDenied){
        
        errorMessage = @"你的访问被拒绝";}
    
    if ([error code] == kCLErrorLocationUnknown) {
        
        errorMessage = @"无法定位到你的位置!";
    }
    
//    NSLog(@"errorMessage:%@, error:%@",errorMessage,error);
}



@end
