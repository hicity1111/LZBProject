//
//  MutualLearningViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "MutualLearningViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryIndicatorSpringBackgroundView.h"
#import "TestListBaseView.h"
#import "OYCountDownManager.h"
#import "HomeDataService.h"
#import "NSString+LZBMap.h"

#define  homeApplecation [UIApplication sharedApplication].keyWindow

static const CGFloat JXheightForHeaderInSection = 30;

@interface MutualLearningViewController ()<UIScrollViewDelegate, JXPagerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) JMButton *screenButton;

@end

@implementation MutualLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [kCountDownManager start];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, JXheightForHeaderInSection)];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor clearColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titleColor = kMAIN9999;
    self.categoryView.titleFont = KMAINFONT16;
//    self.categoryView.collectionView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_top_bg")];
    self.categoryView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_top_bg")];
    self.categoryView.titleSelectedColor  = KMAINFFFF;
    
    
    JXCategoryIndicatorSpringBackgroundView *lineView = [[JXCategoryIndicatorSpringBackgroundView alloc] init];
    ((JXCategoryIndicatorView *)self.categoryView).indicators = @[lineView];
    
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    _pagingView.mainTableView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_top_bg")];
    MJWeakSelf
    _pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestHomeWorkList];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.pagingView.mainTableView.mj_header endRefreshing];
//        });
    }];
    [self.view addSubview:self.pagingView];
    
    //FIXME:如果和JXPagingView联动
    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)requestHomeWorkList{
    
    NSDictionary *studentInfoDic = [Utils loadUserInfo];

    NSDictionary *parameters = @{
            @"studentInfoId":studentInfoDic[@"studentInfoId"],
            @"appVersionCode":@"7"
        };
    [self.dataService loadRequestDic:parameters success:^(NSArray *modelArr) {
        XLDLog(@"首页数据获取到");
        
        NSMutableArray *resultArr = [self groupAction:[modelArr mutableCopy]];;
        [resultArr insertObject:[modelArr mutableCopy] atIndex:0];
        self.resultTaskArr = resultArr;

        NSArray *serviceTypes = [modelArr valueForKeyPath:@"@distinctUnionOfObjects.subjectAbbreviation"];
        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES]];
        self.titles = [serviceTypes sortedArrayUsingDescriptors:sortDesc];
        self.titles = [self replace:self.titles];
        
        if (self.resultTaskArr != nil || self.resultTaskArr.count != 0) {

        }
        [self.pagingView.mainTableView.mj_header endRefreshing];
        self.categoryView.titles = self.titles;
        [self.categoryView reloadData];
        [self.pagingView reloadData];
        

    } failure:^(NSError * _Nonnull error) {
        XLDLog(@"获取数据失败！");
        [MBProgressHUD showMessage:@"网络岔气了" inView:self.view];

    }];
}

- (NSMutableArray *)replace:(NSArray *)arr{
    NSMutableArray *replaceArr = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [replaceArr addObject:[NSString mt_abbreviationMap:IFISNIL(obj)]];
        
    }];
    [replaceArr insertObject:@"全部" atIndex:0];
    return replaceArr;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.pagingView.frame = self.view.bounds;
    
}

- (void)dealloc
{
    self.didScrollCallback = nil;
}

- (JMButton *)screenButton{
    if (!_screenButton) {
        
        JMBaseButtonConfig *buttonConfig = [JMBaseButtonConfig buttonConfig];
        buttonConfig.titleFont = LZBFont(9.5f, NO);
        buttonConfig.backgroundColor = [UIColor clearColor];
        buttonConfig.styleType = JMButtonStyleTypeLeft;
        buttonConfig.image = IMAGE_NAMED(@"ic_hp_filter");
        buttonConfig.titleFont = KMAINFONT16;
        buttonConfig.titleColor = KMAIN5868;
        buttonConfig.title = @"筛选";
        buttonConfig.padding = 5.0f;
        
        _screenButton = [[JMButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 0, 80, JXheightForHeaderInSection) ButtonConfig:buttonConfig];
        [_screenButton addTarget:self action:@selector(screenButtonAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenButton;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, JXheightForHeaderInSection)];
        _topView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_top_bg")];
        [_topView addSubview:self.categoryView];
    }
    return _topView;
}

- (HomeDataService *)dataService{
    _dataService = [HomeDataService shareDate];
    return _dataService;
}
#pragma mark - 第一次才加载，后续触发的不处理
- (void)loadDataForFirst {
//    if (!self.isDataLoaded) {
//        [self headerRefresh];
//        self.isDataLoaded = YES;
//    }
    
}
- (UIView *)listView {
    return self.view;
}

#pragma mark - JXPagingViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return nil;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 0;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    
    [self.topView addSubview:self.screenButton];
    return self.topView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
    TestListBaseView *list = [[TestListBaseView alloc] init];
    
//    NSMutableArray *resultArr = [self groupAction:self.resultTaskArr];;
//    [resultArr insertObject:self.resultTaskArr atIndex:0];
    list.dataSource = [self.resultTaskArr[index] mutableCopy];
    return list;
}


#pragma mark - 数组分组
- (NSMutableArray *)groupAction:(NSMutableArray *)arr {

    NSArray *serviceTypes = [arr valueForKeyPath:@"@distinctUnionOfObjects.subjectAbbreviation"];

    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES]];

    self.titles = [serviceTypes sortedArrayUsingDescriptors:sortDesc];

    __block NSMutableArray *groupArr = [NSMutableArray array];

    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subjectAbbreviation = %@", obj];

        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];

        [groupArr addObject:tempArr];

    }];

    return groupArr;

}


- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

- (void)screenButtonAct:(JMButton *)screenButton{
    XLDLog(@"点击了筛选");
    [MBProgressHUD showMessage:@"点击了筛选" inView:self.view];
//    CGRect rect = [screenButton convertRect:screenButton.frame toView:[UIApplication sharedApplication].keyWindow];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
