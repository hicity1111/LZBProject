//
//  LZBBaseNavigationController.m
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseNavigationController.h"
#import "UIBarButtonItem+SXCreate.h"


@interface LZBBaseNavigationController ()

///返回按钮
@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;

@end

@implementation LZBBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = self.leftBarBtn;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.navigationBar.tintColor = KMAINFFFF;
    [self.navigationBar navBarBackGroundColor:kMAIN31AC image:nil isOpaque:YES];
}


///MARK:- 返回事件
- (void)backEvent {
    if ([self respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self popViewControllerAnimated:YES];
    }
}


#pragma mark 懒加载
- (UIBarButtonItem *)leftBarBtn {
    if (!_leftBarBtn) {
        _leftBarBtn = [UIBarButtonItem itemWithTarget:self action:@selector(backEvent) image:[UIImage imageNamed:@"back_white"] imageEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 11)];
        
    }
    return _leftBarBtn;
}

@end
