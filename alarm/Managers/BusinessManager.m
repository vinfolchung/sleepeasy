//
//  BusinessManager.m
//  alarm
//
//  Created by 钟文锋 on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "BusinessManager.h"
#import "DBManager.h"
#import "DailyModel.h"
#import "AcctModel.h"
@implementation BusinessManager
SYNTHESIZE_SINGLETON_FOR_CLASS(BusinessManager)

#pragma mark - insert manager
- (void)insertIntoDailySleepId:(NSInteger)Id
                     dailyDate:(NSString *)dailyDate
                     startTime:(NSString *)startTime;
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DailySleep (Id,dailyDate ,startTime) VALUES( '%ld','%@' ,'%@')",(long)Id,dailyDate,startTime];
    if ([[DBManager sharedDBManager] databaseInsert:sql]) {
        NSLog(@"插入dailysleep成功!");
    }
    [[DBManager sharedDBManager].database close];
    
}

- (void)updateDailySleepId:(NSInteger)Id
                   endTime:(NSString *)endTime
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE DailySleep SET endTime = '%@' WHERE Id = '%ld'",endTime,Id];
    if ([[DBManager sharedDBManager] databaseInsert:sql]) {
         NSLog(@"更新dailysleep成功!");
    }
    [[DBManager sharedDBManager].database close];
}

- (void)insertIntoAcctMeteracctX:(double)acctX
                           acctY:(double)acctY
                           acctZ:(double)acctZ
                         dailyId:(NSInteger)dailyId
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO AcctMeter (acctX ,acctY ,acctZ ,dailyId) VALUES ('%f' ,'%f' ,'%f','%ld')",acctX,acctY,acctZ,(long)dailyId];
    if ([[DBManager sharedDBManager] databaseInsert:sql]) {
        NSLog(@"插入acctmeter成功!");
    }
    [[DBManager sharedDBManager].database close];
}

#pragma mark - get manager
- (NSMutableArray *)getDataFromDailySleep
{
    NSMutableArray *dailyArr = [[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM DailySleep";
    FMResultSet *set = [[DBManager sharedDBManager] databaseSelect:sql];
    while ([set next]) {
        NSInteger Id = [set intForColumn:@"Id"];
        NSString *dailyDate = [set stringForColumn:@"dailyDate"];
        NSString *startTime = [set stringForColumn:@"startTime"];
        NSString *endTime = [set stringForColumn:@"endTime"];
        [dailyArr addObject:[DailyModel makeDailyModelWithId:Id dailyDate:dailyDate startTime:startTime endTime:endTime]];
    }
    return dailyArr;
}

- (NSMutableArray *)getDataFromAcctMeterWithDailyId:(NSInteger)Id
{
    NSMutableArray *acctArr = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM AcctMeter WHERE dailyId  = '%ld'",Id];
    FMResultSet *set = [[DBManager sharedDBManager] databaseSelect:sql];
    while ([set next]) {
        double acctX = [set doubleForColumn:@"acctX"];
        double acctY = [set doubleForColumn:@"acctY"];
        double acctZ = [set doubleForColumn:@"acctZ"];
        NSInteger dailyId = [set intForColumn:@"dailyId"];
        [acctArr addObject:[AcctModel makeAcctModelWithacctX:acctX acctY:acctY acctZ:acctZ dailyId:dailyId]];
    }
    [[DBManager sharedDBManager].database close];
    return acctArr;
}



@end
