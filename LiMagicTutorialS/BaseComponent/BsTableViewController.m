
#import "BsTableViewController.h"
#import "ThemeNavigationController.h"
#import "UINavigationBar+ApplyTheme.h"

@interface BsTableViewController ()

@end

@implementation BsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak __typeof(self) weakSelf = self;
    self.navigationSetup = ^(aNasssfggvifsgastionTehemde *theme) {
        if ([weakSelf.navigationController isKindOfClass:[ThemeNavigationController class]]) {
            ThemeNavigationController *themeNavigationController = weakSelf.navigationController;
            themeNavigationController.statusBarStyle = theme.statusBarStyle;
            [themeNavigationController.navigationBar applyTheme:theme];
        }
    };
    [self setNavigationStyle];
}

- (void)setNavigationStyle {
    aNasssfggvifsgastionTehemde *theme = [[aNasssfggvifsgastionTehemde alloc]
                              //image color
                              initWithTintColor:[UIColor whiteColor]
                              //bar color
                              barColor:[UIColor colorWithRed:151/255.f green:16/255.f blue:38/255.f alpha:1.0f]
                              //title font, size
                              titleAttributes:@{                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:23],                                                         NSForegroundColorAttributeName:[UIColor whiteColor]                                                                             }];
    self.navigationSetup(theme);
}

@end
