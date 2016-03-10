//
//  DailyModel.h
//  alarm
//
//  Created by 钟文锋  on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString *dailyDate;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

+ (DailyModel *)makeDailyModelWithId:(NSInteger)Id
                           dailyDate:(NSString *)dailyDate
                           startTime:(NSString *)startTime
                             endTime:(NSString *)endTime;

@end
