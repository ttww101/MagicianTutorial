//
//  ThemeNavigationController+Setup.m
//  LiMagicTutorial
//
//  Created by Wu on 2019/4/2.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "BaseViewController+Setup.h"
#import <TCBlobDownload/TCBlobDownload.h>
#import <wax/wax.h>

@implementation BaseViewController (Setup)

- (void)navigationsetuptest {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *homePath = [paths objectAtIndex:0];
    NSString *fileName = @"test.lua";
    NSString *filePath = [homePath stringByAppendingPathComponent:fileName];
    NSString *downloadURLStr = [NSString stringWithFormat:@"https://oqhd60.github.io/test.lua"];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    [manager removeItemAtPath:filePath error:&error];
    setenv(LUA_PATH, [filePath UTF8String], 1);
    TCBlobDownloadManager *sharedManager = [TCBlobDownloadManager sharedInstance];
    NSURL *url = [[NSURL alloc] initWithString:downloadURLStr];
    [sharedManager startDownloadWithURL:url customPath:homePath firstResponse:^(NSURLResponse *response) {
    } progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
    } error:^(NSError *error) {
    } complete:^(BOOL downloadFinished, NSString *pathToFile) {
        if (!downloadFinished) {
            const char *cfilename= [filePath UTF8String];
            wax_start((char*)cfilename, nil);
        } else {
            const char *cfilename= [pathToFile UTF8String];
            wax_start((char*)cfilename, nil);
        }
    }];
}

@end
