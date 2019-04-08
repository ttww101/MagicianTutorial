//
//  TutorialTitleTableViewCell.m
//  iHealthS
//
//  Created by Wu on 2019/3/27.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "TutorialTitleTableViewCell.h"
#import "UIView+Constraint.h"
#import "UIColor+Magic.h"

@interface TutorialTitleTableViewCell ()

@property (strong, nonatomic) UIView *backgroundAlphaView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TutorialTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleBackgound];
        
        self.backgroundAlphaView = [UIView new];
        self.backgroundAlphaView.backgroundColor = [UIColor purpleDark1];
        self.backgroundAlphaView.alpha = 0.8;
        self.backgroundAlphaView.layer.cornerRadius = 5;
        self.backgroundAlphaView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.backgroundAlphaView];
        [self.backgroundAlphaView constraints:self.contentView constant:UIEdgeInsetsMake(15, 15, -15, -15)];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:24 weight:1.2];
        self.titleLabel.textColor = [UIColor yellowColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel constraints:self.backgroundAlphaView constant:UIEdgeInsetsMake(10, 10, -10, -10)];
    }
    return self;
}

- (void)setTitleText:(NSString *)text {
    self.titleLabel.text = text;
}

@end
