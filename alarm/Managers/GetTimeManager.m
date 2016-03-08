//
//  GetTimeManager.m
//  alarm
//
//  Created by 钟文锋 on 15/11/3.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "GetTimeManager.h"

@implementation GetTimeManager
SYNTHESIZE_SINGLETON_FOR_CLASS(GetTimeManager)

#pragma mark - get manager

//得到日期  年-月-日
- (NSString *)getNowDate
{
    NSString *now;
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    now = [dateFormatter stringFromDate:nowDate];
    return now;
}

//得到开始或者结束时间 时-分
- (NSString *)getTime
{
    NSString *time;
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    time = [dateFormatter stringFromDate:nowDate];
    return time;
}

@end
