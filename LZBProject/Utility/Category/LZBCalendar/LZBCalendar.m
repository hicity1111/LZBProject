//
//  LZBCalendar.m
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendar.h"
#import "TriangleView.h"
#import "LZBCalenderScrollView.h"
#import "NSDate+LZBCalendar.h"

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
    CGPoint _topPoint;
}

@property (nonatomic, strong) LZBCalenderScrollView *calendarScrollView;

@property (nonatomic, strong) TriangleView *triangle;

@property (nonatomic, strong) UIView *calendarHeaderView;

@property (nonatomic, strong) UIView *weekHeaderView;

@property (nonatomic, strong) UIView *bottomView;

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

- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width{
    
    // 根据宽度计算 calender 主体部分的高度
    CGFloat weekLineHight = 0.85 * (width / 7.0);
    
    CGFloat monthHeight = 6 * weekLineHight;
    // 星期头部栏高度
    CGFloat weekHeaderHeight = 0.6 * weekLineHight;
    // calendar 头部栏高度
    CGFloat calendarHeaderHeight = 0.8 * weekLineHight;
    //底部按钮高度
    CGFloat bottonHeight =  1.5* weekLineHight;
    
    // 最后得到整个 calender 控件的高度
    _calendarHeight = calendarHeaderHeight + weekHeaderHeight + monthHeight + bottonHeight;
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, _calendarHeight)]) {
        
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.8;
        [[UIApplication sharedApplication].keyWindow addSubview:_backView];
        KTAPGES(dismissTap, dismiss);
        [_backView addGestureRecognizer:dismissTap];
        
        _calendarView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, _calendarHeight)];
           _calendarView.backgroundColor = KMAINFFFF;
       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_calendarView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
       maskLayer.frame = _calendarView.bounds;
       maskLayer.path = maskPath.CGPath;
       _calendarView.layer.mask = maskLayer;
       [[UIApplication sharedApplication].keyWindow addSubview:_calendarView];
        
        _calendarHeaderView = [self setupCalendarHeaderViewWithFrame:CGRectMake(0.0, 0.0, width, calendarHeaderHeight)];
        
        _weekHeaderView = [self setupWeekHeadViewWithFrame:CGRectMake(0.0, calendarHeaderHeight, width, weekHeaderHeight)];
        
        _calendarScrollView = [self setupCalendarScrollViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight, width, monthHeight)];
        
        _bottomView = [self setupCalendarBottonViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight + monthHeight, width, bottonHeight)];
        
        [self.calendarView addSubview:_calendarHeaderView];
        [self.calendarView addSubview:_weekHeaderView];
        [self.calendarView addSubview:_calendarScrollView];
        [self.calendarView addSubview:_bottomView];
        
    }
    return self;
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - headerView
- (UIView *)setupCalendarHeaderViewWithFrame:(CGRect)frame{
    
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    headerView.backgroundColor = KMAINFFFF;
    return headerView;
}

#pragma mark - headerView
- (UIView *)setupCalendarBottonViewWithFrame:(CGRect)frame{
    
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

#pragma mark - 星期View
- (UIView *)setupWeekHeadViewWithFrame:(CGRect)frame {
    
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width / 7.0;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = self.calendarBasicColor;
    
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i < 7; ++i) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weekArray[i];
        label.textColor = KMAIN5868;
        label.font = [UIFont lzb_fontForPingFangSC_MediumFontOfSize:11];
        [view addSubview:label];
    }
    
    return view;
    
}
- (LZBCalenderScrollView *)setupCalendarScrollViewWithFrame:(CGRect)frame {
    LZBCalenderScrollView *scrollView = [[LZBCalenderScrollView alloc] initWithFrame:frame];
    scrollView.calendarBasicColor = self.calendarBasicColor;
    return scrollView;
}

- (void)setCalendarBasicColor:(UIColor *)calendarBasicColor {
    _calendarBasicColor = calendarBasicColor;
    self.layer.borderColor = calendarBasicColor.CGColor;
    _calendarHeaderView.backgroundColor = calendarBasicColor;
    _weekHeaderView.backgroundColor = calendarBasicColor;
    _calendarScrollView.calendarBasicColor = calendarBasicColor; // 传递颜色
}

- (void)setDidSelectDayHandler:(DidSelectDayHandler)didSelectDayHandler {
    _didSelectDayHandler = didSelectDayHandler;
    if (_calendarScrollView != nil) {
        _calendarScrollView.didSelectDayHandler = _didSelectDayHandler; // 传递 block
    }
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"GFCalendar.ChangeCalendarHeaderNotification" object:nil];
}

- (void)refreshToCurrentMonthAction:(UIButton *)sender {
    
    NSInteger year = [[NSDate date] dateYear];
    NSInteger month = [[NSDate date] dateMonth];
    
    NSString *title = [NSString stringWithFormat:@"%ld年%ld月", year, month];
    XLDLog(@"title === %@",title);
//    [_calendarHeaderView setTitle:title forState:UIControlStateNormal];
    
    [_calendarScrollView refreshToCurrentMonth];
}

- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSNumber *month = dic[@"month"];
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月", year, month];
    XLDLog(@"title === %@",title);
//    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
}



/*
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
    
    _oriPoint = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
    _movePoint = _oriPoint;
    
    
#pragma mark - 上个月按钮
    CGRect rect = CGRectMake(24*_calendarFlag, 15*_calendarFlag, 7*_calendarFlag, 18*_calendarFlag);
    _leftButtton = [[UIButton alloc] initWithFrame:rect];
    [_leftButtton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xianghou_normal") forState:UIControlStateNormal];
    [_leftButtton addTarget:self action:@selector(preBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_calendarView addSubview:_leftButtton];
    
    self.yearAndMonthLabel = [[UILabel alloc] init];
    self.yearAndMonthLabel.frame = CGRectMake(_leftButtton.right + 24*_calendarFlag, _leftButtton.top, 100*_calendarFlag,18*_calendarFlag);
    self.yearAndMonthLabel.textColor = KMAIN00A2;
    self.yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
    self.yearAndMonthLabel.font = [UIFont lzb_fontForPingFangSC_RegularFontOfSize:13];
    self.yearAndMonthLabel.backgroundColor = KMAINFFFF;
    [_calendarView addSubview:self.yearAndMonthLabel];
    
#pragma mark - 下个月按钮
    CGRect rightRect = CGRectMake(_yearAndMonthLabel.right + 24*_calendarFlag, 15*_calendarFlag, 7*_calendarFlag, 18*_calendarFlag);
    _rightButton = [[UIButton alloc] initWithFrame:rightRect];
    [_rightButton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal") forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(nextBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_calendarView addSubview:_rightButton];
    
    
    JMBaseButtonConfig *totalButtonConfig = [JMBaseButtonConfig buttonConfig];
    totalButtonConfig.styleType = JMBootstrapTypeDefault;
    totalButtonConfig.title = @"全部";
    totalButtonConfig.titleFont = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:13];
    totalButtonConfig.backgroundImage = IMAGE_NAMED(@"tanchuang_xuangzeriqi_queren_normal");
#pragma mark - 全部按钮
    _totalButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 75*_calendarFlag, 9*_calendarFlag, 56*_calendarFlag, 20*_calendarFlag)];
    [_totalButton setTitle:@"全部" forState:UIControlStateNormal];
    [_totalButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
    _totalButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:13];
    [_totalButton setBackgroundImage:IMAGE_NAMED(@"tab_homework_leixing_normal") forState:UIControlStateNormal];
    [_totalButton setBackgroundImage:IMAGE_NAMED(@"btn_zujian_zuoyeliebiao_quanbu_press") forState:UIControlStateHighlighted];
    _totalButton.adjustsImageWhenHighlighted = NO;
    [_totalButton addTarget:self action:@selector(totalAct) forControlEvents:UIControlEventTouchUpInside];
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
    self.detailVCalendarView.backgroundColor = KMAINFFFF;
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
        btn.titleLabel.font = SYSTEM_FONT(11);
        
        [btn setTitleColor:KMAIN5868 forState:UIControlStateNormal];
        [btn setTitleColor:KMAINFFFF forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = YES;
        
        [btn setBackgroundImage:[self imageWithColor:KMAINFFFF] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:KMAINFFA0] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[self imageWithColor:KMAINFFA0] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(dateBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.detailVCalendarView addSubview:btn];
        
    }
    
    CGFloat cancelWith = (frame.size.width - 34*2*_calendarFlag - 15*_calendarFlag)/2;
    
    _cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(34*_calendarFlag, _detailVCalendarView.bottom, cancelWith, 33*_calendarFlag)];
    [_cancleButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_quxiao_normal") forState:UIControlStateNormal];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:KMAIN00A2 forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_cancleButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_calendarView addSubview:_cancleButton];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(34*_calendarFlag + cancelWith + 15*_calendarFlag, _detailVCalendarView.bottom, cancelWith, 33*_calendarFlag)];
    [_confirmButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_queren_normal") forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_calendarView addSubview:_confirmButton];
    
    [self dra];
    
}

- (void)confirmButtonClick{
    XLDLog(@"点击了确定按钮");
    [self cancelButtonClick];
    
    NSString *date;
    if (_showTimePicker) {
        date = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld", _year, _month, _day, _hour, _minute];
    }else {
        date = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(calender:didClickSureButtonWithDate:)]) {
        [_delegate calender:self didClickSureButtonWithDate:date];
    }
}


- (void)cancelButtonClick{
    XLDLog(@"日历控件消失");
    [UIView animateWithDuration:0.3 animations:^{
        [_backView removeFromSuperview];
        [_calendarView removeFromSuperview];
        [self.triangle removeFromSuperview];
    }];
}



- (void)dra{
    
    self.triangle = ({

        TriangleView *triangle = [[TriangleView alloc] initWithColor:[UIColor redColor] style:triangleViewIsoscelesTop];

        triangle;
    });

    [[UIApplication sharedApplication].keyWindow addSubview:self.triangle];

    //mas_make
    _triangle.frame =  CGRectMake(_topPoint.x + 8, _topPoint.y, 16, 8);
    
}
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
