//
//  LocationManager.h
//  alarm
//
//  Created by 钟文锋 on 15/11/6.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SingletonTemplate.h"

@interface LocationManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(LocationManager)

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
