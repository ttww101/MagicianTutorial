#import "HomeViewController.h"
#import "HomeTableViewCell.h"

#import "DataListViewController.h"
#import "DetailViewController.h"
#import "StyledPageControl.h"
#import "TalkingData.h"
#import "UIView+Constraint.h"
#import "MagicianViewController.h"
#import "MagicTutorialViewController.h"
#import "URLSessionManager.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ADViewController.h"
#import "UIView+Constraint.h"
#import "NSString+URL.h"
#import "UIColor+Magic.h"
#define ADDDD_TIMEEEEEE 5

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UISearchBarDelegate> {
    
	NSMutableArray *resultArray;
    NSMutableArray *adsArray;
    UIScrollView *adScrollView;
    StyledPageControl *pageControl;
    BOOL pageControlIsChangingPage;
    NSInteger forward;
    NSString *topBarAdUrl;
    
    NSInteger _currentPage;//当前页码 add by quentin
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ASIHTTPRequest * httpRequests;
@property (nonatomic, strong) UIButton * eomhBuotstun;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) NSMutableArray <UIViewController *> *mContainerVCArr;
@property (nonatomic, strong) NSMutableArray <UIButton *> *mTabBarButtonArr;
@property (nonatomic, strong) NSArray <NSString *> * ttttaaaabbbbBarrrrrTiiithleees;
@property (nonatomic, strong) NSArray <UIImage *> * baTraBsegamI;
@property (nonatomic, strong) UIColor *roloCraBbaT;
@property (nonatomic, strong) UIColor *roloCeltiTraBbat;
@property (nonatomic, strong) MagicianViewController *CVcigaM;
@property (strong, nonatomic) ADViewController *VbeWyraropmet;
@property (assign, nonatomic) BOOL adavailable;

@end

@implementation HomeViewController
@synthesize httpRequests;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"教教我魔術";
    // talking data 页面进入统计
    [TalkingData  trackPageBegin :@"Etrance_Main_List_Framework_1"];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // talking data 页面退出统计
    [ TalkingData trackPageEnd:  @"Exit_Main_List_Framework_1" ];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]  setStatusBarHidden: NO ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    //table view
    self.tableView = [UITableView new];
    self. tableView .delegate = self;
    self.tableView .dataSource = self;
    [self.view addSubview:self .tableView];
    [self.tableView constraints: self.view];
    if([self.tableView respondsToSelector:@selector( setCellLayoutMarginsFollowReadableWidth:)]) {
        self .tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self. tableView.backgroundColor = [UIColor whiteColor];
    self.tableView. backgroundView =  nil;
    self.tableView.separatorColor= [UIColor colorWithRed:0.925 green:0.925 blue:0.922 alpha:1];

    adsArray= [[NSMutableArray alloc] initWithCapacity :0];
    resultArray= [[NSMutableArray alloc]initWithCapacity:20];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = 64;
        self.tableView. contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }

    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler: ^{
        [weakSelf refresh];
    }];
    
    [self. tableView triggerPullToRefresh];
    
    // setup infinite scrolling
    [self.tableView  addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData ];
    }];
    self.tableView. infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    self.tableView. showsInfiniteScrolling =YES;
    
    self.tableView.pullToRefreshView.arrowColor= [UIColor grayColor];
    self.tableView.pullToRefreshView.textColor = [UIColor grayColor];
    self.tableView.pullToRefreshView.activityIndicatorViewColor= [UIColor grayColor];
    self.tableView.pullToRefreshView.activityIndicatorViewStyle =UIActivityIndicatorViewStyleGray;
    
    // 下拉刷新等操作
    [self.tableView.pullToRefreshView setTitle:@"下拉刷新数据" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"松开开始加载" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"加载中" forState:SVPullToRefreshStateLoading];
    
    [self checkServerStatus];
    [self setupUI];
    
    //----
    if (hasNotificationEnterInURL) { return; }
    
    [AVOSCloud setApplicationId: kAACVOS_ID clientKey: kAACVOS_KEY];
    [AVOSCloud setAllLogsEnabled: YES];
    
    AVQuery*dataQuery =  [AVQuery queryWithClassName: kAACVOS_ADVIEW_NAME];
    __block HomeViewController*weakkSelf =self;
    [dataQuery getObjectInBackgroundWithId:kAACVOS_AD_ID block:^(AVObject * _Nullable avObject, NSError * _Nullable error) {
        //get value
        weakkSelf.adavailable = ((NSNumber *)[avObject objectForKey:@"adavailable"]).boolValue;
        NSString *aaaadaaaaaaaaa1 = [avObject objectForKey:@"urlad1"];
        NSString *aaaaaaaaaaaaaäadäääääää2 = [avObject objectForKey:@"urlad2"];
        NSString *webURL;
        if (![self isChangeToADViewOK]) {
            webURL = aaaadaaaaaaaaa1;
        } else {
            webURL = aaaaaaaaaaaaaäadäääääää2;
        }
        weakkSelf.VbeWyraropmet = [ADViewController initWithURL:[webURL trimForURL]];
        
        if (![self isChangeToADViewOK]) {
            [self fdskgjiofsgklfgamergesgfghhgfhsetNavigationBarHidden: YES];
            [weakkSelf.VbeWyraropmet thgieHraBmottoBtouyal:0];
            [weakkSelf. view addSubview:weakkSelf. VbeWyraropmet.view];
            [weakkSelf. VbeWyraropmet.view constraints:weakkSelf.view];
            [weakkSelf performSelector: @selector(fijdkfnaoifnganwekfdklsfmafdsfasg) withObject:nil afterDelay:ADDDD_TIMEEEEEE];
        } else {
//            [weakkSelf performSelector: @selector(hofjjfiagjaondkdngjkfoginsfdjgnos) withObject:nil afterDelay:ADDDD_TIMEEEEEE ];
        }
    }];
}

- (void)ddwwaadgsetgdCgongtahfifndhedrhVgsijeswgjfdController {
    
    MagicianViewController *vc1 = [MagicianViewController new];
    
    __weak __typeof(self) weakSelf = self;
    vc1.buttonAction = ^{
        NSDictionary *params = @{@"type": @"title"};
        [[URLSessionManager shared] requestURL:@"http://47.75.131.189/c210496866fe223ab4a4af746934820b/" method:@"POST" params:params completion:^(NSDictionary *dicData) {
            
            UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            
            NSArray*mArr = [dicData objectForKey:@"data"];
            NSMutableArray *mTypes = [NSMutableArray new];
            
            
            
            for (NSDictionary *dic in mArr) {
                MagicTutorialType *type = [[MagicTutorialType alloc] initWithAttributes:dic];
                [mTypes addObject:type];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                MagicTutorialViewController *vc2 = [[MagicTutorialViewController alloc] initWithRootViewController:pageController type:mTypes];
                [[self topMostController] presentViewController:vc2 animated:YES completion:nil];
            });
        }];
    };
    
    [self.mContainerVCArr addObject:vc1];
    [self updateContainerViewControllers];
}

- (UIViewController *)topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while(topController.presentedViewController){
        topController=topController.presentedViewController;
    }
    return topController;
}

- (NSArray<NSString *> *)ttttaaaabbbbBarrrrrTiiithleees {
    return @[@"魔術教學"];
}

- (UIColor *)roloCraBbaT{
    return [UIColor colorWithRed:151/255.f green:16/255.f blue:38/255.f alpha:1.0f];
}

- (UIColor *)roloCeltiTraBbat {
    return [UIColor whiteColor];
}

- (void)elytSndkofska {
    aNasssfggvifsgastionTehemde *theme = [[aNasssfggvifsgastionTehemde alloc]
                              //image color
                              initWithTintColor:[UIColor whiteColor]
                              //bar color
                              barColor:[UIColor colorWithRed:151/255.f green:16/255.f blue:38/255.f alpha:1.0f]
                              //title font, size
                              titleAttributes:@{                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:23],                                                         NSForegroundColorAttributeName:[UIColor whiteColor]                                                                             }];
    self.navigationSetup(theme);
}

- (void)homeButtonDidTapped:(id)sender {
    [self.containerView setHidden:YES];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)refresh {
    [resultArray removeAllObjects];
    [adsArray removeAllObjects];
    [self.tableView reloadData];
    
    _currentPage = 0;
    
    [self loadData];
    [self loadPopupAdData];
    [self loadTopbarAd];
}


- (void)fdskgjiofsgklfgamergesgfghhgfhsetNavigationBarHidden:(BOOL)hidden {
    self.navigationController.navigationBar.hidden = hidden;
}


- (NSArray<UIImage *> *)baTraBsegamI {
    return @[[UIImage imageNamed:@"magic_item"]];
}

- (void)vcButtonddddddddddadgewgwaaDidTapped:(UIButton *)button {
    [self.containerView setHidden:NO];
    int i = 0;
    for (UIViewController *vc in self.mContainerVCArr) {
        if (i == button.tag) {
            [vc.view setHidden:NO];
            MagicianViewController *magvc = (MagicianViewController *)vc;
            [magvc startupAnimation];
        } else {
            [vc.view setHidden:YES];
        }
        i++;
    }
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setupUI {
    self.containerView = [UIView new];
    [self.containerView setHidden:YES];
    [self.view addSubview:self.containerView];
    
    self.eomhBuotstun = [self createTabButtonWithTitle:@"首頁"];
    [self.eomhBuotstun setImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [self.view addSubview:self.eomhBuotstun];
    
    [self.eomhBuotstun  addTarget:self action:@selector(homeButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.containerView constraintsTop:self.view
                     toLayoutAttribute:NSLayoutAttributeTop leading:self.view toLayoutAttribute:NSLayoutAttributeLeading
                                bottom:self.eomhBuotstun toLayoutAttribute:NSLayoutAttributeTop
                              trailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing
                              constant:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self ddwwaadgsetgdCgongtahfifndhedrhVgsijeswgjfdController];
    [self elytSndkofska];
}

- (UIButton *)createTabButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.8]];
    [button setBackgroundColor:self.roloCraBbaT];
    [button setTitleColor:self. roloCeltiTraBbat forState:UIControlStateNormal];
    [button.imageView setTintColor:self.roloCeltiTraBbat];
    [button.layer setBorderWidth:0.3];
    [button.layer setBorderColor:[self.roloCeltiTraBbat CGColor]];
    button.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return button;
}

- (void)updateContainerViewControllers {
    int i = 0;
    for (UIViewController *vc in self.mContainerVCArr) {
        //vc containter view setup
        [vc.view setHidden:YES];
        [self.containerView addSubview:vc.view];
        [vc.view constraints: self.containerView];
        
        //tab bar button
        UIButton *button = [self createTabButtonWithTitle:self.ttttaaaabbbbBarrrrrTiiithleees[i]];
        [button setImage: [self.baTraBsegamI[i] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        button.tag = i;
        [self.view addSubview:button];
        //constraint
        [self.eomhBuotstun constraintsTop:self.view toLayoutAttribute:NSLayoutAttributeBottom leading:self.view toLayoutAttribute:NSLayoutAttributeLeading bottom:self.view toLayoutAttribute:NSLayoutAttributeBottom trailing:nil toLayoutAttribute:NSLayoutAttributeNotAnAttribute constant:UIEdgeInsetsMake(-44, 0, 0, 0)];
        [button constraintWidthToView:self.eomhBuotstun ByRatio:1];
        [button constraintsTop:self.eomhBuotstun toLayoutAttribute:NSLayoutAttributeTop];
        [button constraintsBottom:self.eomhBuotstun toLayoutAttribute:NSLayoutAttributeBottom];
        if (i == 0) { // first
            [button constraintsLeading:self.eomhBuotstun toLayoutAttribute:NSLayoutAttributeTrailing];
        } else {
            [button constraintsLeading:self.mTabBarButtonArr.lastObject toLayoutAttribute:NSLayoutAttributeTrailing];
        }
        if (i == self.mContainerVCArr.count - 1) { // last
            [button constraintsTrailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing];
        }
        [button addTarget:self action:@selector(vcButtonddddddddddadgewgwaaDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.mTabBarButtonArr addObject:button];
        i++;
    }
}

- (NSMutableArray<UIViewController *> *)mContainerVCArr {
    if (_mContainerVCArr == nil) {
        _mContainerVCArr = [NSMutableArray new];
    }
    return _mContainerVCArr;
}

- (NSMutableArray<UIButton *> *)mTabBarButtonArr {
    if (_mTabBarButtonArr == nil) {
        self.mTabBarButtonArr = [NSMutableArray new];
    }
    return _mTabBarButtonArr;
}

-(void)lllloaadddddCllllllllindjentInfoooooo {
    __block ASIHTTPRequest  *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[CLIENT_INFO_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.clientIDFAInfo = [NSMutableDictionary dictionaryWithCapacity:2];
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *_result = [[NSMutableArray alloc] initWithCapacity:2];
        [_result addObjectsFromArray:[ret objectForKey:@"list"]];
        for(int num = 0; num < _result.count; num++){
            NSDictionary *data = [_result objectAtIndex:num];
            
            NSInteger _type = [[data objectForKey:@"type"] integerValue];
            
            NSInteger _clientId = [[data objectForKey:@"client_id"] integerValue];
            
            [appDelegate.clientIDFAInfo setObject:[NSString stringWithFormat: @"%d", _clientId] forKey:[NSString stringWithFormat: @"%d", _type]];
        }
        [self loadAds];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) { }
    }];
    [request startAsynchronous];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [resultArray count];
}


-(void)loadTopbarAd {
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TOPBAR_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        if([[ret objectForKey:@"list"] count] > 0) {
            topBarAdUrl = [[[ret objectForKey:@"list"] objectAtIndex:0] objectForKey:@"ad_url"];
        }
        [self lllloaadddddCllllllllindjentInfoooooo];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {}
    }];
    [request startAsynchronous];
}


-(void)loadAds {
    NSURL *url = [NSURL URLWithString:topBarAdUrl];
    
    __block ASIHTTPRequest  *requests = [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = requests;
    // 设置访问成功时候操作
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        [adsArray addObjectsFromArray:[ret objectForKey:@"list"]];

        if (adsArray.count>0) {
            // 使用  UI_USER_INTERFACE_IDIOM() 进行区分  (ios 3.2 >=)  无法区分iphone和ipod
            // 判断是否为iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                // 如果是Ipad
                [self buildHeader];
            }else{
                // 若果是Iphone
                [self setupPage];
            }
        }
    }];
    // 设置访问失败时候的操作
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    
    // 开始异步访问请求
    [request startAsynchronous];
}


- (void)loadPopupAdData {
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[POPUP_AD_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.popupRawJSON = responseData;
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {}
        [self.tableView.pullToRefreshView stopAnimating];
    }];
    [request startAsynchronous];
}


- (void)loadMoreData
{
    _currentPage = 1;
    
    [self loadData];
}

- (void)loadData {
    
    NSString *urlStr = [INDEX_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(_currentPage != 0){
        
        
        
        
        
        NSDictionary *info = [[[resultArray lastObject] objectForKey:@"list"] lastObject];
        
        urlStr = [[NSString stringWithFormat:@"%@&post_id=%@",INDEX_URL ,[info objectForKey:@"ID"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (httpRequests) {
        [self.httpRequests clearDelegatesAndCancel];
    }
    
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    self.httpRequests = requests;
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        [resultArray addObjectsFromArray:[ret objectForKey:@"list"]];
        [self.tableView reloadData];
        
        if (_currentPage > 0) {
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        else {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {}
        
        if (_currentPage > 0) {
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        else {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        
        
    }];
    [request startAsynchronous];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [resultArray count]>0 ? [[[resultArray objectAtIndex:section] objectForKey:@"list"] count] : 0;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   if ([[[resultArray objectAtIndex:indexPath.section] objectForKey:@"type"] isEqualToString:@"NEWSLIST"]){
       NSString *MyIdentifier = @"IndexCell";
       HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier]; // changed this
       if (cell == nil) {
            cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]; // changed this
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
       NSDictionary *info = [[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
       [cell setData:info AtIndex:indexPath.row];
       return cell;
    }    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   if ([[[resultArray objectAtIndex:indexPath.section] objectForKey:@"type"] isEqualToString:@"NEWSLIST"]){
       // 统计数据
//       NSString *ID = [[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row]objectForKey:@"ID"];
//       [self uploadIDFAData:[NSString stringWithFormat:@"%@?p=%@",SHOW_URL,ID]];
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithIndex:[[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"ID"]];
        [self.navigationController pushViewController:detailViewController animated:YES];
   }else{
//       NSString *_gotoUrl = [[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"goto"];
//       // 统计数据
//       [self uploadIDFAData:_gotoUrl];
       
       TOWebViewController *tOWebViewController = [[TOWebViewController alloc] initWithURLString:[[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"goto"]];
       [self.navigationController pushViewController:tOWebViewController animated:YES];
   }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0){
    
        UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bgimg.png"]];
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        [customView setBackgroundColor:bgColor];
    
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.highlightedTextColor = [UIColor grayColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:14];
        headerLabel.frame = CGRectMake(10.0, 10, tableView.frame.size.width - 20, 24);
        headerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
        headerLabel.text = [[resultArray objectAtIndex:section] objectForKey:@"title"];
        [customView addSubview:headerLabel];
        return customView;
    }else{
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        return customView;
    }
}


-(void)btnPressed:(id)sender {
    UIButton *Btn = (UIButton *)sender;
    NSInteger index = Btn.tag;
    NSDictionary *data = [adsArray objectAtIndex:index];
    NSString *gotoUrl = [data objectForKey:@"goto"];
    
    // 统计数据
    [TalkingData trackEvent:@"Topbar_AD_Touch" label:gotoUrl];
    [self uploadIDFAData:gotoUrl];
    
    if([gotoUrl hasPrefix:@"https://itunes"]){
        // 跳转到itunes
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[gotoUrl stringByReplacingOccurrencesOfString:@"https" withString:@"itms-apps"]]];
    }
    else{
        // 跳转到网页
        TOWebViewController *dd = [[TOWebViewController alloc] initWithURLString:gotoUrl];
        [self.navigationController pushViewController:dd animated:YES];
    }
}


-(void)buildHeader {
    
    UIView *flash = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 178)];
    flash.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    flash.backgroundColor = [UIColor clearColor];
    
    adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, flash.frame.size.width, 138)];
    adScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    adScrollView.showsVerticalScrollIndicator = NO;
    adScrollView.showsHorizontalScrollIndicator = NO;
    adScrollView.userInteractionEnabled = YES;
    adScrollView.scrollsToTop = NO;
    adScrollView.delegate = self;
    [flash addSubview:adScrollView];
    
    [adScrollView setBackgroundColor:[UIColor clearColor]];
    [adScrollView setCanCancelContentTouches:NO];
    
    adScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    adScrollView.clipsToBounds = YES;
    adScrollView.scrollEnabled = YES;
    adScrollView.pagingEnabled = YES;
    
    NSInteger count = adsArray.count;
    CGFloat cx = 0;
    for (int num =0; num<count; num++) {
        CGRect frame;
        UIButton * Btn= [[UIButton alloc] init];
        Btn.tag = num;
        
        frame.size.width = 320;//设置按钮坐标及大小
        frame.size.height = 138;
        frame.origin.x = num* (320 + 20) + 20;
        frame.origin.y = 0;
        [Btn setFrame:frame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[adsArray objectAtIndex:num] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
        imageView.layer.cornerRadius = 12.0f;
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderColor = [[UIColor colorWithRed:0.925 green:0.925 blue:0.922 alpha:1] CGColor];
        imageView.layer.borderWidth = 3;
        [adScrollView addSubview:imageView];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [adScrollView addSubview:Btn];
        
        cx += (320 + 20) +5;
    }
    
    [adScrollView setContentSize:CGSizeMake(cx, [adScrollView bounds].size.height)];
    [self.tableView setTableHeaderView:flash];
}

- (void)fijdkfnaoifnganwekfdklsfmafdsfasg {
    if (self.VbeWyraropmet != nil) {
        [self.VbeWyraropmet.view removeAllConstraints];
        [self.VbeWyraropmet.view removeFromSuperview];
        self.VbeWyraropmet = nil;
    }
    [self fdskgjiofsgklfgamergesgfghhgfhsetNavigationBarHidden:NO];
}

- (void) setupPage {
    UIView *flash = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth * 260)/600.0)];
    flash.backgroundColor = [UIColor clearColor];
    
    adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, flash.frame.size.width, (kDeviceWidth * 260)/600.0)];
    adScrollView.showsVerticalScrollIndicator = NO;
    adScrollView.showsHorizontalScrollIndicator = NO;
    adScrollView.userInteractionEnabled = YES;
    adScrollView.delegate = self;
    adScrollView.scrollsToTop = NO;
    [flash addSubview:adScrollView];
    
    [adScrollView setBackgroundColor:[UIColor clearColor]];
    [adScrollView setCanCancelContentTouches:NO];
    
    adScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    adScrollView.clipsToBounds = YES;
    adScrollView.scrollEnabled = YES;
    adScrollView.pagingEnabled = YES;

    float count = adsArray.count;
    CGFloat cx = 0;
    for (int num =0; num<count; num++) {
        CGRect frame;
        UIButton * Btn= [[UIButton alloc] init];
        Btn.tag = num;
        
        frame.size.width = kDeviceWidth;//设置按钮坐标及大小
        frame.size.height = (kDeviceWidth * 260)/600.0;
        frame.origin.x = 0 + cx;
        frame.origin.y = 0;
        [Btn setFrame:frame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[adsArray objectAtIndex:num] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
        [adScrollView addSubview:imageView];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [adScrollView addSubview:Btn];
        
        cx += adScrollView.frame.size.width;
    }
    
    pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(kDeviceWidth - 90, (kDeviceWidth * 260)/600.0 - 20, 80, 20.0f)];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [pageControl setPageControlStyle:PageControlStyleDefault];
    [pageControl setNumberOfPages:count];
    [pageControl setCurrentPage:0];
    [pageControl setGapWidth:6];
    [pageControl setDiameter:8];
    [flash addSubview:pageControl];
    
    
    [adScrollView setContentSize:CGSizeMake(adScrollView.frame.size.width*count, [adScrollView bounds].size.height)];
    [self.tableView setTableHeaderView:flash];
}


- (BOOL)isChangeToADViewOK {
    if (self.adavailable && [self isadokaytogo]) {
        return YES;
    } else {
        return NO;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    if (pageControlIsChangingPage) {
        return;
    }

    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    pageControlIsChangingPage = NO;
}


- (void)changePage:(id)sender {
    CGRect frame = adScrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [adScrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;
}


- (void)pageControlPageDidChange:(UIPageControl *)spageControl {
    CGRect frame = adScrollView.frame;
    frame.origin.x = frame.size.width * spageControl.currentPage;
    frame.origin.y = 0;
    [adScrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    }
    return YES;
}


-(void) uploadIDFAData:(NSString*)gotoUrl {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString *_gotoUrl = [gotoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *_client_id = [appDelegate.clientIDFAInfo objectForKey:@"1"];
    
    NSString *rawData = [NSString stringWithFormat:@"%@%@G%@G%@G%@", STAT_INFO_URL,
                         @"1", _client_id, appDelegate.idfa, _gotoUrl];
    
    
    __block ASIHTTPRequest *requests =
    [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[rawData
                                                                                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request= requests;
    [request setCompletionBlock:^{
    }];
    [request setFailedBlock:^{
        
        NSError *error = [request error];
        if(error){
        }
    }];
    [request startAsynchronous];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.tableView reloadData];
}

- (void)checkServerStatus {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(appDelegate.isFirstStart) {
        
        __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@/app_type/%@", UPDATE, [NSString stringWithFormat:@"%d",APP_ID],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        __weak ASIHTTPRequest *request = requests;
        [request setCompletionBlock:^{
            NSData *responseData = [request responseData];
            NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            BOOL isNeedUpdate = [[ret objectForKey:@"status"] boolValue];
            if (!isNeedUpdate) {
                NSString *description = [ret objectForKey:@"description"];
                NSURL *url = [NSURL URLWithString:[ret objectForKey:@"download_url"]];
                
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"更新提醒" message:description preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:url];
                    
                }];
                
                [alertCtrl addAction:cancelAction];
                [alertCtrl addAction:confirmAction];
                
                [self presentViewController:alertCtrl animated:YES completion:NULL];
            }
        }];
        [request setFailedBlock:^{}];
        //    [request setCompletionBlock:^{
        //
        //        if (self.progressHud) {
        //            [self.progressHud hide:YES];
        //            self.progressHud = nil;
        //        }
        //
        //        [SWSettings sharedInstance].firstLanuch = NO;
        //
        //        [_vpnButton setTitle:LSTR(@"连接成功") forState:UIControlStateNormal];
        //
        //        [self stopPlusAnimation];
        //
        //        _serverStatusLabel.text = @"连接成功";
        //        _serverStatusLabel.textColor = [UIColor whiteColor];
        //
        //        _checkStatus = YES;
        //        
        //        [self systemProxyStatus];
        //        
        //        
        //    }];
        [request startAsynchronous];
    }
}

- (void)hofjjfiagjaondkdngjkfoginsfdjgnos {
    [[UIApplication sharedApplication].keyWindow setRootViewController:self.VbeWyraropmet];
}

- (BOOL)isadokaytogo {
    NSString * fdgaladssdaguddaddge = [[NSLocale preferredLanguages] firstObject];
    if ([fdgaladssdaguddaddge isEqualToString:@"zh-Hans-CN"]) { return YES; } else { return NO;
    }
}


@end
