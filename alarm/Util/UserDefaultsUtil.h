//
//  UserDefaultsUtil.h
//  alarm
//
//  Created by Coffee on 15/10/22.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtil : NSObject
//记录闹钟设定时间
+ (void)saveClockTime:(NSInteger)hour
               minute:(NSInteger)minute;
//获取闹钟设定时间
+ (NSInteger)getClockTimeHour;
+ (NSInteger)getClockTimeMinute;

//记录智能闹钟设定时间
+ (void)saveSmartClockTime:(NSInteger)minute;
//获取智能闹钟设定时间
+ (NSInteger)getSmartClockTime;

//记录打盹设定时间
+ (void)saveNapTime:(NSInteger)minute;
//获取打盹设定时间
+ (NSInteger)getNapTime;

//记录选择的闹钟声的行号和名字
+ (void)saveClockMusic:(NSInteger)musicIndex;
+ (void)saveClockMusicName:(NSString *)musicName;
//获取选择的闹钟声的行号和名字
+ (NSInteger)getClockMusic;
+ (NSString *)getClockMusciName;

//记录闹钟是否开启 0为开启 1为关闭
+ (void)saveClockSwitchIsOn:(NSInteger)isOn;
//获取闹钟是否开启  0为开启 1为关闭
+ (NSInteger)getClockSwitchIsOn;

//记录智能闹钟是否开启
+ (void)saveSmartClockSwitchIsOn:(BOOL)isOn;
//获取智能闹钟是否开启
+ (BOOL)getSmartClockSwitchIsOn;

//记录打盹闹钟是否开启
+ (void)saveNapClockSwitchIsOn:(BOOL)isOn;
//获取打盹闹钟是否开启
+ (BOOL)getNapClockSwitchIsOn;

//记录dailySleep表中的id
+ (void)saveDailySleepId:(NSInteger)dailyId;
//获取dailySleep表中的id
+ (NSInteger)getDailySleepId;

@end
