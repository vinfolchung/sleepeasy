//
//  DailyModel.m
//  alarm
//
//  Created by 钟文锋  on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "DailyModel.h"
#import "BusinessManager.h"

@implementation DailyModel

+ (DailyModel *)makeDailyModelWithId:(NSInteger)Id
                           dailyDate:(NSString *)dailyDate
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime;
{
    DailyModel *model = [[DailyModel alloc] init];
    model.Id = Id;
    model.dailyDate = dailyDate;
    model.startTime = startTime;
    model.endTime = endTime;
    return model;
}

@end
