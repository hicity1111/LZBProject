//
//  PendingTasksViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "PendingTasksViewController.h"
#import "JXCategoryIndicatorSpringBackgroundView.h"

@interface PendingTasksViewController ()<UITableViewDelegate, UITableViewDataSource,JXCategoryListContentViewDelegate,JXCategoryViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) BOOL isDataLoaded;

@property (nonatomic, strong) UIView *topView;

@end

@implementation PendingTasksViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)dealloc
{
    self.didScrollCallback = nil;
}


- (UIView *)listView {
    return self.view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    
}

#pragma mark - 第一次才加载，后续触发的不处理
- (void)loadDataForFirst {
    if (!self.isDataLoaded) {
        [self headerRefresh];
        self.isDataLoaded = YES;
    }
    
}
#pragma mark - 刷新数据
- (void)headerRefresh{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [NSCalendar currentCalendar];
    dateFormatter.dateFormat = @"HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataSource removeAllObjects];
        for (int i = 0; i < 20; i++) {
            [self.dataSource addObject:[NSString stringWithFormat:@"%@测试数据:%d", dateString, i]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.topView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self preferredCategoryViewHeight];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 80, [self preferredCategoryViewHeight])];
        self.categoryView.delegate = self;
        self.categoryView.titles = self.titles;
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.averageCellSpacingEnabled = NO;
        self.categoryView.titleColor = kMAIN9999;
        self.categoryView.titleFont = KMAINFONT16;
        self.categoryView.titleSelectedColor  = KMAINFFFF;
        JXCategoryIndicatorSpringBackgroundView *lineView = [[JXCategoryIndicatorSpringBackgroundView alloc] init];
        ((JXCategoryIndicatorView *)self.categoryView).indicators = @[lineView];

    }
    return _categoryView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [self preferredCategoryViewHeight])];
        _topView.backgroundColor = KMAINFFFF;
        [_topView addSubview:self.categoryView];
    }
    return _topView;
}


- (CGFloat)preferredCategoryViewHeight {
    return 40;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    XLDLog(@"点中 ---- %d",index);
}


@end
