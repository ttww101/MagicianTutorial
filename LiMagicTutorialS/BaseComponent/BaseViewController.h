//
//  BaseViewController.h
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aNasssfggvifsgastionTehemde.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^NavigationIntialSetup)(aNasssfggvifsgastionTehemde *);

@interface BaseViewController : UIViewController

@property (nullable, copy, nonatomic) NavigationIntialSetup navigationSetup;

@end

NS_ASSUME_NONNULL_END
