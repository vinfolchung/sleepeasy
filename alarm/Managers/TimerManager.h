//
//  TimerManager.h
//  
//
//  Created by Coffee on 15/10/21.
//
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"

typedef void (^ActionBlock)();

@interface TimerManager : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(TimerManager)
//启动周期性计时器
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                   completionWithBlock:(ActionBlock)block;
//启动一次性计时器
- (void)scheduledTimerOnceWithTimeInterval:(NSTimeInterval)timeInterval
                       completionWithBlock:(ActionBlock)block;
//移除所有周期计时器
- (void)stopScheduledTimer;
//移除一次性计时器
- (void)stopScheduledOnceTimer;
@end
