//
//  MusicSeletedViewController.m
//  alarm
//
//  Created by 钟文锋 on 15/10/26.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "MusicSeletedViewController.h"
#import "MusicSeletedView.h"

@interface MusicSeletedViewController ()

@property (nonatomic,strong) MusicSeletedView *musicSeletedView;

@end

@implementation MusicSeletedViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.musicSeletedView];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor cyanColor];
    }

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if ([self.delegate respondsToSelector:@selector(getMusicName:)]) {
        [self.delegate getMusicName:self.musicSeletedView.musicName];
    }
}

#pragma mark - override
- (NSString *)navigationItemTitle
{
    return @"闹钟声";
}

#pragma mark - setter and getter
- (MusicSeletedView *)musicSeletedView
{
    if (!_musicSeletedView) {
        _musicSeletedView = [[MusicSeletedView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    }
    return _musicSeletedView;
}

@end
