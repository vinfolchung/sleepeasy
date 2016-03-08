//
//  ClockSettingView.m
//  alarm
//
//  Created by 钟文锋 on 15/10/23.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "ClockSettingView.h"
#import "UserDefaultsUtil.h"
#import <MediaPlayer/MediaPlayer.h>
#define kSlider_x (50*kAdaptPixel)
#define kSlider_y (55*kAdaptPixel)
#define kSlider_width (self.width - 2*kSlider_x)
#define kSlider_height (15*kAdaptPixel)
#define kSwitch_x (self.width - 60*kAdaptPixel)
#define kSwitch_y (5*kAdaptPixel)
#define kLabel_x (10*kAdaptPixel)
#define kLabel_y (10*kAdaptPixel)
#define kLabel_height (20*kAdaptPixel)
#define kFontSize (16.0*kAdaptPixel)
#define kFontSizeForTime (14.0*kAdaptPixel)
//时间label的宽
#define kSubLabel_width (50*kAdaptPixel)

@interface ClockSettingView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISlider *volumeSlider;//音量滑杆
//智能闹钟
@property (nonatomic,strong) UISwitch *smartClockSwitch;//智能闹钟开关
@property (nonatomic,strong) UISlider *smartTimeSlider;//智能闹钟时间滑杆
@property (nonatomic,strong) UILabel *smartTimeLabel;//智能闹钟的时间
//打盹
@property (nonatomic,strong) UISlider *napTimeSlider;//打盹时间的滑杆
@property (nonatomic,strong) UISwitch *napSwitch;//打盹开关
@property (nonatomic,strong) UILabel *napTimeLabel;//打盹时间

@end

@implementation ClockSettingView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowH;
    if (indexPath.row < 3)
    {
        rowH = 80*kAdaptPixel;
    }else if(indexPath.row == 3)
    {
        rowH = 40*kAdaptPixel;
    }
    else{
        rowH = 0;
    }
    return rowH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //闹钟
    if (indexPath.row == 0){
        //闹钟开关
        _clockOpenSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kSwitch_x, kSwitch_y, 0, 0)];
        if ([UserDefaultsUtil getClockSwitchIsOn] == 0) {
            _clockOpenSwitch.on = YES;
        }else{
            _clockOpenSwitch.on = NO;
        }
        [_clockOpenSwitch addTarget:self action:@selector(clockOpenSwitchChange:) forControlEvents:UIControlEventValueChanged];
        //声量控制滑杆
        _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(kSlider_x, kSlider_y, kSlider_width, kSlider_height)];
        _volumeSlider.value = [[MPMusicPlayerController applicationMusicPlayer] volume];
        _volumeSlider.minimumValue = 0;
        _volumeSlider.maximumValue = 1.0;
        if (_clockOpenSwitch.on) {
            _volumeSlider.enabled = YES;
            _volumeSlider.alpha = 1.0f;
        }else{
            _volumeSlider.enabled = NO;
            _volumeSlider.alpha = 0.5;
        }
        [_volumeSlider addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:_clockOpenSwitch];
        [cell addSubview:_volumeSlider];
        [self addNameLabelToCell:cell type:2 name:@"闹钟"];
        [self addVolumeImageToCell:cell type:1 imageName:@"声量降"];
        [self addVolumeImageToCell:cell type:2 imageName:@"声量升"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //智能闹钟
    else if(indexPath.row == 1){
        //智能闹钟开关
        _smartClockSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kSwitch_x, kSwitch_y, 0, 0)];
        _smartClockSwitch.on = [UserDefaultsUtil getSmartClockSwitchIsOn];
        if (_clockOpenSwitch.on) {
            _smartClockSwitch.enabled = YES;
        }else{
            _smartClockSwitch.enabled = NO;
        }
        [_smartClockSwitch addTarget:self action:@selector(smartClockSwitchChange:) forControlEvents:UIControlEventValueChanged];
        //智能闹钟时间滑杆
        _smartTimeSlider = [[UISlider alloc] initWithFrame:CGRectMake(kSlider_x, kSlider_y, kSlider_width, kSlider_height)];
        if ([UserDefaultsUtil getSmartClockTime] <= 5) {
            [UserDefaultsUtil saveSmartClockTime:5];
        }
        _smartTimeSlider.value = (float)[UserDefaultsUtil getSmartClockTime]/45;
        _smartTimeSlider.minimumValue = (float)5/40;
        _smartTimeSlider.maximumValue = 1.0;
        [_smartTimeSlider addTarget:self action:@selector(smartTimeSliderChange:) forControlEvents:UIControlEventTouchUpInside];
        
        //智能闹钟时间
        _smartTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100*kAdaptPixel, kLabel_y, kSubLabel_width, kLabel_height)];
        _smartTimeLabel.text = [NSString stringWithFormat:@"%ldmin",(long)[UserDefaultsUtil getSmartClockTime]];
        _smartTimeLabel.font = [UIFont systemFontOfSize:kFontSizeForTime];
        _smartTimeLabel.textColor = [UIColor cyanColor];
        _smartTimeLabel.backgroundColor = [UIColor clearColor];
        _smartTimeLabel.textAlignment = NSTextAlignmentLeft;
        
        if (_smartClockSwitch.on) {
            _smartTimeSlider.alpha = 1.0f;
            _smartTimeSlider.enabled = YES;
            _smartTimeLabel.alpha = 1.0f;
        }else {
            _smartTimeSlider.alpha = 0.5f;
            _smartTimeSlider.enabled = NO;
            _smartTimeLabel.alpha = 0;
        }
        
        [cell addSubview:_smartClockSwitch];
        [cell addSubview:_smartTimeSlider];
        [cell addSubview:_smartTimeLabel];
        [self addNameLabelToCell:cell type:4 name:@"智能闹钟"];
        [self addLabelForSliderToCell:cell type:1 text:@"5"];
        [self addLabelForSliderToCell:cell type:2 text:@"45min"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //打盹闹钟
    else if(indexPath.row == 2){
        //打盹开关
        _napSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kSwitch_x, kSwitch_y, 0, 0)];
        _napSwitch.on = [UserDefaultsUtil getNapClockSwitchIsOn];
        if (_clockOpenSwitch.on) {
            _napSwitch.enabled = YES;
        }else {
            _napSwitch.enabled = NO;
        }
        [_napSwitch addTarget:self action:@selector(napSwitchChange:) forControlEvents:UIControlEventValueChanged];
        
        //打盹时间滑杆
        if ([UserDefaultsUtil getNapTime] <= 1) {
            [UserDefaultsUtil saveNapTime:1];
        }
        _napTimeSlider = [[UISlider alloc] initWithFrame:CGRectMake(kSlider_x, kSlider_y, kSlider_width, kSlider_height)];
        _napTimeSlider.value = (float)[UserDefaultsUtil getNapTime]/19;
        _napTimeSlider.minimumValue = (float)1/20;
        _napTimeSlider.maximumValue = 1.0;
        [_napTimeSlider addTarget:self action:@selector(napTimeSliderChange:) forControlEvents:UIControlEventTouchUpInside];
        
        //打盹时间
        _napTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60*kAdaptPixel, kLabel_y, kSubLabel_width, kLabel_height)];
        _napTimeLabel.text = [NSString stringWithFormat:@"%ldmin",(long)[UserDefaultsUtil getNapTime]];
        _napTimeLabel.font = [UIFont systemFontOfSize:kFontSizeForTime];
        _napTimeLabel.textColor = [UIColor cyanColor];
        _napTimeLabel.textAlignment = NSTextAlignmentLeft;
        
        if (_napSwitch.on) {
            _napTimeSlider.enabled = YES;
            _napTimeSlider.alpha = 1.0f;
            _napTimeLabel.alpha = 1.0f;
        }else {
            _napTimeSlider.enabled = NO;
            _napTimeSlider.alpha = 0.5f;
            _napTimeLabel.alpha = 0;
        }
        
        [cell addSubview:_napSwitch];
        [cell addSubview:_napTimeSlider];
        [cell addSubview:_napTimeLabel];
        [self addNameLabelToCell:cell type:2 name:@"打盹"];
        [self addLabelForSliderToCell:cell type:1 text:@"1"];
        [self addLabelForSliderToCell:cell type:2 text:@"20min"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //闹钟声
    else if(indexPath.row == 3){
        //音乐名
        _musicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*kAdaptPixel, kLabel_y, 200*kAdaptPixel, kLabel_height)];
        if ([UserDefaultsUtil getClockMusciName] == nil) {
            [UserDefaultsUtil saveClockMusicName:@"你不懂 - 昭宥"];
        }
        _musicNameLabel.text = [UserDefaultsUtil getClockMusciName];
        _musicNameLabel.textColor = [UIColor cyanColor];
        _musicNameLabel.textAlignment = NSTextAlignmentLeft;
        _musicNameLabel.font = [UIFont systemFontOfSize:kFontSizeForTime];
        [cell addSubview:_musicNameLabel];
        [self addNameLabelToCell:cell type:3 name:@"闹钟声"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    //分割线
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80*kAdaptPixel, kScreen_Width, 0.5)];
    [sepLine setBackgroundColor:SepColor];
    if (indexPath.row < 3) {
        [cell addSubview:sepLine];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中马上取消
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        if ([self.delegate respondsToSelector:@selector(didSelectSound)]) {
            [self.delegate didSelectSound];
        }
    }
}

#pragma mark - addSubViews method
//添加滑动条左右两边的label
- (void)addLabelForSliderToCell:(UITableViewCell *)cell
                           type:(NSInteger)type
                           text:(NSString *)text
{
    //type 1为左边  2为右边
    CGFloat label_x;
    if (type == 1) {
        label_x = kLabel_x + 10*kAdaptPixel;
    }else{
        label_x = self.width - kSubLabel_width + 5*kAdaptPixel;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_x, kSlider_y - 3*kAdaptPixel, kSubLabel_width, kLabel_height)];
    label.text = text;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:kFontSizeForTime];
    [cell addSubview:label];
}

//添加cell的title
- (void)addNameLabelToCell:(UITableViewCell *)cell
                      type:(NSInteger)type
                      name:(NSString *)name
{
    //type代表label里面的字数，来控制label的宽度
    CGFloat label_width = type * 20 *kAdaptPixel;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLabel_x, kLabel_y, label_width, kLabel_height)];
    label.text = name;
    label.font = [UIFont systemFontOfSize:kFontSize];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:label];
}

//添加音量图标
- (void)addVolumeImageToCell:(UITableViewCell *)cell
                        type:(NSInteger)type
                   imageName:(NSString *)imageName
{
    //type 1左边 2右边
    CGFloat img_x;
    if (type == 1) {
        img_x = 15*kAdaptPixel;
    }else{
        img_x = self.width - 40*kAdaptPixel;
    }
    UIImageView *volumeImg = [[UIImageView alloc] initWithFrame:CGRectMake(img_x, 47*kAdaptPixel, 25*kAdaptPixel, 25*kAdaptPixel)];
    volumeImg.image = [UIImage imageNamed:imageName];
    volumeImg.alpha = 0.6;
    [cell addSubview:volumeImg];
}

#pragma mark - firstCell event respond
- (void)volumeChange:(id) sender
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    UISlider *sli = (UISlider *)sender;
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:sli.value];
    
}

- (void)clockOpenSwitchChange:(id) sender
{
    UISwitch *swi = (UISwitch *)sender;
    if (swi.on) {
        [self.volumeSlider setEnabled:YES];
        [self.volumeSlider setAlpha:1.0];
        [self.smartClockSwitch setEnabled:YES];
        [self.napSwitch setEnabled:YES];
        [UserDefaultsUtil saveClockSwitchIsOn:0];
        
    }else{
        [self.volumeSlider setEnabled:NO];
        [self.volumeSlider setAlpha:0.5];
        
        [self.smartClockSwitch setOn:NO animated:YES];
        [self.smartClockSwitch setEnabled:NO];
        [self.smartTimeSlider setAlpha:0.5];
        [self.smartTimeSlider setEnabled:NO];
        [self.smartTimeLabel setAlpha:0];
        
        [self.napSwitch setOn:NO animated:YES];
        [self.napSwitch setEnabled:NO];
        [self.napTimeSlider setAlpha:0.5];
        [self.napTimeSlider setEnabled:NO];
        [self.napTimeLabel setAlpha:0];
        [UserDefaultsUtil saveClockSwitchIsOn:1];
        [UserDefaultsUtil saveNapClockSwitchIsOn:NO];
        [UserDefaultsUtil saveSmartClockSwitchIsOn:NO];
    }
}

#pragma mark - secondCell event respond
- (void)smartClockSwitchChange:(id) sender
{
    UISwitch *swi = (UISwitch *)sender;
    if (swi.on) {
        [self.smartTimeSlider setEnabled:YES];
        [self.smartTimeSlider setAlpha:1.0];
        [self.smartTimeLabel setAlpha:1.0];
        [UserDefaultsUtil saveSmartClockSwitchIsOn:YES];
    }else{
        [self.smartTimeSlider setEnabled:NO];
        [self.smartTimeSlider setAlpha:0.5];
        [self.smartTimeLabel setAlpha:0];
        [UserDefaultsUtil saveSmartClockSwitchIsOn:NO];
    }
}

- (void)smartTimeSliderChange:(id) sender
{
    UISlider *sli = (UISlider *)sender;
    NSString *value = [NSString stringWithFormat:@"%dmin",(int)(sli.value*45)];
    _smartTimeLabel.text = value;
    [UserDefaultsUtil saveSmartClockTime:sli.value*45];
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - thirdCell event respond
- (void)napSwitchChange:(id) sender
{
    UISwitch *swi = (UISwitch *)sender;
    if (swi.on) {
        [self.napTimeSlider setEnabled:YES];
        [self.napTimeSlider setAlpha:1.0];
        [self.napTimeLabel setAlpha:1.0];
        [UserDefaultsUtil saveNapClockSwitchIsOn:YES];
    }else{
        [self.napTimeSlider setEnabled:NO];
        [self.napTimeSlider setAlpha:0.5];
        [self.napTimeLabel setAlpha:0];
        [UserDefaultsUtil saveNapClockSwitchIsOn:NO];
    }
}

- (void)napTimeSliderChange:(id)sender
{
    UISlider *sli = (UISlider *)sender;
    NSString *value = [NSString stringWithFormat:@"%dmin",(int)(sli.value*20)];
    _napTimeLabel.text = value;
    [UserDefaultsUtil saveNapTime:sli.value*20];
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - getter and setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不要分割线
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

@end
