//
//  DBManager.h
//  alarm
//
//  Created by Coffee on 15/11/3.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "SingletonTemplate.h"
@interface DBManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(DBManager)
@property (nonatomic, strong) FMDatabase *database;
/*
 以附带参数的形式插入数据
 */
- (BOOL)databaseInsert:(NSString *)sql,...;
- (FMResultSet *)databaseSelect:(NSString *)sql,...;

@end
