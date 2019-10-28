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
#import "HomeHeaderView.h"

@interface HomeViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UIGestureRecognizerDelegate,HomeHeaderDelegate>

@property (nonatomic, strong) JXCategoryTitleVerticalZoomView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView     *listContainerView;

@property (nonatomic, assign) CGFloat minCategoryViewHeight;

@property (nonatomic, assign) CGFloat maxCategoryViewHeight;

@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;

@property (nonatomic, strong) HomeHeaderView *homeHeaderView;

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
    
    _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    _homeHeaderView.titleString = @"Hi，张芳同学，今天又见面了！";
    [_homeHeaderView showNumberBadgeValue:@"44"];
    _homeHeaderView.delegate = self;
    [self.view addSubview:_homeHeaderView];

}
- (void)messageAct{
    XLDLog(@"点击了消息");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    HomeDetailViewController *home = [HomeDetailViewController new];
//    [self.navigationController pushViewController:home animated:YES];
    
    [_homeHeaderView removeBadgValue];
}
@end
