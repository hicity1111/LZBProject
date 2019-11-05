//
//  CTBViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "CTBViewController.h"
#import "HomeHeaderView.h"
#import "CTBSubjectCell.h"
#import "LZBEmptyView.h"
#import "LZB_CTB_CellHelper.h"

#define cellID @"CTBSubjectCell"


@interface CTBViewController () <UITableViewDelegate, UITableViewDataSource, HomeHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeHeaderView *homeHeaderView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CTBViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    
    [self addCustomNavHeader];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self.view addSubview:self.tableView];
    
    LZBEmptyView *emptyView = [LZBEmptyView emptyViewWithImage:IMAGE_NAMED(@"pic_default_wrong") titleStr:@"还没有错题哦~" detailStr:nil];
    self.tableView.lzbemptyView = emptyView;
}



#pragma mark - private Method

- (void)addCustomNavHeader {
    _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    _homeHeaderView.titleString = @"Hi，张芳同学，今天又见面了！";
    [_homeHeaderView showNumberBadgeValue:@"44"];
    _homeHeaderView.delegate = self;
    [self.view addSubview:_homeHeaderView];
}

#pragma mark - HomeHeaderDelegate

- (void)messageAct {
    NotificationViewController *notifyVC = [[NotificationViewController alloc] init];
    [self.navigationController pushViewController:notifyVC animated:YES];
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *model = @{@"imgName": @"subject_chinese",
                            @"title": @"国学",
                            @"desc": @"你好棒！已经全部完成。"};
    UITableViewCell *cell = [LZB_CTB_CellHelper cellWithTableView:tableView withIndexPath:indexPath withModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight - kTopBarHeight - kTabBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];

        _tableView.autoresizesSubviews = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        if (@available(iOS 11.0, *)) {
            /// 阻止 ScrollView 自动判断 对（safeArea）的 ContentInset
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        UIImageView *bgV = [[UIImageView alloc] initWithFrame:_tableView.bounds];
        bgV.contentMode = UIViewContentModeScaleAspectFill;
        bgV.image = [UIImage imageNamed:@"vc_bg"];
        _tableView.backgroundView = bgV;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        _tableView.rowHeight = 130.f;
    }
    return _tableView;
}



@end
