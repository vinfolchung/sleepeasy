//
//  RecordingCircleOverlayView.m
//
//
//  Created by Coffee on 15/10/18.
//
//


#import "RecordingCircleOverlayView.h"
#define ShadowRadiusStart 2.0f
#define ShadowRadiusEnd 8.0f
@interface RecordingCircleOverlayView ()

@property (nonatomic, strong) UIBezierPath *circlePath;

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@property (nonatomic, assign) CGFloat strokeWidth;

@property (nonatomic, assign) NSInteger animationCounter;//计数器

@end

@implementation RecordingCircleOverlayView

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame
        strokeWidth:(CGFloat)strokeWidth
{
    if (self = [super initWithFrame:frame])
    {
        self.strokeWidth = strokeWidth;
        self.animationCounter = 0;
        [self.layer addSublayer:self.backgroundLayer];
        [self performAnimation:ShadowRadiusStart
                     endRadius:ShadowRadiusEnd];
    }
    return self;
}
#pragma mark - private methods
//执行动画
- (void)performAnimation:(CGFloat)startRadius
               endRadius:(CGFloat)endRadius
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    animation.fromValue = @(startRadius);
    animation.toValue = @(endRadius);
    animation.duration = 1.0f;
    animation.delegate = self;
    [self.backgroundLayer addAnimation:animation forKey:@"shadowAnimation"];
}

#pragma mark - CAAnimation Delegate
//重复执行动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.animationCounter++;
    [self performAnimation:self.animationCounter%2 == 0?ShadowRadiusStart:ShadowRadiusEnd
                 endRadius:self.animationCounter%2 == 0?ShadowRadiusEnd:ShadowRadiusStart];

}

#pragma mark - getters and setters

- (UIBezierPath *)circlePath
{
    if (!_circlePath) {
        CGPoint arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds);
        
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                         radius:radius
                                                     startAngle:M_PI
                                                       endAngle:-M_PI
                                                      clockwise:NO];

    }
    return _circlePath;
}


- (CAShapeLayer *)backgroundLayer
{
    if (!_backgroundLayer) {
        
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.path = self.circlePath.CGPath;
        _backgroundLayer.strokeColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        _backgroundLayer.fillColor = [[UIColor clearColor] CGColor];
        _backgroundLayer.lineWidth = self.strokeWidth;
        _backgroundLayer.shadowColor = [UIColor whiteColor].CGColor;
        _backgroundLayer.shadowOffset = CGSizeMake(0,0);
        _backgroundLayer.shadowOpacity = 1;
        _backgroundLayer.shadowRadius = ShadowRadiusStart;
    }
    return _backgroundLayer;
}

@end
