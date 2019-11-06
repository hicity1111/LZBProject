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
#import "CTB_SubjectDataService.h"
#import "NotifyDataService.h"

#define cellID @"CTBSubjectCell"


@interface CTBViewController () <UITableViewDelegate, UITableViewDataSource, HomeHeaderDelegate>

@property (nonatomic, strong) CTB_SubjectDataService *dataService;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeHeaderView *homeHeaderView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavHeader];
    [self.view addSubview:self.tableView];
    
    LZBEmptyView *emptyView = [LZBEmptyView emptyViewWithImage:IMAGE_NAMED(@"pic_default_wrong") titleStr:@"还没有错题哦~" detailStr:@""];
    self.tableView.lzbemptyView = emptyView;
    
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    ///获取未读数
    [self loadUnreadCount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



#pragma mark - private Method

- (void)addCustomNavHeader {
    _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    UserModel *uModel = [UserModel findUserInfoResult];
    _homeHeaderView.titleString = [NSString stringWithFormat:@"Hi，%@同学，今天又见面了！", uModel.studentName];
    [_homeHeaderView showNumberBadgeValue:@"44"];
    _homeHeaderView.delegate = self;
    [self.view addSubview:_homeHeaderView];
}

- (void)requestData {
    [self.dataService requestDataWithSuccessBlock:^(LZBAPIResponseBaseModel * _Nonnull model) {
        self.dataSource = [CTB_SubjectModel mj_objectArrayWithKeyValuesArray:model.infos];
        [self.tableView reloadData];
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

///获取未读数
- (void)loadUnreadCount {
    ///noticeCount
    MJWeakSelf
    [[NotifyDataService shareData] loadUnreadMessageCountSuccess:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        if (baseM && baseM.infos && [baseM.infos isKindOfClass:[NSDictionary class]]) {
            NSLog(@"未读消息数目: %@", baseM.infos[@"noticeCount"]);
            [weakSelf.homeHeaderView removeBadgValue];
              if ([baseM.infos[@"noticeCount"] integerValue] > 0) {
                  [weakSelf.homeHeaderView showNumberBadgeValue:[NSString stringWithFormat:@"%@", baseM.infos[@"noticeCount"]]];
              }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - HomeHeaderDelegate

- (void)messageAct {
    [_homeHeaderView removeBadgValue];
    NotificationViewController *notifyVC = [[NotificationViewController alloc] init];
    [self.navigationController pushViewController:notifyVC animated:YES];
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CTB_SubjectModel *model = self.dataSource[indexPath.row];
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

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (CTB_SubjectDataService *)dataService {
    _dataService = [CTB_SubjectDataService sharedService];
    return _dataService;
}


@end
