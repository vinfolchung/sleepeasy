//
//  AcctModel.h
//  alarm
//
//  Created by 钟文锋  on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcctModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) double acctX;
@property (nonatomic, assign) double acctY;
@property (nonatomic, assign) double acctZ;
@property (nonatomic, assign) NSInteger dailyId;

+ (AcctModel *)makeAcctModelWithacctX:(double)acctX
                                acctY:(double)acctY
                                acctZ:(double)acctZ
                              dailyId:(NSInteger)dailyId;

@end
