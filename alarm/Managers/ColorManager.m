//
//  ColorManager.m
//  
//
//  Created by Coffee on 15/10/20.
//
//

#import "ColorManager.h"
#import "HSBColorModel.h"

@interface ColorManager()

@property (nonatomic, strong) NSMutableArray* colorArray;

@end

@implementation ColorManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ColorManager)

#pragma mark - manager get methods

//获取随机颜色数组
- (NSArray *)getRandomCGColorArray
{
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    HSBColorModel *hueModel = [self getColorModel];
    
    for (NSInteger i = 0; i < 20; i += 1) {
        UIColor *color = [UIColor colorWithHue:(hueModel.hue + i)/ 360.0
                                    saturation:hueModel.saturation
                                    brightness:hueModel.brightness + i/40.0f
                                         alpha:1 - i/50.0f];
        [colors addObject:(id)[color CGColor]];
    }
    return colors;
}

//获取颜色模型
- (HSBColorModel *)getColorModel
{
    return self.colorArray[arc4random()%(self.colorArray.count)];
}

#pragma mark - getters and setters
- (NSMutableArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject:[HSBColorModel makerColorModel:220 saturation:1.0f brightness:0.35f]];
//        [_colorArray addObject:[HSBColorModel makerColorModel:190 saturation:1.0f brightness:0.5f]];
//        [_colorArray addObject:[HSBColorModel makerColorModel:200 saturation:1.0f brightness:0.5f]];
//        [_colorArray addObject:[HSBColorModel makerColorModel:270 saturation:1.0f brightness:0.5f]];
//        [_colorArray addObject:[HSBColorModel makerColorModel:280 saturation:1.0f brightness:0.5f]];
//        [_colorArray addObject:[HSBColorModel makerColorModel:260 saturation:1.0f brightness:0.5f]];
    }
    return _colorArray;
}

@end
