//
//  HSBColorModel.h
//  alarm
//
//  Created by 钟文锋  on 15/10/21.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSBColorModel : NSObject
@property (nonatomic, assign) NSInteger hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;
+ (HSBColorModel *)makerColorModel:(NSInteger)hue
                        saturation:(CGFloat)saturation
                        brightness:(CGFloat)brightness;
@end
