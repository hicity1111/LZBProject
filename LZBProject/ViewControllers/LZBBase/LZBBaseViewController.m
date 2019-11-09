//
//  LZBBaseViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/18.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController.h"

@interface LZBBaseViewController ()

@end

@implementation LZBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///适配ScrollView 偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    ///添加自定义导航
    [self.view addSubview:self.navView];
    ///默认隐藏系统导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



///  子类调用改方法 默认
/// @param str title 字符串 navView.hidden = NO
- (void)mt_showNavigationTitle:(NSString *)str {
    self.navView.hidden = NO;
    self.navView.titleLab.text = str;
}


- (LZBNavigationBar *)navView {
    if (!_navView) {
        _navView = [LZBNavigationBar new];
        _navView.hidden = YES;
    }
    return _navView;
}

@end
