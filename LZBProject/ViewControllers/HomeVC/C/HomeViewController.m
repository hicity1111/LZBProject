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
#import "MutualLearningViewController.h"
#import "HomeDataService.h"

#define CategoryTitles  @[@"待处理任务",@"互评学习", @"历史任务"]

@interface HomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UIGestureRecognizerDelegate,HomeHeaderDelegate>

@property (nonatomic, strong) JXCategoryTitleVerticalZoomView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView     *listContainerView;

@property (nonatomic, assign) CGFloat minCategoryViewHeight;

@property (nonatomic, assign) CGFloat maxCategoryViewHeight;

@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;

@property (nonatomic, strong) HomeHeaderView *homeHeaderView;

@property (nonatomic, strong) NSArray *titles;//bia标题

@property (nonatomic, strong) NSMutableArray *resultPendingTaskArr;//待处理任务数据

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHeaderView];
    [self requestHomeWorkList];
//    [self configCategoryView];
}
#pragma mark - 首页作业列表数据请求
- (void)requestHomeWorkList{
    
    NSDictionary *studentInfoDic = [Utils loadUserInfo];

    NSDictionary *parameters = @{
            @"studentInfoId":studentInfoDic[@"studentInfoId"],
            @"appVersionCode":@"7"
        };
    [self.dataService loadRequestDic:parameters success:^(NSArray *modelArr) {
        XLDLog(@"首页数据获取到");
        self.resultPendingTaskArr = [self groupAction:[modelArr mutableCopy]];
        if (self.resultPendingTaskArr != nil || self.resultPendingTaskArr.count != 0) {
            [self configCategoryView];
        }

    } failure:^(NSError * _Nonnull error) {
        XLDLog(@"获取数据失败！");
        [MBProgressHUD showMessage:@"网络岔气了" inView:self.view];

    }];
}

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


#pragma mark - 任务view
- (void)configCategoryView{
    
    self.minCategoryViewHeight = 0;
    self.maxCategoryViewHeight = 55;
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    [self.view addSubview:self.listContainerView];

    self.listContainerView.frame = CGRectMake(0, kTopBarHeight + self.maxCategoryViewHeight, kScreenWidth, self.view.bounds.size.height - kTopBarHeight - kTabBarHeight - self.maxCategoryViewHeight);
    self.categoryView = [[JXCategoryTitleVerticalZoomView alloc] init];
    [self.view addSubview:self.categoryView];

    self.categoryView.frame = CGRectMake(0, self.homeHeaderView.bottom, kScreenWidth, self.maxCategoryViewHeight);
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titles = @[@"待处理任务",@"互评学习",@"历史任务"];
    self.categoryView.delegate = self;
    self.categoryView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_top_bg")];
    self.categoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    self.categoryView.titleLabelVerticalOffset = -5;
    self.categoryView.titleColor = kMAIN9999;
    self.categoryView.titleSelectedColor = kMAIN3333;
    self.categoryView.titleFont = KMAINFONT14;
    self.categoryView.titleSelectedFont = KMAINFONT14;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.separatorLineShowEnabled = YES;
    self.categoryView.separatorLineColor = KMAIN80B4;
    self.categoryView.separatorLineSize  = CGSizeMake(2, 14);
    self.categoryView.contentEdgeInsetLeft = 15;    //设置内容左边距
    //推荐配置方案
    self.categoryView.maxVerticalCellSpacing = 10;
    self.categoryView.minVerticalCellSpacing = 5;
    self.categoryView.maxVerticalFontScale = 1.6;
    self.categoryView.minVerticalFontScale = 1.05;


}
#pragma mark - 布局导航标题栏
- (void)configHeaderView{
    _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    
    NSDictionary *userInfoDic = [Utils loadUserInfo];
    _homeHeaderView.titleString = [NSString stringWithFormat:@"Hi，%@同学，今天又见面了！",userInfoDic[@"studentName"]];
    [_homeHeaderView showNumberBadgeValue:@"44"];
    _homeHeaderView.delegate = self;
    [self.view addSubview:_homeHeaderView];
}

#pragma mark - 点击消息
- (void)messageAct{

    [_homeHeaderView removeBadgValue];
    NotificationViewController *homeDetai = [NotificationViewController new];
    [self.navigationController pushViewController:homeDetai animated:YES];

   
}

#pragma mark - 监听滚动更新frame
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


        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame) + kTopBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame) -kTabBarHeight);

        if (self.categoryView.bounds.size.height > self.minCategoryViewHeight) {
            
            [self.navigationController setNavigationBarHidden:YES animated:NO];
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

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame) - kTabBarHeight);
        
        if (self.categoryView.bounds.size.height == self.minCategoryViewHeight) {
            [self addNavigationBarTitleView:CategoryTitles[self.categoryView.selectedIndex]];
            XLDLog(@"到底了");
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }
        scrollView.contentOffset = CGPointZero;
    }

    //必须调用
    CGFloat percent = (self.categoryView.bounds.size.height - self.minCategoryViewHeight)/(self.maxCategoryViewHeight - self.minCategoryViewHeight);

    [self.categoryView listDidScrollWithVerticalHeightPercent:percent];
}

- (UIScrollView *)listScrollView:(id<JXCategoryListContentViewDelegate>)list {
    
    MutualLearningViewController *listVC = (MutualLearningViewController *)list;
    return listVC.pagingView.mainTableView;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    self.listContainerView.scrollView.panGestureRecognizer.enabled = NO;

    MutualLearningViewController *pendingTaskVC = [[MutualLearningViewController alloc] init];
    if (index == 0) {
        pendingTaskVC.titles = self.titles;
    }else if(index == 1) {
        pendingTaskVC.titles = @[@"全部", @"数学"];
    }else if (index == 2) {
        pendingTaskVC.titles = @[@"全部", @"语文", @"生物",@"物理"];
    }
    LZBWeak;
    pendingTaskVC.didScrollCallback = ^(UIScrollView *scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
    return pendingTaskVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (HomeDataService *)dataService{
    _dataService = [HomeDataService shareDate];
    return _dataService;
}

@end
