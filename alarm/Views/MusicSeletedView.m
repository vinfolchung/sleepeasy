//
//  MusicSeletedView.m
//  alarm
//
//  Created by 钟文锋 on 15/10/26.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "MusicSeletedView.h"

@interface MusicSeletedView()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *musicArr;

@end

@implementation MusicSeletedView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35*kAdaptPixel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCell";
    UITableViewCell *cell;
    [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.musicArr[indexPath.row];
    //蓝色
    cell.textLabel.textColor = [UIColor colorWithRed:28/255.0 green:118/255.0 blue:245/255.0 alpha:1.0f];
    //cell.textLabel.textColor = [UIColor greenColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0*kAdaptPixel];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == [UserDefaultsUtil getClockMusic]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

//cell的单选问题
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == [UserDefaultsUtil getClockMusic]){
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:[UserDefaultsUtil getClockMusic] inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    [UserDefaultsUtil saveClockMusic:indexPath.row];
    NSString *musicName = newCell.textLabel.text;
    [UserDefaultsUtil saveClockMusicName:musicName];
    self.musicName = [UserDefaultsUtil getClockMusciName];
}

#pragma mark -  getter and setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)musicArr
{
    if (!_musicArr){
        _musicArr = [[NSArray alloc] initWithObjects:@"你不懂 - 昭宥",@"墙外的风景 - 苏打绿",@"I - 泰妍",@"Perfect - One Direction",@"和字母一起 - 乐童音乐家",@"肩膀 - 昭宥",@"Walk Away -  Dia Frampton",@"天下大乱 - 周柏豪",@"通宵 - 许阁、Basick",@"痛爱 - 容祖儿",@"我的天 - 黄光熙",@"像梦一样自由 - 汪峰",@"一颗不变的心 - 钟嘉欣",@"Bang -  Anitta",@"Tik Tok - Eliane",@"双子座 - 金泰妍",@"好好地 - 朴树", nil];
    }
    return _musicArr;
}

@end
