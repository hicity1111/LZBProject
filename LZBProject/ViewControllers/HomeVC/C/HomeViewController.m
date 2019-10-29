//
//  HomeViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "JXCategoryTitleVerticalZoomView.h"
#import "HomeHeaderView.h"
#import "PendingTasksViewController.h"
#import "HistoricalTaskViewController.h"
#import "MutualLearningViewController.h"

@interface HomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UIGestureRecognizerDelegate,HomeHeaderDelegate>

@property (nonatomic, strong) JXCategoryTitleVerticalZoomView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView     *listContainerView;

@property (nonatomic, assign) CGFloat minCategoryViewHeight;

@property (nonatomic, assign) CGFloat maxCategoryViewHeight;

@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;

@property (nonatomic, strong) HomeHeaderView *homeHeaderView;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeaderView];
    [self configCategoryView];
}
#pragma mark - 任务view
- (void)configCategoryView{
    
    self.minCategoryViewHeight = 30;
    self.maxCategoryViewHeight = 55;
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, kTopBarHeight + self.maxCategoryViewHeight, kScreenWidth, self.view.bounds.size.height - kTopBarHeight - kTabBarHeight - self.maxCategoryViewHeight);
    [self.view addSubview:self.listContainerView];

    self.categoryView = [[JXCategoryTitleVerticalZoomView alloc] init];
    self.categoryView.frame = CGRectMake(0, self.homeHeaderView.bottom, kScreenWidth, self.maxCategoryViewHeight);
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titles = @[@"待处理任务", @"历史任务"];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    self.categoryView.titleLabelVerticalOffset = -5;
//    self.categoryView.titleColor =
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.contentEdgeInsetLeft = 15;    //设置内容左边距
    //推荐配置方案
    self.categoryView.maxVerticalCellSpacing = 20;
    self.categoryView.minVerticalCellSpacing = 10;
    self.categoryView.maxVerticalFontScale = 2;
    self.categoryView.minVerticalFontScale = 1.3;
    //你可以试试下面的配置方案
    /*
    self.categoryView.maxVerticalCellSpacing = 20;
    self.categoryView.minVerticalCellSpacing = 20;
    self.categoryView.maxVerticalFontScale = 2;
    self.categoryView.minVerticalFontScale = 1;
     */
    [self.view addSubview:self.categoryView];

    
}
#pragma mark - 布局导航标题栏
- (void)configHeaderView{
    _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    _homeHeaderView.titleString = @"Hi，张芳同学，今天又见面了！";
    [_homeHeaderView showNumberBadgeValue:@"44"];
    _homeHeaderView.delegate = self;
    [self.view addSubview:_homeHeaderView];
}

- (void)messageAct{

    XLDLog(@"点击了消息");
    [_homeHeaderView removeBadgValue];

   
}
- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //用户交互引起的滚动才处理
        return;
    }
    //用于垂直方向滚动时，视图的frame调整
    if ((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y < 0) {
        //当前属于缩小状态且往下滑动
        //列表往下移动、categoryView高度增加
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MIN(self.maxCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));

        if (self.categoryView.bounds.size.height == self.maxCategoryViewHeight) {
            //从小缩放到最大，将其他列表的contentOffset重置
            for (id<JXCategoryListContentViewDelegate>list in self.listContainerView.validListDict.allValues) {
                UIScrollView *listScrollView = [self listScrollView:list];
                if (listScrollView != scrollView) {
                    [listScrollView setContentOffset:CGPointZero animated:NO];
                }
            }
        }

        scrollView.contentOffset = CGPointZero;
    }else if (((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y >= 0 && self.categoryView.bounds.size.height > self.minCategoryViewHeight) ||
              (self.categoryView.bounds.size.height >= self.maxCategoryViewHeight && scrollView.contentOffset.y >= 0)) {
        //当前属于缩小状态且往上滑动且categoryView的高度大于minCategoryViewHeight 或者 当前最大高度状态且往上滑动
        //列表往上移动、categoryView高度减小
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MAX(self.minCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));

        scrollView.contentOffset = CGPointZero;
    }

    //必须调用
    CGFloat percent = (self.categoryView.bounds.size.height - self.minCategoryViewHeight)/(self.maxCategoryViewHeight - self.minCategoryViewHeight);
    [self.categoryView listDidScrollWithVerticalHeightPercent:percent];
}

- (UIScrollView *)listScrollView:(id<JXCategoryListContentViewDelegate>)list {
    
    PendingTasksViewController *listVC = (PendingTasksViewController *)list;
    return listVC.view;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
//    if (index == 0) {
        PendingTasksViewController *pendingTaskVC = [[PendingTasksViewController alloc] init];
//    }else if (index == 1){
//        MutualLearningViewController *mutualLearningVC = [[PendingTasksViewController alloc] init];
//    }else{
//        HistoricalTaskViewController *historicalVC = [[HistoricalTaskViewController alloc] init];
//    }
    
    
    LZBWeak;
    pendingTaskVC.didScrollCallback = ^(UIView *scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
    return pendingTaskVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}


@end
