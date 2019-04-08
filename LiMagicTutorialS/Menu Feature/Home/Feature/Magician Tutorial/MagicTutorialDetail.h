//
//  MagicTutorialDetail.h
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "ISObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MagicTutorialDetail : ISObject

@property (strong, nonatomic) NSString *mainTitle;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray <NSString *> *imageURLs;
@property (strong, nonatomic) NSMutableArray <NSString *> *contents;

@end

NS_ASSUME_NONNULL_END
