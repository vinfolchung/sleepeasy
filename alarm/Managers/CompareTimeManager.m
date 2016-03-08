//
//  CompareTimeManager.m
//  alarm
//  发送一个本地通知
//  Created by 钟文锋 on 15/10/23.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "CompareTimeManager.h"
#import "TimePickerView.h"
#import "BusinessManager.h"


@implementation CompareTimeManager
SYNTHESIZE_SINGLETON_FOR_CLASS(CompareTimeManager)


#pragma mark - compareTime Method
//发送一个本地通知
- (void)compareClockTimeWithMusicName:(NSString *)musicName
                        smartInterVal:(NSInteger)smartInterval
                          napInterval:(NSInteger)napInterval
{
    NSDate *nowTime = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unit = NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *components = [cal components:unit fromDate:nowTime];
    NSInteger nowHour = [components hour];
    NSInteger nowMin = [components minute];
    NSInteger nowSec = [components second];
    
    NSInteger setHour = [UserDefaultsUtil getClockTimeHour];
    NSInteger setMinute = [UserDefaultsUtil getClockTimeMinute];
    if (setHour == 0) {
        setHour = 24;
    }
    NSInteger hn = setHour - nowHour;
    NSInteger mn = setMinute - nowMin;
    if (mn<0) {
        mn=mn+60;
        hn=hn-1;
    }
    if (hn<0) {
        hn=hn+24;
    }
    //闹钟时间与现在时间的间隔
    NSInteger ringInterval = (hn*3600)+(mn*60) - nowSec - smartInterval*60 + napInterval*60;
    UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notiSettings];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    if (localNotification != nil) {
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        //闹钟响的时间是什么时候
        localNotification.fireDate = [nowTime dateByAddingTimeInterval:ringInterval];
        localNotification.soundName = [NSString stringWithFormat:@"%@.m4r",musicName];
        localNotification.alertBody = @"闹钟响了";
        localNotification.alertAction = @"锁屏提示！";
        localNotification.applicationIconBadgeNumber += 1;
        //发送通知
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"notificationID" forKey:@"id"];
        localNotification.userInfo = infoDic;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void)sendLocalNotification
{
    NSString *clockMusicName = [UserDefaultsUtil getClockMusciName];
    NSInteger smartInterval = [UserDefaultsUtil getSmartClockTime];
    NSInteger napInterval = [UserDefaultsUtil getNapTime];
    if ([UserDefaultsUtil getClockSwitchIsOn] == 0) {
        [self compareClockTimeWithMusicName:clockMusicName
                              smartInterVal:0
                                napInterval:0];
        NSLog(@"发送闹钟通知！");
        //智能闹钟开启
        if ([UserDefaultsUtil getSmartClockSwitchIsOn] == YES) {
            [self compareClockTimeWithMusicName:clockMusicName
                                  smartInterVal:smartInterval
                                    napInterval:0];
            NSLog(@"智能闹钟开启！");
        }
        //打盹闹钟开启
        if ([UserDefaultsUtil getNapClockSwitchIsOn] == YES) {
            for (int i = 1;i <= 100; i++) {
                [self compareClockTimeWithMusicName:clockMusicName
                                      smartInterVal:0
                                        napInterval:(napInterval * i)];
            }
            NSLog(@"打盹闹钟开启!");
        }
    }

}

@end
