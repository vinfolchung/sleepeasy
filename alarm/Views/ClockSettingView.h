//
//  ClockSettingView.h
//  alarm
//
//  Created by 钟文锋 on 15/10/23.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClockSettingViewDelegate;

@interface ClockSettingView : UIView

@property (nonatomic, weak) id<ClockSettingViewDelegate> delegate;
@property (nonatomic,strong) NSString *musicName;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISwitch *clockOpenSwitch;//闹钟开关
@property (nonatomic,strong) UILabel *musicNameLabel;//音乐名
@end

@protocol ClockSettingViewDelegate<NSObject>

@optional

- (void)didSelectSound;

@end