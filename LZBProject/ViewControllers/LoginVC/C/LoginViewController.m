//
//  LoginViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginViewController.h"
#import "UserNoticeView.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = REDCOLOR;
    [self adjustShowUserNoticeView];
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


#pragma mark - Event Response

#pragma mark - Private Methods
- (void)adjustShowUserNoticeView {
    BOOL isUserAgreeNotice = NO;
    if (!isUserAgreeNotice) {
        [self showUserNoticeView];
    }
}

- (void)showUserNoticeView {
    UserNoticeView *unv = [[UserNoticeView alloc] init];
    [unv show];
}

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
