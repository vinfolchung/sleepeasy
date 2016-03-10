//
//  AppDelegate.m
//  alarm
//
//  Created by 钟文锋 on 15/10/21.
//  Copyright (c) 2015年 vinfol. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MobClick.h"
#import "LocationManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //友盟统计
    [MobClick startWithAppkey:@"5636b3a4e0f55a715e007f31" reportPolicy:BATCH channelId:@""];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    self.window.rootViewController = homeViewController;
    [self.window makeKeyAndVisible];
    //注册本地通知的声音，alertview，图标数字
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"闹钟提醒" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [notification setSoundName:[NSString stringWithFormat:@"%@.m4r",[UserDefaultsUtil getClockMusciName]]];
        [UIApplication sharedApplication].applicationIconBadgeNumber -=1;
        NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (!localNotifications || localNotifications.count<=0) {
            return;
        }
        for (UILocalNotification *notify in localNotifications) {
            NSString *notifyID = [notify.userInfo objectForKey:@"id"];
            NSString *receivedNotityID = [notification.userInfo objectForKey:@"id"];
            if ([notifyID isEqualToString:receivedNotityID]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notify];
                break;
            }
        }

    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[LocationManager sharedLocationManager] startUpdatingLocation];
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
