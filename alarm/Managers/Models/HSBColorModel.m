//
//  HSBColorModel.m
//  alarm
//
//  Created by Coffee on 15/10/21.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "HSBColorModel.h"

@implementation HSBColorModel
+ (HSBColorModel *)makerColorModel:(NSInteger)hue
                        saturation:(CGFloat)saturation
                        brightness:(CGFloat)brightness
{
    HSBColorModel *colorModel = [[HSBColorModel alloc] init];
    colorModel.hue = hue;
    colorModel.saturation = saturation;
    colorModel.brightness = brightness;
    return colorModel;
}
@end
