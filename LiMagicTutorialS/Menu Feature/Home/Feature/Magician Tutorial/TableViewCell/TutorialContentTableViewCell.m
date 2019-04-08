//
//  TutorialContentTableViewCell.m
//  iHealthS
//
//  Created by Wu on 2019/3/28.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "TutorialContentTableViewCell.h"
#import "FLAnimatedImage.h"
#import "UIView+Constraint.h"
#import "UIColor+Magic.h"
#import "URLSessionManager.h"

@interface TutorialContentTableViewCell ()

@property (nonatomic, strong) UILabel *contentLabel;
//@property (strong, nonatomic) YYAnimatedImageView *imageURLView;
@property (strong, nonatomic) FLAnimatedImageView *imageURLView;
@property (strong, nonatomic) UIView *separatorView;

@end

@implementation TutorialContentTableViewCell

#pragma mark - API

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleDark2];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.imageURLView];
        self.separatorView = [UIView new];
        self.separatorView.backgroundColor = [UIColor whiteColor];
        self.separatorView.alpha = 0.5;
        [self.contentView addSubview:self.separatorView];
        
        [self.contentLabel constraintsTop:self.contentView toLayoutAttribute:NSLayoutAttributeTop leading:self.contentView toLayoutAttribute:NSLayoutAttributeLeading bottom:self.imageURLView toLayoutAttribute:NSLayoutAttributeTop trailing:self.contentView toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(20, 10, -20, -10)];
        
        [self.imageURLView constraintsTop:nil toLayoutAttribute:NSLayoutAttributeNotAnAttribute leading:self.contentView toLayoutAttribute:NSLayoutAttributeLeading bottom:self.contentView toLayoutAttribute:NSLayoutAttributeBottom trailing:self.contentView toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(20, 20, -20, -20)];
        [self.imageURLView constraintSelfWidthHeightByRatio:2/1.f];

        [self.separatorView constraintsTop:self.contentView toLayoutAttribute:NSLayoutAttributeBottom leading:self.contentView toLayoutAttribute:NSLayoutAttributeLeading bottom:self.contentView toLayoutAttribute:NSLayoutAttributeBottom trailing:self.contentView toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(-3, 0, 0, 0)];
    }
    return self;
}

- (void)setContentText:(NSString *)text {
    self.contentLabel.text = text;
}

- (void)setImageFromURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    
    __weak __typeof(self) weakSelf = self;
    [weakSelf loadAnimatedImageWithURL:url completion:^(FLAnimatedImage *animatedImage) {
        weakSelf.imageURLView.animatedImage = animatedImage;
        weakSelf.imageURLView.userInteractionEnabled = YES;
        [weakSelf.imageURLView layoutIfNeeded];
    }];
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion {
    NSString *const filename = url.lastPathComponent;
    
    FLAnimatedImage * __block animatedImage = [self getImage:filename];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        __weak __typeof(self) weakSelf = self;
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [weakSelf saveData:data filename:filename];
            }
        }] resume];
    }
}

- (void)saveData:(NSData *)data filename:(NSString *)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    [data writeToFile:filename atomically:YES];
}

- (FLAnimatedImage *)getImage:(NSString *)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
}


#pragma mark - Getter, Setter

- (FLAnimatedImageView *)imageURLView {
    if (_imageURLView == nil) {
        FLAnimatedImageView *imageView = [FLAnimatedImageView new];
        _imageURLView = imageView;
    }
    return _imageURLView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:20 weight:1];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        _contentLabel = label;
    }
    return _contentLabel;
}


@end
