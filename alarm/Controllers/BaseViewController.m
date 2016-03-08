//
//  BaseViewController.m
//  
//
//  Created by Coffee on 15/10/18.
//
//

#import "BaseViewController.h"
#import "BlurredColorBackgroundView.h"
#define NormalBackgroundColor [UIColor colorWithRed:26/255.0 green:31/255.0 blue:45/255.0 alpha:1.0f]
@interface BaseViewController ()

@property (nonatomic, strong) BlurredColorBackgroundView* backgroundView;

@end

@implementation BaseViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isGradientBackground) {
        [self.view addSubview:self.backgroundView];
    }else {
        self.view.backgroundColor = NormalBackgroundColor;
    }
    [self setupNavagationBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - private methods
//添加导航条
- (void)setupNavagationBar
{
    UINavigationItem * navigationItem = [[UINavigationItem alloc] init];
    
    if (!self.navigationController) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 44+20)];
        
        if (self.isGradientBackground) {
            [navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
        }else {
            navigationBar.translucent = NO;
            [navigationBar setBarTintColor:NormalBackgroundColor];
        }
        
        [navigationBar pushNavigationItem:navigationItem animated:YES];
        navigationBar.layer.masksToBounds = YES;
        [self.view addSubview:navigationBar];
    }else {
        if (self.isGradientBackground) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
        }else {
            self.navigationController.navigationBar.translucent = NO;
            [self.navigationController.navigationBar setBarTintColor:NormalBackgroundColor];

        }
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120*kAdaptPixel, 308*kAdaptPixel)];
    label.text = [self navigationItemTitle];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18.0f*kAdaptPixel];
    label.textColor = WhiteColor;
    if (!self.navigationController) {
        navigationItem.titleView = label;
    }else {
        self.navigationItem.titleView = label;
    }
    
    if (self.isBackBarButtonItem) {
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onBackBarButtonItem:)];
        if (!self.navigationController) {
            navigationItem.leftBarButtonItem = backBarButtonItem;
        }else {
            self.navigationItem.leftBarButtonItem = backBarButtonItem;
        }
    }else {
        if (self.navigationController) {
            self.navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
            self.navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
        }else {
            navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
            navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
        }
    }
}

#pragma override methods

- (NSString*)navigationItemTitle
{
    return @"";
}
- (UIBarButtonItem *)getLeftBarButtonItem
{
    return nil;
}
- (UIBarButtonItem *)getRightBarButtonItem
{
    return nil;
}
#pragma mark - event response

- (void)onBackBarButtonItem:(id)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - getters and setters

- (BlurredColorBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[BlurredColorBackgroundView alloc] init];
    }
    return _backgroundView;
}

@end
