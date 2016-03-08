//
//  DBManager.m
//  alarm
//
//  Created by Coffee on 15/11/3.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "DBManager.h"
#define CREATE_TABLE_AcctMeter @"CREATE TABLE IF NOT EXISTS AcctMeter (Id integer, acctX double not null, acctY double not null, acctZ double not null, dailyId integer not null, primary key (Id), foreign key (dailyId) references DailySleep(Id) on delete cascade on update cascade)"
#define CREATE_TABLE_DailySleep @"CREATE TABLE IF NOT EXISTS DailySleep (Id integer primary key, dailyDate text not null, startTime text, endTime text)"

@interface DBManager()

@end

@implementation DBManager

SYNTHESIZE_SINGLETON_FOR_CLASS(DBManager)
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDataTable:CREATE_TABLE_DailySleep];
        [self createDataTable:CREATE_TABLE_AcctMeter];
    }
    return self;
}

#pragma mark - invoking methods
/*
 插入数据
 */
- (BOOL)databaseInsert:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    [self.database open];
    BOOL result = [self.database executeUpdate:sql,args];
    [self.database close];
    return result;
}

- (FMResultSet *)databaseSelect:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    [self.database open];
    FMResultSet *fmResultSet = [self.database executeQuery:sql,args];
    return fmResultSet;
}

#pragma mark - private methods
- (BOOL)createDataTable:(NSString *)sql
{
    if ([self.database open]) {
        BOOL result = [self.database executeUpdate:sql];
        //打开外键支持
        [self.database executeQuery:@"PRAGMA foreigh_keys = ON"];
        [self.database close];
        return result;
    }else {
        return NO;
    }
}

#pragma mark - getters and setters
- (FMDatabase *)database
{
    if (!_database) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"SleepEasy.db"];
        _database = [FMDatabase databaseWithPath:dbPath];
        [_database setShouldCacheStatements:YES];
    }
    return _database;
}


@end
