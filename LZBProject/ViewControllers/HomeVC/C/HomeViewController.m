//
//  HomeViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "JXCategoryTitleVerticalZoomView.h"

@interface HomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) JXCategoryTitleVerticalZoomView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) CGFloat minCategoryViewHeight;

@property (nonatomic, assign) CGFloat maxCategoryViewHeight;

@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kMAIN31AC;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kTopBarHeight);
        
    }];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    HomeDetailViewController *home = [HomeDetailViewController new];
//    [self.navigationController pushViewController:home animated:YES];
}
@end
