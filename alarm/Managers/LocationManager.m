//
//  LocationManager.m
//  alarm
//
//  Created by 钟文锋 on 15/11/6.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationManager
SYNTHESIZE_SINGLETON_FOR_CLASS(LocationManager)

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        //最小精度  耗电量最小
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务可能尚未打开，请设置打开！");
        }
        //如果没有授权则请求授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [_locationManager requestWhenInUseAuthorization];
        }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
            _locationManager.delegate=self;
            //设置最小定位精度  节省电量
            _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            //让程序在后台不要被杀掉 
            self.locationManager.pausesLocationUpdatesAutomatically = NO;
        }
    }
    return self;
}

#pragma mark - updateLocation methods
- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"位置更新");
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"错误");
}

#pragma mark - getter and setter


@end
