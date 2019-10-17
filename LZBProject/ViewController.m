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
    
    self.calendar = [[LZBCalendar alloc] initWithFrameOrigin:CGPointMake(50, 50) width:280];
//    self.calendar.calendarBasicColor = KMAINFFA0;
//    self.calendar = [LZBCalendar shareInstance];
    self.calendar.type = LZBCalendarDirectionTop;
    self.calendar.delegate = self;
    
    self.calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
//        PushedViewController *pvc = [[PushedViewController alloc] init];
        NSString *title = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
//        [self.navigationController pushViewController:pvc animated:YES];
        
    };
    
}

- (void)calender:(LZBCalendar *)calendar didClickSureButtonWithDate:(NSString *)date{
    XLDLog(@"%@",date);
}
@end
