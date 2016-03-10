//
//  ClockSettingViewController.m
//  alarm
//
//  Created by 钟文锋 on 15/10/23.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "ClockSettingViewController.h"
#import "ClockSettingView.h"
#import "MusicSeletedViewController.h"
#import "BaseNavigationController.h"

@interface ClockSettingViewController ()<ClockSettingViewDelegate,MusicSeletedVCDelegate>


@property (nonatomic,strong) BaseNavigationController *musicSeletedNVC;
@property (nonatomic,strong) MusicSeletedViewController *musicSeletedVC;

@end

@implementation ClockSettingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.clockSettingView];
}

#pragma mark - ClockSettingViewDelegate
//点击音乐选择
- (void)didSelectSound
{
    self.musicSeletedVC.navigationItem.leftBarButtonItem.tintColor = [UIColor cyanColor];
    self.musicSeletedVC.isBackBarButtonItem = YES;
    self.musicSeletedVC.hidesBottomBarWhenPushed = YES;
    self.musicSeletedVC.delegate = self;
    [self.navigationController pushViewController:self.musicSeletedVC animated:YES];
}
//选择音乐刷新
#pragma mark - MusicSeletedVCDelegate
- (void)getMusicName:(NSString *)musicName
{
    //[UserDefaultsUtil saveClockMusicName:musicName];
    self.clockSettingView.musicNameLabel.text = [UserDefaultsUtil getClockMusciName];
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.clockSettingView.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - override methods
- (NSString *)navigationItemTitle
{
    return @"闹钟设置";
}
- (UIBarButtonItem *)getRightBarButtonItem
{
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(dismissController:)];
    doneBarButtonItem.tintColor = [UIColor cyanColor];
    return doneBarButtonItem;
}

#pragma mark - event response

- (void)dismissController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - getters and setters
- (ClockSettingView *)clockSettingView
{
    if (!_clockSettingView) {
        _clockSettingView = [[ClockSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _clockSettingView.delegate = self;
    }
    return _clockSettingView;
}

- (BaseNavigationController *)musicSeletedNVC
{
    if (!_musicSeletedNVC) {
        _musicSeletedNVC = [[BaseNavigationController alloc] initWithRootViewController:self.musicSeletedVC];
    }
    return _musicSeletedNVC;
}

- (MusicSeletedViewController *)musicSeletedVC
{
    if (!_musicSeletedVC) {
        _musicSeletedVC = [[MusicSeletedViewController alloc] init];
        _musicSeletedVC.delegate = self;
    }
    return _musicSeletedVC;
}

@end
