//
//  MagicTutorialType.m
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "MagicTutorialType.h"

@implementation MagicTutorialType

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes:attributes];
    if (self) {
        self.type = [attributes objectForKey:@"type"];
        self.title = [attributes objectForKey:@"title"];
    }
    return self;
}


@end
