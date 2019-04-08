//
//  MagicianViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/13.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ButtonDidTappedAction)(void);

@interface MagicianViewController : UIViewController

@property (nullable, copy, nonatomic) ButtonDidTappedAction buttonAction;

- (void)startupAnimation;

@end

NS_ASSUME_NONNULL_END
