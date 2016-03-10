//
//  TimePickerView.m
//  alarm
//  自定义时间的PickerView
//  Created by 钟文锋  on 15/10/22.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "TimePickerView.h"
#import "TimerManager.h"
#define ArrayNum 20 //防止留白
@interface TimePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UILabel *hourLabel;//正常模式下的Label
@property (nonatomic, strong) UILabel *minuteLabel;//正常模式下的Label
@property (nonatomic, strong) UIPickerView *timePicker;

@property (nonatomic, strong) UILabel *timeSeperator;//":"号
@property (nonatomic, strong) NSMutableArray* hours;
@property (nonatomic, strong) NSMutableArray* minutes;

@property (nonatomic, assign) BOOL settingMode; //是否进入设置时间模式

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, assign) NSInteger currentHour;
@property (nonatomic, assign) NSInteger currentMinute;
@end

@implementation TimePickerView

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame
        strokeWidth:(CGFloat)strokeWidth
{
    self = [super initWithFrame:frame
                    strokeWidth:strokeWidth];
    if (self)
    {
        self.settingMode = NO;//正常模式
        
        self.currentHour = [UserDefaultsUtil getClockTimeHour];
        self.currentMinute = [UserDefaultsUtil getClockTimeMinute];
        
        [self addSubview:self.timePicker];
        [self addSubview:self.timeSeperator];
        
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuteLabel];
        
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    return self;
}
#pragma mark - public methods

- (void)touchEnabled:(BOOL)enabled
{
    self.tapGestureRecognizer.enabled = enabled;
}

#pragma mark - private methods
- (void)setTimer:(NSTimeInterval)timeInterval
{
    [[TimerManager sharedTimerManager] stopScheduledOnceTimer];
    [[TimerManager sharedTimerManager] scheduledTimerOnceWithTimeInterval:timeInterval
                                                      completionWithBlock:^{
                                                          //当设置模式时，执行动画
                                                          self.settingMode = NO;
                                                          [UIView animateWithDuration:0.5f animations:^{
                                                              self.timePicker.alpha = 0;
                                                              self.hourLabel.alpha = 1.0f;
                                                              self.minuteLabel.alpha = 1.0f;
                                                          } completion:^(BOOL finished) {
                                                              
                                                          }];
                                                      }
     ];
}

#pragma mark - gesture response
- (void)onTappedSelf:(UITapGestureRecognizer *)recognizer
{
    if (!self.settingMode) {
        NSLog(@"beginTap");
        self.settingMode = YES;
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.timePicker.alpha = 1.0f;
                             self.hourLabel.alpha = 0;
                             self.minuteLabel.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             [self setTimer:3.0];
                         }
                        ];
    }
}



#pragma mark - UIPickerViewDelegate&UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.hours count]*ArrayNum;
    }else {
        return [self.minutes count]*ArrayNum;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 40)];
    label.text = component == 0?[self.hours objectAtIndex:row%[self.hours count]]:[self.minutes objectAtIndex:row%[self.minutes count]];
    label.textColor = WhiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:kAdaptPixel*30];
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.hourLabel.text = self.hours[row%[self.hours count]];
        self.currentHour = [self.hourLabel.text integerValue];
    }else {
        self.minuteLabel.text = self.minutes[row%[self.minutes count]];
        self.currentMinute = [self.minuteLabel.text integerValue];
    }
    
    [self setTimer:3.0];

    //存储时间
    [UserDefaultsUtil saveClockTime:self.currentHour
                             minute:self.currentMinute];
}

#pragma mark - setters and getters

- (UILabel *)hourLabel
{
    if (!_hourLabel) {
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/2 - 10*kAdaptPixel, 50*kAdaptPixel)];
        _hourLabel.textColor = WhiteColor;
        _hourLabel.font = [UIFont systemFontOfSize:kAdaptPixel*35];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        NSInteger hour = [UserDefaultsUtil getClockTimeHour];
        _hourLabel.text = hour < 10?[NSString stringWithFormat:@"0%ld", (long)hour]:[NSString stringWithFormat:@"%ld", hour];
        _hourLabel.centerX = self.width/4;
        _hourLabel.centerY = self.height/2;
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel
{
    if (!_minuteLabel) {
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/2 - 10*kAdaptPixel, 50*kAdaptPixel)];
        _minuteLabel.textColor = WhiteColor;
        NSInteger minute = [UserDefaultsUtil getClockTimeMinute];
        _minuteLabel.text = minute < 10?[NSString stringWithFormat:@"0%ld", (long)minute]:[NSString stringWithFormat:@"%ld", minute];
        _minuteLabel.font = [UIFont systemFontOfSize:kAdaptPixel*35];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.centerX = self.width*3/4;
        _minuteLabel.centerY = self.height/2;
        
    }
    return _minuteLabel;
}

- (UIPickerView *)timePicker
{
    if (!_timePicker) {
        
        _timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.width - 20*kAdaptPixel, self.height - 20*kAdaptPixel)];
        _timePicker.centerX = self.width/2;
        _timePicker.centerY = self.height/2;
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
        _timePicker.showsSelectionIndicator = NO;
        _timePicker.alpha = 0;
        [_timePicker selectRow:[self.hours count]*ArrayNum/2 + [UserDefaultsUtil getClockTimeHour] inComponent:0 animated:NO];
        [_timePicker selectRow:[self.minutes count]*ArrayNum/2 + [UserDefaultsUtil getClockTimeMinute] inComponent:1 animated:NO];
    }
    return _timePicker;
}

- (UILabel *)timeSeperator
{
    if (!_timeSeperator) {
        _timeSeperator = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kAdaptPixel*10, kAdaptPixel*40)];
        _timeSeperator.font = [UIFont systemFontOfSize:30*kAdaptPixel];
        _timeSeperator.text = @":";
        _timeSeperator.textColor = WhiteColor;
        _timeSeperator.textAlignment = NSTextAlignmentCenter;
        _timeSeperator.centerX = self.width/2;
        _timeSeperator.centerY = self.height/2;
    }
    return _timeSeperator;
}

- (NSMutableArray *)hours
{
    if (!_hours) {
        _hours = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 24; i++) {
            NSString *str = i > 9?[NSString stringWithFormat:@"%ld", (long)i]:[NSString stringWithFormat:@"0%ld", i];
            [_hours addObject:str];
        }
    }
    return _hours;
}

- (NSMutableArray *)minutes
{
    if (!_minutes) {
        _minutes = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 60; i++) {
            NSString *str = i > 10?[NSString stringWithFormat:@"%ld", (long)i]:[NSString stringWithFormat:@"0%ld", i];
            [_minutes addObject:str];
        }
    }
    return _minutes;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedSelf:)];
        _tapGestureRecognizer.numberOfTapsRequired = 1;
        _tapGestureRecognizer.numberOfTouchesRequired = 1;
    }
    return _tapGestureRecognizer;
}

@end
