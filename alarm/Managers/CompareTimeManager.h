//
//  CompareTimeManager.h
//  alarm
//
//  Created by 钟文锋 on 15/10/23.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"

@interface CompareTimeManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(CompareTimeManager)

- (void)sendLocalNotification;

@end
