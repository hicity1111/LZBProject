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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



@end
