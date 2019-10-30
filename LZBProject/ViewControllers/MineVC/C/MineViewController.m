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

#import "LYZCleanCache.h"
#import "LYZSandBoxPath.h"

#define tableView_HeaderView_Height 300.f
#define tableView_CommonCell_Height 45.f
#define tableView_Logout_Height     60.f

#define commonCellID @"MineCommonCell"
#define logoutCellID @"MineLogoutCell"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    self.view.backgroundColor = VC_BACKGROUNDCOLOR;
    
    [self addCustomView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillDisappear:animated];
}


#pragma mark - Custom Method

- (void)addCustomView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"PCenterHeaderView" owner:nil options:nil];
    PCenterHeaderView *pchView = [nibView firstObject];
    pchView.frame = CGRectMake(0, 0, kScreenWidth, tableView_HeaderView_Height);
    
    self.tableView.tableHeaderView = pchView;
}

/// 绑定手机号
- (void)bindPhoneNumber {
    
}

/// 清除缓存
- (void)cleanCache {
    
    LYZCleanCache *manager = [LYZCleanCache sharedCleanManager];
    NSString *cacheFolder = [LYZSandBoxPath path4Tmp];
    CGFloat folderSize = [manager folderSizeAtPath:cacheFolder];
//    [manager cleanFoldersWithPath:cacheFolder];
    
    NSString *message = [NSString stringWithFormat:@"共清理了 %.2f M", folderSize];
    [manager tokenAnimationWithView:self.view message:message];
}

/// 用户协议
- (void)seeUserProtocol {
    
}

/// 版本号
- (void)requestVersionUpdate {
    
}

/// 打客服
- (void)callCustomerService {
    NSString *number = @"18233156440";
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", number];
    NSURL *url = [NSURL URLWithString:str];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:url options:@{} completionHandler:^(BOOL success) {
        //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
        NSLog(@"OpenSuccess=%d", success);

    }];
}

/// 退出登录
- (void)logoutAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sureLogout];
    }];
    [alert addAction:sureAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {   /// 绑定手机号
            [self bindPhoneNumber];
            break;
        }
        case 1: {   /// 清除缓存
            [self cleanCache];
            break;
        }
        case 2: {   /// 用户协议
            [self seeUserProtocol];
            break;
        }
        case 3: {   /// 版本号
            [self requestVersionUpdate];
            break;
        }
        case 4: {   /// 客服电话
            [self callCustomerService];
            break;
        }
        case 5: {   /// 退出登录
            [self logoutAction];
            break;
        }
        default:
            break;
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
        _tableView.backgroundColor = VC_BACKGROUNDCOLOR;
        _tableView.autoresizesSubviews = NO;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        if (@available(iOS 11.0, *)) {
            /// 阻止 ScrollView 自动判断 对（safeArea）的 ContentInset
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:commonCellID bundle:nil] forCellReuseIdentifier:commonCellID];
        [_tableView registerNib:[UINib nibWithNibName:logoutCellID bundle:nil] forCellReuseIdentifier:logoutCellID];
    }
    return _tableView;
}

@end
