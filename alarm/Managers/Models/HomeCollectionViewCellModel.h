//
//  HomeCollectionViewCellModel.h
//  alarm
//
//  Created by 钟文锋  on 15/10/24.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCollectionViewCellModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* imageNamed;
@property (nonatomic, strong) UIColor *backgroundColor;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (HomeCollectionViewCellModel *)makeHomeCollectionViewCellModel:(NSString *)title
                                                      imageNamed:(NSString *)imageNamed
                                                 backgroundColor:(UIColor *)backgroundColor;

@end
