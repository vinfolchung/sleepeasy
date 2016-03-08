//
//  MusicSeletedViewController.h
//  alarm
//
//  Created by 钟文锋 on 15/10/26.
//  Copyright © 2015年 webigstudio. All rights reserved.
//

#import "BaseViewController.h"

@protocol MusicSeletedVCDelegate;

@interface MusicSeletedViewController : BaseViewController

@property (nonatomic,weak) id<MusicSeletedVCDelegate> delegate;

@end

@protocol MusicSeletedVCDelegate <NSObject>
@optional

- (void)getMusicName:(NSString *)musicName;

@end