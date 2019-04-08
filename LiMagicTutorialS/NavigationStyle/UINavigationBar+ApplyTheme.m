//
//  UINavigationBar+ApplyTheme.m
//  iHealthS
//
//  Created by Wu on 2019/3/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "UINavigationBar+ApplyTheme.h"
#import "aNasssfggvifsgastionTehemde.h"

@implementation UINavigationBar (ApplyTheme)

- (void)applyTheme:(aNasssfggvifsgastionTehemde *)theme {
    self.barTintColor = theme.barTintColor;
    self.tintColor = theme.tintColor;
    self.titleTextAttributes = theme.titleTextAttributes;
}

@end
