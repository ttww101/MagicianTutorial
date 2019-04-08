//
//  TutorialSubtitleTableViewCell.m
//  iHealthS
//
//  Created by Wu on 2019/3/27.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "TutorialSubtitleTableViewCell.h"
#import "UIView+Constraint.h"
#import "UIColor+Magic.h"

@interface TutorialSubtitleTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TutorialSubtitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleBackgound];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        self.titleLabel.textColor = [UIColor purpleTitleLight];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel constraints:self.contentView constant:UIEdgeInsetsMake(10, 10, -10, -10)];
    }
    return self;
}

- (void)setSubtitleText:(NSString *)text {
    self.titleLabel.text = text;
}

@end
