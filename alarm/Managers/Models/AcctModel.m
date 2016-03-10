//
//  AcctModel.m
//  alarm
//
//  Created by 钟文锋  on 15/11/3.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "AcctModel.h"
#import "BusinessManager.h"

@implementation AcctModel

+ (AcctModel *)makeAcctModelWithacctX:(double)acctX
                                acctY:(double)acctY
                                acctZ:(double)acctZ
                              dailyId:(NSInteger)dailyId
{
    AcctModel *model = [[AcctModel alloc] init];
    model.acctX = acctX;
    model.acctY = acctY;
    model.acctZ = acctZ;
    model.dailyId = dailyId;
    return model;
}

@end
