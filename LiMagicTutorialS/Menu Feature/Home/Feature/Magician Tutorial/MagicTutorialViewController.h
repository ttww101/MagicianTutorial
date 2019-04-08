//
//  MagicTutorialViewController.h
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RKSwipeBetweenViewControllers/RKSwipeBetweenViewControllers.h>
#import "MagicTutorialType.h"

NS_ASSUME_NONNULL_BEGIN

@interface MagicTutorialViewController : RKSwipeBetweenViewControllers

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSMutableArray *)mTypes;

@end

NS_ASSUME_NONNULL_END
