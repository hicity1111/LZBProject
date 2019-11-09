//
//  NotificationViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationViewController.h"
#import "UITableView+MTExtension.h"         ///注册扩展类
#import "NotificationListCell.h"            ///列表类
#import "NotifyAllSelectToolView.h"         ///全选工具栏
#import "NotifyListEntry.h"                 ///数据模型
#import "NotifyDataService.h"
#import "UIBarButtonItem+SXCreate.h"


@interface NotificationViewController ()<UITableViewDelegate, UITableViewDataSource>
///聊表控件
@property (nonatomic, strong) UITableView *tableView;
///数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
///全选工具栏
@property (nonatomic, strong) NotifyAllSelectToolView *allToolView;
///deleteBtn
@property (nonatomic, strong) UIButton *deleteBtn;
///分页
@property (nonatomic, assign) NSInteger page;

@end

@implementation NotificationViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    ///添加导航
    [self mt_showNavigationTitle:@"消息中心"];
    ///加载组件
    [self mt_loadUI];
    ///获取用户信息
    [self obtainMessageListData];
    ///获取未读数
    [self loadUnreadCount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ///默认隐藏系统导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


#pragma mark - Private Methods
- (void)mt_loadUI {
    ///添加右侧删除按钮
    [self.navView addSubview:self.deleteBtn];
    ///添加列表
    [self.view addSubview:self.tableView];
    ///添加全选工具栏
    [self.view addSubview:self.allToolView];
    ///空白占位图
    LZBEmptyView *emptyView = [LZBEmptyView emptyViewWithImage:IMAGE_NAMED(@"pic_default_wrong") titleStr:@"暂无数据~" detailStr:@""];
    self.tableView.lzbemptyView = emptyView;
}


#pragma mark - Event Response
///删除
- (void)deleteEvent {
    self.deleteBtn.selected = !self.deleteBtn.selected;
    self.allToolView.hidden = !self.deleteBtn.selected;
    self.navView.backBtn.hidden = self.deleteBtn.selected;
    if (!self.deleteBtn.selected) {
        ///全部清空 利用kvc机制
        [self.dataSource setValue:@(0) forKeyPath:@"isSelected"];
        [self.allToolView resetData];
    }
    
    [self.tableView reloadData];
}


///全选事件
- (void)allSelectedEvent:(BOOL) isSelected {
    if (isSelected) {
        [self.dataSource setValue:@(1) forKeyPath:@"isSelected"];
        [self.allToolView updateDelNums:self.dataSource.count];
    } else {
        [self.dataSource setValue:@(0) forKeyPath:@"isSelected"];
        [self.allToolView updateDelNums:0];
    }
    [self.tableView reloadData];

}

///确定删除事件
- (void)doneDeleteEvent {
    NSLog(@"确定删除事件 ......");
    NSInteger nums = 0;
    for (NotifyListEntry *model in self.dataSource) {
        if (model.isSelected) {
            nums++;
        }
    }
    if (nums == 0) {
        [self showMessage:@"没有选择任何内容哦~" afterDelay:1.5];
    } else {
        MJWeakSelf
        [NSObject mt_showAlertWithTitle:@"删除消息"
                                message:@"是否确认删除所选消息"
                           confirmTitle:@"确定"
                            cancleTitle:@"取消"
                          confirmAction:^{
            [weakSelf handleAllDeleteEvent];
        } cancleAction:^{
            
        }];
    }
    
}

///处理全部删除事件
- (void)handleAllDeleteEvent {
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    for (NotifyListEntry *model in self.dataSource) {
        if (model.isSelected) {
            [deleteArray addObject:model];
        }
    }
    [self.dataSource removeObjectsInArray:deleteArray];
    if (self.dataSource.count == 0 ) {
        self.deleteBtn.selected = NO;
        [self.allToolView resetData];
        self.allToolView.hidden = YES;
        self.navView.backBtn.hidden = NO;
    }
    [self.tableView reloadData];
    
}



///MARK:- Remote API
///获取列表数据
- (void)obtainMessageListData {
    self.page = 1;
    MJWeakSelf
    [self showLoading];
    UserModel *infoM = [UserModel findUserInfoResult];
    [[NotifyDataService shareData] obtainMessageList:@""
                                       studentInfoId:[NSString stringWithFormat:@"%@", infoM.studentInfoId] success:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.dataSource = [NotifyListEntry mj_objectArrayWithKeyValuesArray:baseM.infos];
        [weakSelf.tableView reloadData];
        [weakSelf hideHUD];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hideHUD];
    }];
}

- (void)obtainMoreData {
    self.page ++;
    MJWeakSelf
    [self showLoading];
    UserModel *infoM = [UserModel findUserInfoResult];
    [[NotifyDataService shareData] loadMoreMessageList:[NSString stringWithFormat:@"%@", infoM.studentInfoId] page:self.page success:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        NSMutableArray *tempArray = [NotifyListEntry mj_objectArrayWithKeyValuesArray:baseM.infos];
        [weakSelf.dataSource addObjectsFromArray:tempArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf hideHUD];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf hideHUD];
    }];
}

///获取未读数
- (void)loadUnreadCount {
    ///noticeCount
    [[NotifyDataService shareData] loadUnreadMessageCountSuccess:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        if (baseM && baseM.infos && [baseM.infos isKindOfClass:[NSDictionary class]]) {
            NSLog(@"未读消息数目: %@", baseM.infos[@"noticeCount"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotifyListEntry *model = self.dataSource[indexPath.row];
    CGFloat cellHeight = [NotificationListCell computeNotifyCellHeight:model];
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell = (NotificationListCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotificationListCell class])];
    NotifyListEntry *model = self.dataSource[indexPath.row];
    cell.index = indexPath;
    cell.model = model;
    cell.isMulSelectedStatus = self.deleteBtn.selected;
    
    MJWeakSelf
    cell.itemSelectedCallBack = ^(NotifyListEntry * _Nonnull model, NSIndexPath * _Nonnull index) {
        model.isSelected = !model.isSelected;
        [weakSelf.dataSource replaceObjectAtIndex:index.row withObject:model];
//        [weakSelf.tableView reloadData];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        
        NSInteger nums = 0;
        for (NotifyListEntry *entry in weakSelf.dataSource) {
            if (entry.isSelected) nums++;
        }
        [weakSelf.allToolView updateDelNums:nums];
        
    };
    
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

#pragma mark - 滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
 
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
 
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}
 
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


#pragma mark - Getters and Setters
///列表组件
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight - kTopBarHeight - kBottomSafeSpace);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        if (@available(iOS 11.0, *)) {
            /// 阻止 ScrollView 自动判断 对（safeArea）的 ContentInset
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *bgV = [[UIImageView alloc] initWithFrame:_tableView.bounds];
        bgV.contentMode = UIViewContentModeScaleAspectFill;
        bgV.image = [UIImage imageNamed:@"vc_bg"];
        _tableView.backgroundView = bgV;

        ///bug-fix解决加载更多回弹问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        ///代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        ///注册列表
        [_tableView mt_registerCell:[NotificationListCell class]];
        
        ///下拉刷新
        MJWeakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf obtainMessageListData];
        }];
        ///上拉加载更多
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf obtainMoreData];
        }];
        
    }
    return _tableView;
}


///数据源
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

///全选工具栏
- (NotifyAllSelectToolView *)allToolView {
    if (!_allToolView) {
        _allToolView = [[NotifyAllSelectToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 45 - kBottomSafeSpace, kScreenWidth, 45)];
        _allToolView.hidden = YES;
        MJWeakSelf
        _allToolView.allSelectedCallBack = ^(BOOL isSelected) {
            [weakSelf allSelectedEvent:isSelected];
        };
        
        _allToolView.deleteEventCallBack = ^{
            [weakSelf doneDeleteEvent];
        };
    }
    return _allToolView;
}




- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        _deleteBtn.frame = CGRectMake(kScreenWidth - 85, kStatusBar_Height, 85, 44);
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"批量删除" forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"取消删除" forState:UIControlStateSelected];
        _deleteBtn.titleLabel.font = LZBFont(14, NO);
        [_deleteBtn addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


- (void)dealloc {
    NSLog(@"✔️消息中心 - VC - 被释放 ");
}

@end
