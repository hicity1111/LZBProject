//
//  PendingTasksViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "PendingTasksViewController.h"

@interface PendingTasksViewController ()<UITableViewDelegate, UITableViewDataSource,JXCategoryListContentViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) BOOL isDataLoaded;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PendingTasksViewController

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    

    // Do any additional setup after loading the view.
}

- (void)loadDataForFirst {
//第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        [self headerRefresh];
        self.isDataLoaded = YES;
    }
    
}

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
    
//    DetailViewController *vc = [[DetailViewController alloc] init];
//    if (self.navigationController != nil) {
//        [self.navigationController pushViewController:vc animated:true];
//    }else {
//        //仅仅是自定义列表容器示例才生效
//        [self.naviController pushViewController:vc animated:true];
//    }
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
