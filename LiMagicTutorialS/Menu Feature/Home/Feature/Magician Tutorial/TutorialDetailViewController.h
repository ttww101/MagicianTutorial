//
//  TutorialDetailViewController.h
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicTutorialType.h"

NS_ASSUME_NONNULL_BEGIN

@interface TutorialDetailViewController : UIViewController

- (instancetype)initWithTutorialType:(MagicTutorialType *)tutorialType;

@end

NS_ASSUME_NONNULL_END
