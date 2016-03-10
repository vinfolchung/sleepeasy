//
//  HomeViewController.m
//  alarm
//
//  Created by 钟文锋  on 15/10/21.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeViewController.h"
#import "TimePickerView.h"
#import "CompareTimeManager.h"
#import "ClockSettingViewController.h"
#import "HomeCollectionView.h"
#import "BaseNavigationController.h"
#import "AccelerometerManager.h"
#import "BusinessManager.h"
#import "GetTimeManager.h"
#import "DailyModel.h"
#import "AcctModel.h"
#import "LocationManager.h"
@interface HomeViewController ()<HomeCollectionViewDelegate>

@property (nonatomic, strong) TimePickerView *timePickerView;
@property (nonatomic, strong) BaseNavigationController *clockSettingNVC;
@property (nonatomic, strong) ClockSettingViewController *clockSettingVC;
@property (nonatomic, strong) HomeCollectionView *homeCollectionView;
@property (nonatomic, strong) UIBarButtonItem* leftBarButtonItem;
@property (nonatomic, strong) UIButton *analysisBtn;//分析按钮
@property (nonatomic, strong) UIButton *startBtn;//开始按钮
@property (nonatomic, strong) UIButton *stopBtn;//停止按钮
@end

@implementation HomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    self.isGradientBackground = YES;
    [super viewDidLoad];
    [self.view addSubview:self.timePickerView];
    [self.view addSubview:self.homeCollectionView];
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.analysisBtn];
    [self.view addSubview:self.stopBtn];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [super viewWillAppear:animated];
    [self.timePickerView setCenter:CGPointMake(kScreen_Width/2, kScreen_Width/2)];
    [self.startBtn setCenter:CGPointMake(kScreen_Width/4 + 10*kAdaptPixel, CGRectGetMaxY(self.timePickerView.frame) + 50*kAdaptPixel)];
    [self.analysisBtn setCenter:CGPointMake(kScreen_Width*3/4 - 10*kAdaptPixel, self.startBtn.centerY)];
    [self.stopBtn setCenter:CGPointMake(kScreen_Width/2, kScreen_Height + 50*kAdaptPixel)];
}

#pragma mark - private methods
- (void)performStartAnimation
{
    [self.timePickerView touchEnabled:NO];
    [UIView animateWithDuration:0.3f animations:^{
        self.timePickerView.center = CGPointMake(self.view.width/2, self.view.height/2);
        self.stopBtn.alpha = 1.0f;
        self.homeCollectionView.alpha = 0;
        self.analysisBtn.alpha = 0;
        self.analysisBtn.centerX = kScreen_Width + self.analysisBtn.width;
        self.startBtn.alpha = 0;
        self.startBtn.centerX = -self.startBtn.width;
        self.stopBtn.centerY = kScreen_Height - 60*kAdaptPixel;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.3f animations:^{
            self.timePickerView.centerY = self.timePickerView.centerY - 15*kAdaptPixel;
            self.stopBtn.centerY = kScreen_Height - 50*kAdaptPixel;
        }];
    }];
}

- (void)performStopAnimation
{
    [self.timePickerView touchEnabled:YES];
    [UIView animateWithDuration:0.3f animations:^{
        self.timePickerView.center = CGPointMake(kScreen_Width/2, kScreen_Width/2);
        self.stopBtn.alpha = 0;
        self.homeCollectionView.alpha = 1.0;
        self.analysisBtn.alpha = 1.0;
        self.analysisBtn.centerX = kScreen_Width*3/4 - 15*kAdaptPixel;
        self.startBtn.alpha = 1.0;
        self.startBtn.centerX = kScreen_Width/4 + 15*kAdaptPixel;
        self.stopBtn.centerY = kScreen_Height + 50*kAdaptPixel;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            self.analysisBtn.centerX = kScreen_Width*3/4 - 10*kAdaptPixel;
            self.startBtn.centerX = kScreen_Width/4 + 10*kAdaptPixel;
        }];
    }];
}

#pragma mark - override methods
- (UIBarButtonItem *)getLeftBarButtonItem
{
    return self.leftBarButtonItem;
}

- (void)didSelectItem:(NSMutableArray *)modelArray
{
    
}

#pragma mark - event response

- (void)onClockBarButtonItemClicked:(id)sender
{
    [self presentViewController:self.clockSettingNVC animated:YES completion:^{}];
}

- (void)onAnalysisBtnClicked:(id)sender
{
    DailyModel *dailyModel = (DailyModel *)[[BusinessManager sharedBusinessManager] getDataFromDailySleep][[UserDefaultsUtil getDailySleepId] - 1];
    NSLog(@"%ld,%@,%@,%@",dailyModel.Id,dailyModel.dailyDate,dailyModel.startTime,dailyModel.endTime);
    for (int i = 0; i < [[BusinessManager sharedBusinessManager] getDataFromAcctMeterWithDailyId:[UserDefaultsUtil getDailySleepId] - 1].count; i++) {
        AcctModel *acctModel = (AcctModel *)[[BusinessManager sharedBusinessManager] getDataFromAcctMeterWithDailyId:[UserDefaultsUtil getDailySleepId] - 1][i];
        NSLog(@"%f,%f,%f,%ld",acctModel.acctX,acctModel.acctY,acctModel.acctZ,acctModel.dailyId);
    }
}

- (void)onStartBtnClicked:(id)sender
{
    [self performStartAnimation];
    [self.leftBarButtonItem setEnabled:NO];
    //发送一个闹钟通知
    [[CompareTimeManager sharedCompareTimeManager] sendLocalNotification];
    //开始时往dailySleep表里插入日期，开始时间
    NSString *dailyDate = [[GetTimeManager sharedGetTimeManager] getNowDate];
    NSString *startTime = [[GetTimeManager sharedGetTimeManager] getTime];
    [[BusinessManager sharedBusinessManager] insertIntoDailySleepId:[UserDefaultsUtil getDailySleepId] dailyDate:dailyDate startTime:startTime];
    //启动加速度传感器获取数据
    [[AccelerometerManager sharedAccelerometerManager] startAccelerometerWithDailyId:[UserDefaultsUtil getDailySleepId]];
    //启动位置更新，让程序可以在后台运行
    //[[LocationManager sharedLocationManager] startUpdatingLocation];
}

- (void)onStopBtnClicked:(id)sender
{
    [self performStopAnimation];
    [self.leftBarButtonItem setEnabled:YES];
    //取消全部通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //更新dailySleep表  插入endTime
    NSString *endTime = [[GetTimeManager sharedGetTimeManager] getTime];
    [[BusinessManager sharedBusinessManager] updateDailySleepId:[UserDefaultsUtil getDailySleepId] endTime:endTime];
    [UserDefaultsUtil saveDailySleepId:([UserDefaultsUtil getDailySleepId]+1)];
    //停止加速度传感器获取数据
    [[AccelerometerManager sharedAccelerometerManager] stopAccelerometer];
    //停止位置更新
    //[[LocationManager sharedLocationManager] stopUpdatingLocation];
}

#pragma mark - getters view setter
- (UIButton *)createBtn:(NSString *)title
               selector:(SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150*kAdaptPixel, 45*kAdaptPixel)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:19*kAdaptPixel]];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn setBackgroundColor:TextBackgroundColor];
    [btn.layer setCornerRadius:6.0f*kAdaptPixel];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


#pragma mark - getters and setters
- (TimePickerView *)timePickerView
{
    if (!_timePickerView) {
        _timePickerView = [[TimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width/2, kScreen_Width/2)
                                                    strokeWidth:2.0f];
    }
    return _timePickerView;
}

- (UINavigationController *)clockSettingNVC
{
    if (!_clockSettingNVC) {
        _clockSettingNVC = [[BaseNavigationController alloc] initWithRootViewController:self.clockSettingVC];
    }
    return _clockSettingNVC;
}

- (ClockSettingViewController *)clockSettingVC
{
    if (!_clockSettingVC) {
        _clockSettingVC = [[ClockSettingViewController alloc] init];
    }
    return _clockSettingVC;
}

- (HomeCollectionView *)homeCollectionView
{
    if (!_homeCollectionView) {
        _homeCollectionView = [[HomeCollectionView alloc] initWithFrame:CGRectMake(0, kScreen_Height/2 + 50*kAdaptPixel, kScreen_Width, 200*kAdaptPixel)];
        _homeCollectionView.homeDelegate = self;
    }
    return _homeCollectionView;
}

- (UIButton *)analysisBtn
{
    if (!_analysisBtn) {
        _analysisBtn = [self createBtn:@"统计分析" selector:@selector(onAnalysisBtnClicked:)];
    }
    return _analysisBtn;
}

- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [self createBtn:@"开始睡眠" selector:@selector(onStartBtnClicked:)];
    }
    return _startBtn;
}

- (UIButton *)stopBtn
{
    if (!_stopBtn) {
        _stopBtn = [self createBtn:@"停止" selector:@selector(onStopBtnClicked:)];
        _stopBtn.alpha = 0;
    }
    return _stopBtn;
}

- (UIBarButtonItem *)leftBarButtonItem
{
    if (!_leftBarButtonItem) {
        UIBarButtonItem *clockBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"闹钟"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(onClockBarButtonItemClicked:)];
        clockBarButtonItem.tintColor = WhiteColor;
        _leftBarButtonItem = clockBarButtonItem;
    }
    return _leftBarButtonItem;
}

@end
