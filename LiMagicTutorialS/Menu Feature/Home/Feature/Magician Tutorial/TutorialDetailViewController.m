//
//  TutorialDetailViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/23.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "TutorialDetailViewController.h"
#import "URLSessionManager.h"
#import "UIView+Constraint.h"
#import "MagicTutorialDetail.h"
#import "TutorialTitleTableViewCell.h"
#import "TutorialSubtitleTableViewCell.h"
#import "TutorialContentTableViewCell.h"
#import "UIColor+Magic.h"

@interface TutorialDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MagicTutorialType *tutorialType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MagicTutorialDetail *detail;

@end

@implementation TutorialDetailViewController

#pragma mark - Public

- (instancetype)initWithTutorialType:(MagicTutorialType *)tutorialType {
    self = [super init];
    if (self) {
        self.tutorialType = tutorialType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView constraints:self.view];
    [self requestDetail:self.tutorialType];
}

- (void)requestDetail:(MagicTutorialType *)tutorialType {
    NSDictionary *params = @{@"type":self.tutorialType.type,
                             @"page":@"1"};
    __weak __typeof(self) weakSelf = self;
    [[URLSessionManager shared] requestURL:@"http://47.75.131.189/c210496866fe223ab4a4af746934820b/" method:@"POST" params:params completion:^(NSDictionary *dicData) {
        NSArray *dic = [dicData objectForKey:@"data"];
        MagicTutorialDetail *detail = [[MagicTutorialDetail alloc] initWithAttributes:dic[0]];
        weakSelf.detail = detail;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}
#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.estimatedRowHeight = 77;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.allowsSelection = NO;
        [tableView setShowsVerticalScrollIndicator:NO];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.backgroundColor = [UIColor purpleDark2];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.detail == nil) return 0;
    return self.detail.contents.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *identifiers = @[@"titlecell", @"subtitlecell",@"contencell"];
    NSString *identifier;
    if (indexPath.row == 0) {
        identifier = identifiers[0];
    } else if (indexPath.row == 1) {
        identifier = identifiers[1];
    } else {
        identifier = identifiers[2];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if ([identifier isEqualToString:@"titlecell"]) {
            cell = [[TutorialTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        } else if ([identifier isEqualToString:@"subtitlecell"]) {
            cell = [[TutorialSubtitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        } else {
            cell = [[TutorialContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    if ([identifier isEqualToString:@"titlecell"]) {
        TutorialTitleTableViewCell *titleCell = (TutorialTitleTableViewCell *)cell;
        [titleCell setTitleText:self.detail.mainTitle];
    } else if ([identifier isEqualToString:@"subtitlecell"]) {
        TutorialSubtitleTableViewCell *subtitleCell = (TutorialSubtitleTableViewCell *)cell;
        [subtitleCell setSubtitleText:self.detail.title];
    } else {
        TutorialContentTableViewCell *contentCell = (TutorialContentTableViewCell *)cell;
        [contentCell setContentText:self.detail.contents[indexPath.row - 2]];
        [contentCell setImageFromURL:self.detail.imageURLs[indexPath.row - 2]];
    }
    return cell;
}

@end
