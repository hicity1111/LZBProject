//
//  LZBCalendar.m
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendar.h"

#define KCol           7
#define KBtnWith       44
#define KBtnHeight     25
#define KMaxCount      37
#define KShowYearCount 100
#define KDefultWith    350
#define KDefultHeight  280
#define KBtnTag        100

@interface LZBCalendar (){
    UIView *_backView;
    CGPoint _oriPoint;
    CGPoint _movePoint;
    CGFloat _calendarFlag;
}
/**周*/
@property (nonatomic, strong) NSArray *weekArray;
/**时间*/
@property (nonatomic, strong) NSArray *timeArray;
/**年*/
@property (nonatomic, strong) NSArray *yearArray;
/**月*/
@property (nonatomic, strong) NSArray *monthArray;
/**背景View*/
@property (nonatomic, strong) UIView  *calendarView;
/**calendarView*/
@property (nonatomic, strong) UIView  *detailVCalendarView;
/**年月日*/
@property (nonatomic, strong) UILabel   *yearAndMonthLabel;
/**年*/
@property (nonatomic, assign) NSInteger year;
/**月*/
@property (nonatomic, assign) NSInteger month;
/**天*/
@property (nonatomic, assign) NSInteger day;
/**小时*/
@property (nonatomic, assign) NSInteger hour;
/**分钟*/
@property (nonatomic, assign) NSInteger minute;
/**当前年*/
@property (nonatomic, assign) NSInteger currentYear;
/**当前月*/
@property (nonatomic, assign) NSInteger currentMonth;
/**当前天*/
@property (nonatomic, assign) NSInteger currentDay;
/**左按钮*/
@property (nonatomic, strong) UIButton *leftButtton;
/**右按钮*/
@property (nonatomic, strong) UIButton *rightButton;
/**全部按钮*/
@property (nonatomic, strong) UIButton *totalButton;
/**关闭按钮*/
@property (nonatomic, strong) UIButton *cancleButton;
/**确认按钮*/
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation LZBCalendar

+ (instancetype)shareInstance{
    
    static LZBCalendar *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return instance;
    
}

/**初始化方法*/
- (id)initWithFrame:(CGRect)frame andTopPoint:(CGPoint)point{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _calendarFlag = frame.size.width/KDefultWith;
        [self getCurrentDate];//获取当前时间
        [self getDataSource];//获取数据源
        [self configWithFrame:frame andTopPoint:point];
        [self getDefaultInfo];//初始化设置
        [self reloadData];//刷新数据
        
    };
    
    return self;
}

/// 获取当前时间
- (void)getCurrentDate{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    _year   = components.year;
    _month  = components.month;
    _day    = components.day;
    _hour   = components.hour;
    _minute =components.minute;
}

/// 获取数据源
- (void)getDataSource{
    
    _weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    _timeArray = @[@[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"],@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"37",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"48",@"49",@"50",@"51",@"52",@"52",@"54",@"55",@"56",@"57",@"58",@"59"]];
    NSInteger firsYear = _year - KShowYearCount / 2;
    NSMutableArray *yearArray = [NSMutableArray array];
    for (int i = 0; i < KShowYearCount; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld",firsYear + i]];
    }
    _yearArray = yearArray;
    _monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
}

/// 初始化设置
- (void)getDefaultInfo{
    _currentYear  = _year;
    _currentMonth = _month;
    _currentDay   = _day;
}


/// 创建控件
/// @param frame 大小
/// @param point 顶部中心点
- (void)configWithFrame:(CGRect)frame andTopPoint:(CGPoint)point{
    
    _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.8;
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    KTAPGES(dismissTap, dismiss);
    [_backView addGestureRecognizer:dismissTap];
    
#pragma mark - 设置CalendarView
    _calendarView = [[UIView alloc] initWithFrame:frame];
    _calendarView.backgroundColor = KMAINFFFF;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_calendarView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _calendarView.bounds;
    maskLayer.path = maskPath.CGPath;
    _calendarView.layer.mask = maskLayer;
    [[UIApplication sharedApplication].keyWindow addSubview:_calendarView];
    
    CGRect rect = CGRectMake(24*_calendarFlag, 15*_calendarFlag, 7*_calendarFlag, 18*_calendarFlag);
    _leftButtton = [[UIButton alloc] initWithFrame:rect];
    [_leftButtton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xianghou_normal") forState:UIControlStateNormal];
    [_calendarView addSubview:_leftButtton];
    
    self.yearAndMonthLabel = [[UILabel alloc] init];
    self.yearAndMonthLabel.frame = CGRectMake(_leftButtton.right + 24*_calendarFlag, _leftButtton.top, 100*_calendarFlag,18*_calendarFlag);
    self.yearAndMonthLabel.textColor = KMAIN00A2;
    self.yearAndMonthLabel.font = [UIFont lzb_fontForPingFangSC_RegularFontOfSize:13];
    self.yearAndMonthLabel.backgroundColor = [UIColor redColor];
    [_calendarView addSubview:self.yearAndMonthLabel];
    
    
    CGRect rightRect = CGRectMake(_yearAndMonthLabel.right + 24*_calendarFlag, 15*_calendarFlag, 7*_calendarFlag, 18*_calendarFlag);
    _rightButton = [[UIButton alloc] initWithFrame:rightRect];
    [_rightButton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal") forState:UIControlStateNormal];
    [_calendarView addSubview:_rightButton];
    
    
    JMBaseButtonConfig *totalButtonConfig = [JMBaseButtonConfig buttonConfig];
    totalButtonConfig.styleType = JMBootstrapTypeDefault;
    totalButtonConfig.title = @"全部";
    totalButtonConfig.titleFont = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:13];
    totalButtonConfig.backgroundImage = IMAGE_NAMED(@"tanchuang_xuangzeriqi_queren_normal");
    
    _totalButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 75*_calendarFlag, 9*_calendarFlag, 56*_calendarFlag, 20*_calendarFlag)];
    [_totalButton setTitle:@"全部" forState:UIControlStateNormal];
    [_totalButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
    _totalButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:13];
    [_totalButton setBackgroundImage:IMAGE_NAMED(@"tab_homework_leixing_normal") forState:UIControlStateNormal];
    [_totalButton setBackgroundImage:IMAGE_NAMED(@"btn_zujian_zuoyeliebiao_quanbu_press") forState:UIControlStateHighlighted];
    _totalButton.adjustsImageWhenHighlighted = NO;
    _totalButton.centerY = _rightButton.centerY;
    [_calendarView addSubview:_totalButton];
    
    UIImageView *bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(18*_calendarFlag, _totalButton.bottom + 8*_calendarFlag, frame.size.width - 18*2*_calendarFlag, 2)];
    bottomImage.image = IMAGE_NAMED(@"tanchuang_xuangzeriqi_fengexian_normal");
    [_calendarView addSubview:bottomImage];
    
    CGFloat btnWith = frame.size.width/7;//50
    //星期标签
    for (int i = 0; i < _weekArray.count; i++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(btnWith * i, bottomImage.bottom + 12*_calendarFlag, btnWith, 15)];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.text = _weekArray[i];
        weekLabel.textColor = KMAIN5868;
        weekLabel.font = [UIFont lzb_fontForPingFangSC_MediumFontOfSize:11];
        [_calendarView addSubview:weekLabel];
    }
    
    self.detailVCalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomImage.bottom + (12 + 15 + 12)*_calendarFlag, frame.size.width, KBtnHeight*_calendarFlag*6)];
    self.detailVCalendarView.backgroundColor = [UIColor redColor];
    [_calendarView addSubview:self.detailVCalendarView];
    
    
    for (int i = 0; i < KMaxCount; i++) {
     
        CGFloat btnX = i % KCol *btnWith;
        CGFloat btnY = i / KCol *KBtnHeight;
        CGFloat btnCurrentX = (btnWith - KBtnHeight)/2;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX + btnCurrentX, btnY, KBtnHeight, KBtnHeight)];
        btn.tag = i + KBtnTag;
        btn.layer.cornerRadius = KBtnHeight*0.5;
        btn.layer.masksToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%d",i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:KMAINFFFF] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:KMAINFFA0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(dateBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_detailVCalendarView addSubview:btn];
        
    }
    
    CGFloat cancelWith = (frame.size.width - 34*2*_calendarFlag - 15*_calendarFlag)/2;
    
    _cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(34*_calendarFlag, _detailVCalendarView.bottom, cancelWith, 33*_calendarFlag)];
    [_cancleButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_quxiao_normal") forState:UIControlStateNormal];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:KMAIN00A2 forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_calendarView addSubview:_cancleButton];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(34*_calendarFlag + cancelWith + 15*_calendarFlag, _detailVCalendarView.bottom, cancelWith, 33*_calendarFlag)];
    [_confirmButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_queren_normal") forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_calendarView addSubview:_confirmButton];
    
}

- (void)dateBtnOnClick:(UIButton *)button{
    XLDLog(@"点击了日期");
}
/// 刷新数据
- (void)reloadData{
    
}


- (void)show{
    XLDLog(@"日历控件出现");
}

- (void)dismiss{
    XLDLog(@"日历控件消失");
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
