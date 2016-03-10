//
//  BusinessManager.h
//  alarm
//
//  Created by 钟文锋 on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
@interface BusinessManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(BusinessManager)

- (void)insertIntoDailySleepId:(NSInteger)Id
                     dailyDate:(NSString *)dailyDate
                     startTime:(NSString *)startTime;

- (void)updateDailySleepId:(NSInteger)Id
                   endTime:(NSString *)endTime;

- (void)insertIntoAcctMeteracctX:(double)acctX
                           acctY:(double)acctY
                           acctZ:(double)acctZ
                         dailyId:(NSInteger)dailyId;

- (NSMutableArray *)getDataFromDailySleep;
- (NSMutableArray *)getDataFromAcctMeterWithDailyId:(NSInteger)Id;


@end
