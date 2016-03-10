//
//  AccelerometerManager.h
//  alarm
//
//  Created by 钟文锋 on 15/11/2.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "SingletonTemplate.h"

@interface AccelerometerManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(AccelerometerManager)
//启动加速度传感器获取数据
- (void)startAccelerometerWithDailyId:(NSInteger)dailyId;
//停止加速度传感器获取数据
- (void)stopAccelerometer;
@end
