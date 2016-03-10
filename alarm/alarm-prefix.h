//
//  alarm-prefix.h
//  alarm
//
//  Created by 钟文锋 on 15/10/21.
//  Copyright (c) 2015年 vinfol. All rights reserved.
//

#ifndef alarm_alarm_prefix_h
#define alarm_alarm_prefix_h
#import "UIView+PlaceSize.h"
#import "UserDefaultsUtil.h"
/*
app配置相关
 */
//颜色
#define WhiteLineColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f]
#define WhiteColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f]
#define SepColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.6f]
#define TextColor [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1]
#define TextBackgroundColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.3]

//屏幕适配,以iPhone6为基准
#define kAdaptPixel (kScreen_Width / 375.0f)

// 屏幕的宽、高
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

//RGB十六进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//字符串
#define GetStringDefaultEmpty(string) (string && [string isKindOfClass:[NSString class]] && [string length] > 0 ? string : @"")
#define IsStringNilOrEmpty(string)   ((string == nil) || ([string isKindOfClass:[NSString class]] && [string length] == 0))
#define IsStringNotNil(string) ((string != nil) && [string isKindOfClass:[NSString class]] && [string length] > 0)

//比较字符串是否相等（忽略大小写），相等的话返回YES，否则返回NO
#define AnydoorCompareString(thing1, thing2) (thing1 && [thing1 isKindOfClass:[NSString class]] && thing2 && [thing2 isKindOfClass:[NSString class]] && [thing1 compare:thing2 options:NSCaseInsensitiveSearch] == NSOrderedSame)


#endif
