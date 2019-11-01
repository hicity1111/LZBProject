//
//  NotificationViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotifySystemNotiCell.h"
#import "NotifyCellModel.h"

#define systemCellID    @"NotifySystemNotiCell"


@interface NotificationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NotificationViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *muArr = [NSMutableArray array];
    NotifyCellModel *model = [[NotifyCellModel alloc] transToModelWithDict:@{}];
    [muArr addObject:model];
//    [muArr addObject:model];
//    [muArr addObject:model];
//    [muArr addObject:model];
//    [muArr addObject:model];
    
    self.dataSource = muArr;
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotifyCellModel *model = self.dataSource[indexPath.row];
    NSLog(@"******************** %.f", model.cellHeight);
    return 255;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotifyCellModel *model = self.dataSource[indexPath.row];
    NotifySystemNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCellID];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight - kTopBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            /// 阻止 ScrollView 自动判断 对（safeArea）的 ContentInset
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        UIImageView *bgV = [[UIImageView alloc] initWithFrame:_tableView.bounds];
        bgV.contentMode = UIViewContentModeScaleAspectFill;
        bgV.image = [UIImage imageNamed:@"vc_bg"];
        _tableView.backgroundView = bgV;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [_tableView registerClass:[NotifySystemNotiCell class] forCellReuseIdentifier:systemCellID];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Custom Delegate

- (void)setCustomNavbar {
    
}

#pragma mark - Event Response

#pragma mark - Private Methods

#pragma mark - Getters and Setters


@end
