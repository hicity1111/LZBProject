//
//  MineViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/25.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "MineViewController.h"
#import "AppDelegate.h"

#import "PCenterHeaderView.h"
#import "MineCommonCell.h"
#import "MineLogoutCell.h"
#import "LZBAlertViewController.h"
#import "NotifyDataService.h"
#import "AliyunDataService.h"

#define tableView_HeaderView_Height 300.f
#define tableView_CommonCell_Height 45.f
#define tableView_Logout_Height     60.f

#define commonCellID @"MineCommonCell"
#define logoutCellID @"MineLogoutCell"


@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

/// 列表
@property (nonatomic, strong) UITableView *tableView;

/// 列表 headerView
@property (nonatomic, strong) PCenterHeaderView *pchView;


@end

@implementation MineViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VC_BACKGROUNDCOLOR;
    [self addCustomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    ///获取未读消息数
    [self loadUnreadCount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - remote data
///获取未读数
- (void)loadUnreadCount {
    ///noticeCount
    MJWeakSelf
    [[NotifyDataService shareData] loadUnreadMessageCountSuccess:^(LZBAPIResponseBaseModel * _Nonnull baseM) {
        if (baseM && baseM.infos && [baseM.infos isKindOfClass:[NSDictionary class]]) {
            NSLog(@"未读消息数目: %@", baseM.infos[@"noticeCount"]);
            [weakSelf.pchView.noticeBtn removeBadgeValue];
            if ([baseM.infos[@"noticeCount"] integerValue] > 0) {
                [weakSelf.pchView.noticeBtn showNumberBadgeValue:[NSString stringWithFormat:@"%@", baseM.infos[@"noticeCount"]]];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Custom Method

- (void)addCustomView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"PCenterHeaderView" owner:nil options:nil];
    self.pchView = [nibView firstObject];
    self.pchView.frame = CGRectMake(0, 0, kScreenWidth, tableView_HeaderView_Height);
    self.pchView.vc = self;
    self.pchView.model = [UserModel findUserInfoResult];
    self.tableView.tableHeaderView = self.pchView;
}

/// 退出登录
- (void)logoutAction {
    LZBAlertConfig *config = [[LZBAlertConfig alloc] init];
    config.title = @"确定退出？";
    config.message = @"";
    config.cancelText = @"取消";
    config.sureText = @"确定";
    
    LZBAlertViewController *alertVC = [[LZBAlertViewController alloc] initWithConfig:config];
    [alertVC alertWithViewController:[LYZCurrentVCHelper getCurrentVC] AgreeBlock:^(UIButton * _Nonnull btn) {
        [self sureLogout];
    } cancelBlock:nil];
}

- (void)sureLogout {
    /// 请求后台退出登录
    SETUSER_BOOL(IS_USER_LOGIN, NO);
    SDUserDefaultsSync;
    
    [self showSuccess:@"退出成功"];
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appd entryDoor];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5) {
        return tableView_CommonCell_Height;
    } else {
        return tableView_Logout_Height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 5) {
        MineCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellID];
        cell.cellIndex = indexPath.row;
        return cell;
    }
    
    MineLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:logoutCellID];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sHeaderV = [[UIView alloc] init];
    sHeaderV.backgroundColor = UIColor.clearColor;
    return sHeaderV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sFooterV = [[UIView alloc] init];
    sFooterV.backgroundColor = UIColor.clearColor;
    return sFooterV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.f;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 退出登录
    if (indexPath.row == 5) {
        [self logoutAction];
    } else {
        MineCommonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell selectedCellWithIndex:indexPath];
    }
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
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
        _tableView.bounces = NO;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:commonCellID bundle:nil] forCellReuseIdentifier:commonCellID];
        [_tableView registerNib:[UINib nibWithNibName:logoutCellID bundle:nil] forCellReuseIdentifier:logoutCellID];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIAlertController *)alertWithTitle:(NSString *)title
                       sureButtonText:(NSString *)sureText
                     cancelButtonText:(NSString *)cancelText
                      sureActionBlock:(void (^)(UIAlertAction *action))sureBlock
                    cancelActionBlock:(void (^)(UIAlertAction *action))cancelBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureText style:UIAlertActionStyleDefault handler:sureBlock];
    [alert addAction:sureAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:cancelBlock];
    [alert addAction:cancelAction];
    
    return alert;
}

@end
