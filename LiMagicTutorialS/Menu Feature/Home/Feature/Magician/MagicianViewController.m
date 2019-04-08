//
//  MagicianViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/13.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "MagicianViewController.h"
#import "UIView+Constraint.h"
#import "MagicTutorialViewController.h"

#define START_ANIMATION_DURATION 0.5

@interface MagicianViewController ()

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *magicianImageView;
@property (strong, nonatomic) UIImageView *magicPropImageView;
@property (strong, nonatomic) UIButton *cardDisappearButton;
@property (strong, nonatomic) UIButton *penDisappearButton;

@end

@implementation MagicianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Target Action

- (void)cardDisappearButtonDidTapped:(id)sender {
    self.buttonAction();
}

- (void)penDisappearButtonDidTapped:(id)sender {
    self.buttonAction();
}

#pragma mark - Private

- (void)startupAnimation {
    self.magicPropImageView.layer.transform = CATransform3DMakeScale(0.0,0.0,1);
    self.cardDisappearButton.layer.transform = CATransform3DMakeScale(0.0,0.0,1);
    self.penDisappearButton.layer.transform = CATransform3DMakeScale(0.0,0.0,1);
    
    self.magicianImageView.alpha = 1.0;
    [UIView animateWithDuration: 0.8 animations:^{
        self.magicianImageView.alpha = 0.1;
        self.cardDisappearButton.alpha = 0.1;
        self.penDisappearButton.alpha = 0.1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:START_ANIMATION_DURATION animations:^{
            
            self.magicPropImageView.layer.transform = CATransform3DMakeScale(1.1,1.1,1);
            self.cardDisappearButton.alpha = 1.0;
            self.penDisappearButton.alpha = 1.0;
            self.cardDisappearButton.layer.transform = CATransform3DMakeScale(1.1,1.1,1);
            self.penDisappearButton.layer.transform = CATransform3DMakeScale(1.1,1.1,1);
            
        } completion:^(BOOL finished) {
            
            self.magicPropImageView.layer.transform = CATransform3DMakeScale(1,1,1);
            self.cardDisappearButton.layer.transform = CATransform3DMakeScale(1,1,1);
            self.penDisappearButton.layer.transform = CATransform3DMakeScale(1,1,1);

        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.magicianImageView.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)setupUI {
    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView constraints:self.view];
    
    [self.view addSubview:self.magicPropImageView];
    [self.view addSubview:self.magicianImageView];
    
    [self.magicPropImageView constraintsTop:self.magicianImageView toLayoutAttribute:NSLayoutAttributeTop leading:self.view toLayoutAttribute:NSLayoutAttributeLeading bottom:self.magicianImageView toLayoutAttribute:NSLayoutAttributeCenterY trailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.magicianImageView constraintsTop:nil toLayoutAttribute:NSLayoutAttributeNotAnAttribute leading:self.view toLayoutAttribute:NSLayoutAttributeLeading bottom:self.view toLayoutAttribute:NSLayoutAttributeBottom trailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.magicianImageView constraintSelfWidthHeightByRatio:4/5.f];
    
    [self.view addSubview:self.cardDisappearButton];
    [self.cardDisappearButton constraintsBottom:self.view toLayoutAttribute:NSLayoutAttributeBottom constant:-60];
    [self.cardDisappearButton constraintsLeading:self.magicianImageView toLayoutAttribute:NSLayoutAttributeLeading constant:10];
    [self.cardDisappearButton constraintsTrailing:self.magicianImageView toLayoutAttribute:NSLayoutAttributeCenterX];
    [self.cardDisappearButton constraintsHeightWithConstant:60];
    
    [self.view addSubview:self.penDisappearButton];
    [self.penDisappearButton constraintsBottom:self.cardDisappearButton toLayoutAttribute:NSLayoutAttributeBottom constant:0];
    [self.penDisappearButton constraintsLeading:self.magicianImageView toLayoutAttribute:NSLayoutAttributeCenterX constant:10];
    [self.penDisappearButton constraintsTrailing:self.magicianImageView toLayoutAttribute:NSLayoutAttributeTrailing];
    [self.penDisappearButton constraintsHeightWithConstant:60];
}

#pragma mark - Getter

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_0"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView = imageView;
    }
    return _backgroundImageView;
}

- (UIImageView *)magicianImageView {
    if (_magicianImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magician"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _magicianImageView = imageView;
    }
    return _magicianImageView;
}

- (UIImageView *)magicPropImageView {
    if (_magicPropImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magic_prop"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _magicPropImageView = imageView;
    }
    return _magicPropImageView;
}

- (UIButton *)cardDisappearButton {
    if (_cardDisappearButton == nil) {
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"card_disappear_button"] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [button addTarget:self action:@selector(cardDisappearButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cardDisappearButton = button;
    }
    return _cardDisappearButton;
}

- (UIButton *)penDisappearButton {
    if (_penDisappearButton == nil) {
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"pen_disappear_button"] forState:UIControlStateNormal];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [button addTarget:self action:@selector(penDisappearButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        _penDisappearButton = button;
    }
    return _penDisappearButton;
}

@end
