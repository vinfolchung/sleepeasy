//
//  UserDefaultsUtil.m
//  alarm
//
//  Created by Coffee on 15/10/22.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "UserDefaultsUtil.h"
#define Default_Hour @"default_hour"
#define Default_Minute @"default_minute"
#define Default_SmartMinute @"default_smartMinute"
#define Default_NapMinute @"default_napMinute"
#define Default_MusicIndex @"default_musicIndex"
#define Default_MusicName @"default_musicName"
#define Default_ClockSwitchIsOn @"default_clockSwitchIsOn"
#define Default_SmartClockSwitchIsOn @"default_smartClockSwitchIsOn"
#define Default_NapClockSwitchIsOn @"default_napClockSwitchIsOn"
#define Default_DailySleepId @"default_dailySleepId"
@implementation UserDefaultsUtil

#pragma mark - clockTime UserDefault
//记录时间
+ (void)saveClockTime:(NSInteger)hour
               minute:(NSInteger)minute
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:hour forKey:Default_Hour];
    [userDefaults setInteger:minute forKey:Default_Minute];
    [userDefaults synchronize];
}
//获取时间
+ (NSInteger)getClockTimeHour
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:Default_Hour];
}
+ (NSInteger)getClockTimeMinute
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:Default_Minute];
}

#pragma mark - smratClockTime UserDefault
//记录智能闹钟时间
+ (void)saveSmartClockTime:(NSInteger)minute
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:minute forKey:Default_SmartMinute];
    [userDefault synchronize];
}
//获取智能闹钟时间
+ (NSInteger)getSmartClockTime
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault integerForKey:Default_SmartMinute];
}

#pragma mark - napTime UserDefault
//记录打盹时间
+ (void)saveNapTime:(NSInteger)minute
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:minute forKey:Default_NapMinute];
    [userDefault synchronize];
}
//获取打盹时间
+ (NSInteger)getNapTime
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault integerForKey:Default_NapMinute];
}

#pragma mark - ClockMusic UserDefault
//保存选择的闹钟声
+ (void)saveClockMusic:(NSInteger)musicIndex
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:musicIndex forKey:Default_MusicIndex];
    [userDefault synchronize];
}
+ (void)saveClockMusicName:(NSString *)musicName
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:musicName forKey:Default_MusicName];
    [userDefault synchronize];

}
//获取选择的闹钟声
+ (NSInteger)getClockMusic
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault integerForKey:Default_MusicIndex];
}
+ (NSString *)getClockMusciName
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:Default_MusicName];
}

#pragma mark - ClcokSwitch UserDefault
//记录闹钟是否开启 0为开启 1为关闭
+ (void)saveClockSwitchIsOn:(NSInteger)isOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:isOn forKey:Default_ClockSwitchIsOn];
    [userDefault synchronize];
}
//获取闹钟是否开启  0为开启 1为关闭
+ (NSInteger)getClockSwitchIsOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault integerForKey:Default_ClockSwitchIsOn];
}

#pragma mark - SmartClock UserDefault
//记录智能闹钟是否开启
+ (void)saveSmartClockSwitchIsOn:(BOOL)isOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isOn forKey:Default_SmartClockSwitchIsOn];
    [userDefault synchronize];
}
//获取智能闹钟是否开启
+ (BOOL)getSmartClockSwitchIsOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:Default_SmartClockSwitchIsOn];
}

#pragma mark - NapClock UserDefault
//记录打盹闹钟是否开启
+ (void)saveNapClockSwitchIsOn:(BOOL)isOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isOn forKey:Default_NapClockSwitchIsOn];
    [userDefault synchronize];

}
//获取打盹闹钟是否开启
+ (BOOL)getNapClockSwitchIsOn
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:Default_NapClockSwitchIsOn];
}

//记录dailySleep表中的id
+ (void)saveDailySleepId:(NSInteger)dailyId
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:dailyId forKey:Default_DailySleepId];
    [userDefault synchronize];
}
//获取dailySleep表中的id
+ (NSInteger)getDailySleepId
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault integerForKey:Default_DailySleepId];
}

@end
