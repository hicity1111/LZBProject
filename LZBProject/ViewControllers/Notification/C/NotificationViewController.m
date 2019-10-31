//
//  NotificationViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotifyClassInformCell.h"
#import "NotifySystemNotiCell.h"
#import "NotifyVoiceMailCell.h"

#define classCellID     @"NotifyClassInformCell"
#define systemCellID    @"NotifySystemNotiCell"
#define voiceCellID     @"NotifyVoiceMailCell"


@interface NotificationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NotifyClassInformCell *cell = [tableView dequeueReusableCellWithIdentifier:classCellID];
    NotifySystemNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCellID];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        CGRect frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight - kTopBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            /// 阻止 ScrollView 自动判断 对（safeArea）的 ContentInset
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.backgroundColor = VC_BACKGROUNDCOLOR;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
//        [_tableView registerNib:[UINib nibWithNibName:classCellID bundle:nil] forCellReuseIdentifier:classCellID];
//        [_tableView registerNib:[UINib nibWithNibName:voiceCellID bundle:nil] forCellReuseIdentifier:voiceCellID];
//        [_tableView registerNib:[UINib nibWithNibName:systemCellID bundle:nil] forCellReuseIdentifier:systemCellID];
        [_tableView registerClass:[NotifyClassInformCell class] forCellReuseIdentifier:classCellID];
        [_tableView registerClass:[NotifyVoiceMailCell class] forCellReuseIdentifier:voiceCellID];
        [_tableView registerClass:[NotifySystemNotiCell class] forCellReuseIdentifier:systemCellID];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 251.f;
    }
    return _tableView;
}

#pragma mark - Custom Delegate

- (void)setCustomNavbar {
    
}

#pragma mark - Event Response

#pragma mark - Private Methods

#pragma mark - Getters and Setters

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
