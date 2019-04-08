//
//  MagicTutorialType.h
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "ISObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MagicTutorialType : ISObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
