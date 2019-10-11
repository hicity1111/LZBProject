//
//  ViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    [button setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:button];
    
    
    XLDLog(@"kScreenWidth==%f  kScreenHeight==%f",kScreenWidth,kScreenHeight);
}


@end
