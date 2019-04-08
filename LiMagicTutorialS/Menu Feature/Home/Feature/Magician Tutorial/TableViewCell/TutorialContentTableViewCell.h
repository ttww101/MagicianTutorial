//
//  TutorialContentTableViewCell.h
//  iHealthS
//
//  Created by Wu on 2019/3/28.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TutorialContentTableViewCell : UITableViewCell

- (void)setContentText:(NSString *)text;
- (void)setImageFromURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
