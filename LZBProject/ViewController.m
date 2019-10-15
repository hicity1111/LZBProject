//
//  ViewController.m
//  LZBProject
//
//  Created by hicity on 2019/10/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "ViewController.h"
#import "LZBCalendar.h"

@interface ViewController ()<LZBCalendarDelegate>

@property (nonatomic, strong) LZBCalendar *calendar;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(calendarSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    XLDLog(@"vdfshjfs");
    XLDLog(@"kScreenWidth==%f  kScreenHeight==%f",kScreenWidth,kScreenHeight);
}

- (void)calendarSelector:(UIButton *)button{
    
    self.calendar = [LZBCalendar shareInstance];
    self.calendar.delegate = self;
    [self.calendar initWithFrame:CGRectMake(100, 10, 350, 280) andTopPoint:CGPointMake(100, 100)];
    
}
@end
