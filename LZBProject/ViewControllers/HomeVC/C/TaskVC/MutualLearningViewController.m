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
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, JXheightForHeaderInSection)];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor clearColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titleColor = kMAIN9999;
    self.categoryView.titleFont = KMAINFONT16;
    self.categoryView.titleSelectedColor  = KMAINFFFF;
    
    JXCategoryIndicatorSpringBackgroundView *lineView = [[JXCategoryIndicatorSpringBackgroundView alloc] init];
    ((JXCategoryIndicatorView *)self.categoryView).indicators = @[lineView];
    
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];
    
    //FIXME:如果和JXPagingView联动
    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
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
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        [arr addObject:[NSString stringWithFormat:@"测试数据---%d",i]];
    }
    list.dataSource = [arr mutableCopy];
    return list;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

- (void)screenButtonAct:(JMButton *)screenButton{
    XLDLog(@"点击了筛选");
    CGRect rect = [screenButton convertRect:screenButton.frame toView:[UIApplication sharedApplication].keyWindow];
    
    XLDLog(@"结果");
    
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
