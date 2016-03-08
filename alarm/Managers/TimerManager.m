//
//  TimerManager.m
//  
//
//  Created by Coffee on 15/10/21.
//
//

#import "TimerManager.h"
#import <objc/runtime.h>

@interface TimerManager()

@property (nonatomic, strong) NSMutableArray *timerArray;

@property (nonatomic, strong) NSTimer *onceTimer;

@end

@implementation TimerManager

SYNTHESIZE_SINGLETON_FOR_CLASS(TimerManager)

static char blockKey;

#pragma mark - timer manager
//启动计时器
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                   completionWithBlock:(ActionBlock)block
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(onTimerScheduled)
                                                userInfo:nil
                                                 repeats:YES];
    [self.timerArray addObject:timer];
}

- (void)scheduledTimerOnceWithTimeInterval:(NSTimeInterval)timeInterval
                       completionWithBlock:(ActionBlock)block
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    _onceTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                              target:self
                                            selector:@selector(onTimerScheduled)
                                            userInfo:nil
                                             repeats:NO];

}

//移除计时器
- (void)stopScheduledTimer
{
    for (NSTimer *timer in self.timerArray) {
        [timer invalidate];
    }
}

- (void)stopScheduledOnceTimer
{
    [_onceTimer invalidate];
}

#pragma event response
- (void)onTimerScheduled
{
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block();
    }
}
#pragma mark - getters and setters

- (NSMutableArray *)timerArray
{
    if (!_timerArray) {
        _timerArray = [[NSMutableArray alloc] init];
    }
    return _timerArray;
}

@end
