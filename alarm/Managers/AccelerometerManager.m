//
//  AccelerometerManager.m
//  alarm
//
//  Created by 钟文锋 on 15/11/2.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "AccelerometerManager.h"
#import "BusinessManager.h"

@interface AccelerometerManager()
@property (nonatomic,strong) CMMotionManager *motionManager;

@end

@implementation AccelerometerManager
SYNTHESIZE_SINGLETON_FOR_CLASS(AccelerometerManager)

//启动加速器获取数据
- (void)startAccelerometerWithDailyId:(NSInteger)dailyId
{
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    //加速计 每5秒发送一个数据到数据库
    if(self.motionManager.accelerometerAvailable){
        self.motionManager.accelerometerUpdateInterval = 15.0;
        [self.motionManager startAccelerometerUpdatesToQueue:queue
                                            withHandler:^(CMAccelerometerData *accelerometerData,NSError *error){
            if(error){
                [self.motionManager stopAccelerometerUpdates];
            }else{
                [[BusinessManager sharedBusinessManager] insertIntoAcctMeteracctX:accelerometerData.acceleration.x acctY:accelerometerData.acceleration.y acctZ:accelerometerData.acceleration.z dailyId:dailyId];
            }
        }];
    }
    else{
        NSLog(@"This device has no accelerometer");
    }
}

- (void)stopAccelerometer
{
    [self.motionManager stopAccelerometerUpdates];
}


#pragma mark - getter and setter
- (CMMotionManager *)motionManager
{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

@end
