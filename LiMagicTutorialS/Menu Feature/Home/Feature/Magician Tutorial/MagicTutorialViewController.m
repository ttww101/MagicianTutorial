//
//  MagicTutorialViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "MagicTutorialViewController.h"
#import "BaseViewController.h"
#import "UIView+Constraint.h"
#import "TutorialDetailViewController.h"

@interface MagicTutorialViewController ()

@property (strong, nonatomic) NSMutableArray<MagicTutorialType *> *mTypes;

@end

@implementation MagicTutorialViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSMutableArray *)mTypes {
    self.mTypes = mTypes;
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *mVCArr = [NSMutableArray new];
    NSMutableArray *mtitles = [NSMutableArray new];
    for (MagicTutorialType *type in self.mTypes) {
        TutorialDetailViewController *vc = [[TutorialDetailViewController alloc] initWithTutorialType:type];
        [mVCArr addObject:vc];
        [mtitles addObject:type.title];
    }
    self.buttonText = mtitles;
    [self.viewControllerArray addObjectsFromArray:mVCArr];
    
    UIButton *button = [UIButton new];
    [button setImage:[[UIImage imageNamed:@"open-door"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    button.layer.cornerRadius = 36;
    button.layer.masksToBounds = YES;
    button.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [button.imageView setTintColor:[UIColor purpleColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(closeButtonDidTouchupInside:) forControlEvents:UIControlEventTouchUpInside];
    [button constraintsLeading:self.view toLayoutAttribute:NSLayoutAttributeLeading constant:15];
    [button constraintsBottom:self.view toLayoutAttribute:NSLayoutAttributeBottom constant:-15];
    [button constraintsWidthWithConstant:72];
    [button constraintsHeightWithConstant:72];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.selectionBar setBackgroundColor:[UIColor whiteColor]];
    [self.selectionBar setAlpha:0.8];
    [self setNavigationBackgroundColor];
}

- (void)setNavigationBackgroundColor {
    self.navigationBar.barTintColor = [UIColor colorWithRed:51/255.f green:18/255.f blue:47/255.f alpha:1];//%%% buttoncolors
}

- (void)closeButtonDidTouchupInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
