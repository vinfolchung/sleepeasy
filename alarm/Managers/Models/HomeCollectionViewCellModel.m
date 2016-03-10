//
//  HomeCollectionViewCellModel.m
//  alarm
//
//  Created by 钟文锋  on 15/10/24.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeCollectionViewCellModel.h"

@implementation HomeCollectionViewCellModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.title = [dict objectForKey:@"title"];
        self.imageNamed = [dict objectForKey:@"imageNamed"];
        self.backgroundColor = [dict objectForKey:@"backgroundColor"];
    }
    return self;
}

+ (HomeCollectionViewCellModel *)makeHomeCollectionViewCellModel:(NSString *)title
                                                      imageNamed:(NSString *)imageNamed
                                                 backgroundColor:(UIColor *)backgroundColor
{
    HomeCollectionViewCellModel *model = [[HomeCollectionViewCellModel alloc] init];
    model.title = title;
    model.imageNamed = imageNamed;
    model.backgroundColor = backgroundColor;
    return model;
}

@end
