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
    self.calendar.type = LZBCalendarDirectionTop;
    self.calendar.delegate = self;
    self.calendar.currentMonthTitleColor =[UIColor colorWithHex:@"#2c2c2c"];
    self.calendar.lastMonthTitleColor =[UIColor colorWithHex:@"#8a8a8a"];
    self.calendar.nextMonthTitleColor =[UIColor colorWithHex:@"#8a8a8a"];
    self.calendar.isHaveAnimation = NO;
    self.calendar.isCanScroll = YES;
    self.calendar.isShowLastAndNextBtn = YES;
    self.calendar.isShowLastAndNextDate = YES;
    self.calendar.todayTitleColor =[UIColor redColor];
    self.calendar.selectBackColor =[UIColor greenColor];
    [self.calendar dealData];
    self.calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
    };
    self.calendar.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {

        XLDLog(@"返回日期");
    };
    
}

- (void)calender:(LZBCalendar *)calendar didClickSureButtonWithDate:(NSString *)date{
    XLDLog(@"%@",date);
}
@end
