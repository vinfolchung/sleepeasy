//
//  BlurredColorBackgroundView.m
//  
//
//  Created by Coffee on 15/10/18.
//
//

#import "BlurredColorBackgroundView.h"
#import "ColorManager.h"
#import "TimerManager.h"
#define timerScheduledTimeInterval 10.0f

@interface BlurredColorBackgroundView()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation BlurredColorBackgroundView

#pragma mark - life cycle

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.layer addSublayer:self.gradientLayer];
        

        
        [self setTimer];
    }
    return self;
}

#pragma mark - private methods

//启动计时器
- (void)setTimer
{
    [[TimerManager sharedTimerManager] scheduledTimerWithTimeInterval:timerScheduledTimeInterval
                                                  completionWithBlock:^{

      _gradientLayer.colors = [[ColorManager sharedColorManager] getRandomCGColorArray];

    }];
}



#pragma getters and setters

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        //设置渐变颜色方向
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
        //设定颜色组
        _gradientLayer.colors = [[ColorManager sharedColorManager] getRandomCGColorArray];
        //设定颜色分割点
//        _gradientLayer.locations = @[@(0.25), @(0.5), @(0.75)];
    }
    return _gradientLayer;
}

@end
