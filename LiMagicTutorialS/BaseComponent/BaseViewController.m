//
//  BaseViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeNavigationController.h"
#import "UINavigationBar+ApplyTheme.h"
#import "BaseViewController+Setup.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    self.navigationSetup = ^(aNasssfggvifsgastionTehemde *theme) {
        if ([weakSelf.navigationController isKindOfClass:[ThemeNavigationController class]]) {
            ThemeNavigationController *themeNavigationController = weakSelf.navigationController;
            themeNavigationController.statusBarStyle = theme.statusBarStyle;
            [themeNavigationController.navigationBar applyTheme:theme];
        }
    };
    [self navigationsetuptest];
    self.navigationSetup([[aNasssfggvifsgastionTehemde alloc]
                          initWithTintColor:[UIColor blackColor]
                          barColor:[UIColor whiteColor]
                          titleAttributes:@{
                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                            NSForegroundColorAttributeName:[UIColor blackColor]
                                            }]);
}

@end
