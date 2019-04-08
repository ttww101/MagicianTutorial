//
//  TutorialTitleTableViewCell.h
//  iHealthS
//
//  Created by Wu on 2019/3/27.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TutorialTitleTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setTitleText:(NSString *)text;

@end


