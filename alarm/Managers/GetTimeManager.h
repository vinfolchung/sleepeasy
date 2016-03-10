//
//  GetTimeManager.h
//  alarm
//
//  Created by 钟文锋 on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"

@interface GetTimeManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(GetTimeManager)

- (NSString *)getNowDate;
- (NSString *)getTime;

@end
