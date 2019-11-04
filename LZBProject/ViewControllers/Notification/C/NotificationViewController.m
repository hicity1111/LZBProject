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


@interface NotificationViewController ()<UITableViewDelegate, UITableViewDataSource>
///聊表控件
@property (nonatomic, strong) UITableView *tableView;
///数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
///全选工具栏
@property (nonatomic, strong) NotifyAllSelectToolView *allToolView;
///titleview
@property (nonatomic, strong) UILabel *titleLab;
///deleteBtn
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation NotificationViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    ///加载组件
    [self mt_loadUI];
    ///获取用户信息
    [self obtainMessageListData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Private Methods
- (void)mt_loadUI {
    ///添加消息中心
    self.navigationItem.titleView = self.titleLab;
    ///添加列表控件
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleteBtn];
    ///添加列表
    [self.view addSubview:self.tableView];
    ///添加全选工具栏
    [self.view addSubview:self.allToolView];
}


#pragma mark - Event Response
///删除
- (void)deleteEvent {
    self.deleteBtn.selected = !self.deleteBtn.selected;
    self.allToolView.hidden = !self.deleteBtn.selected;
    [self.navigationItem setHidesBackButton:self.deleteBtn.selected];
    
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
    
}


///MARK:- Remote API
///获取列表数据
- (void)obtainMessageListData {
    [[NotifyDataService shareData] obtainMessageList:@"" studentInfoId:@"1634" success:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        
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
        [weakSelf.tableView reloadData];
        
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
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        ///注册列表
        [_tableView mt_registerCell:[NotificationListCell class]];
        
    }
    return _tableView;
}


///数据源
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        ///测试数据
        NotifyListEntry *model = [NotifyListEntry alloc];
        model.imageNums = 6;
        NotifyListEntry *model2 = [NotifyListEntry alloc];
        model2.imageNums = 0;
        NotifyListEntry *model3 = [NotifyListEntry alloc];
        model3.imageNums = 2;
        NotifyListEntry *model4 = [NotifyListEntry alloc];
        model4.imageNums = 4;
        [_dataSource addObjectsFromArray:@[model, model2, model3, model4]];
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

///titleView
- (UILabel *)titleLab {
    if (!_titleLab) {
       _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
       _titleLab.textAlignment = NSTextAlignmentCenter;
       _titleLab.textColor = KMAINFFFF;
       _titleLab.text = @"消息中心";
       _titleLab.font = LZBFont(18, YES);
    }
    return _titleLab;
}


- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"批量删除" forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"取消删除" forState:UIControlStateSelected];
        _deleteBtn.titleLabel.font = LZBFont(14, NO);
        [_deleteBtn addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


@end
