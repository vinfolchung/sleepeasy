//
//  BaseViewController.h
//  
//
//  Created by 钟文锋  on 15/10/18.
//
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL isBackBarButtonItem;//是否添加返回按钮
@property (nonatomic, assign) BOOL isGradientBackground;//是否是渐变背景

- (void)onBackBarButtonItem:(id)sender;//返回

- (NSString *)navigationItemTitle;//导航条标题
- (UIBarButtonItem *)getLeftBarButtonItem;//设置导航条左边按钮
- (UIBarButtonItem *)getRightBarButtonItem;//设置导航条右边按钮
@end

