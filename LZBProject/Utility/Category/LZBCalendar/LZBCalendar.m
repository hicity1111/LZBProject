//
//  LZBCalendar.m
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendar.h"
#import "TriangleView.h"
#import "NSDate+LZBCalendar.h"
#import "LZBCalendarHeaderView.h"
#import "LZBCalendarWeekView.h"
#import "LZBCalendarDayModel.h"
#import "LZBCalendarMonth.h"
#import "LXCalenderCell.h"


@interface LZBCalendar ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView *_backView;
    CGPoint _oriPoint;
    CGPoint _movePoint;
    CGFloat _calendarFlag;
    CGPoint _topPoint;
    LZBCalendarDayModel *_resultModel;
}

@property (nonatomic, strong) TriangleView *triangle;

@property (nonatomic, strong) LZBCalendarHeaderView *calendarHeaderView;

@property (nonatomic, strong) LZBCalendarWeekView *weekHeaderView;

@property (nonatomic, strong) UIView *bottomView;

@property(nonatomic,strong)UICollectionView         *collectionView;//日历
@property(nonatomic,strong)NSMutableArray           *monthdataA;//当月的模型集合
@property(nonatomic,strong)NSDate                   *currentMonthDate;//当月的日期
@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipe;//右滑手势
@property(nonatomic,strong)LZBCalendarDayModel      *selectModel;

/**背景View*/
@property (nonatomic, strong) UIView  *calendarView;
/**calendarView*/
@property (nonatomic, strong) UIView  *detailVCalendarView;
/**关闭按钮*/
@property (nonatomic, strong) UIButton *cancleButton;
/**确认按钮*/
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation LZBCalendar

- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width{
    
    // 根据宽度计算 calender 主体部分的高度
    CGFloat weekLineHight = 1 * (width / 7.0);
    
    CGFloat monthHeight = 6 * weekLineHight;
    // 星期头部栏高度
    CGFloat weekHeaderHeight = 1 * weekLineHight;
    // calendar 头部栏高度
    CGFloat calendarHeaderHeight = 0.8 * weekLineHight;
    //底部按钮高度
    CGFloat bottonHeight =  1.5* weekLineHight;
    
    // 最后得到整个 calender 控件的高度
    _calendarHeight = calendarHeaderHeight + weekHeaderHeight + monthHeight + bottonHeight;
    
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, _calendarHeight)]) {
        
        self.currentMonthDate = [NSDate date];
        

        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.8;
        [[UIApplication sharedApplication].keyWindow addSubview:_backView];
        LZBTAPGES(dismissTap, dismiss);
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
        _collectionView = [self setupCollectionViewWithFrame:CGRectMake(0.0, calendarHeaderHeight, width, weekLineHight*7)];
        _bottomView = [self setupCalendarBottonViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight + monthHeight, width, bottonHeight)];
        
        [self.calendarView addSubview:_calendarHeaderView];
        [self.calendarView addSubview:_weekHeaderView];
        [self.calendarView addSubview:_collectionView];
        [self.calendarView addSubview:_bottomView];
        
        LZBWeak;
        self.calendarHeaderView.leftClickBlock = ^{
            XLDLog(@"上月");
            [weakSelf rightSlide];
        };
        self.calendarHeaderView.rightClickBlock = ^{
            XLDLog(@"下月");
            [weakSelf leftSlide];
        };
        self.calendarHeaderView.totalClickBlock = ^{
            XLDLog(@"全部");
            [weakSelf dismiss];
        };
        
        
        self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
       
        [self.collectionView addGestureRecognizer:self.leftSwipe];
       
        self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
        self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
       
        [self.collectionView addGestureRecognizer:self.rightSwipe];
        
    }
    return self;
}


- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
       
        [self->_backView removeFromSuperview];
        [self->_calendarView removeFromSuperview];
    }];
}
-(void)dealData{
    
    [self responData];
}

#pragma mark --左滑手势--
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self leftSlide];
}
#pragma mark --左滑处理--
-(void)leftSlide{
    self.currentMonthDate = [self.currentMonthDate nextMonthDate];
    
    [self performAnimations:kCATransitionFromRight];
    [self responData];
}
#pragma mark --右滑处理--
-(void)rightSlide{
    
    self.currentMonthDate = [self.currentMonthDate previousMonthDate];
    [self performAnimations:kCATransitionFromLeft];
    
    [self responData];
}
#pragma mark --右滑手势--
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
   
    [self rightSlide];
}
#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma mark--数据以及更新处理--
-(void)responData{
    
    [self.monthdataA removeAllObjects];
    
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
//    NSDate *nextMonthDate = [self.currentMonthDate  nextMonthDate];
    
    LZBCalendarMonth *monthModel = [[LZBCalendarMonth alloc]initWithDate:self.currentMonthDate];
    
    LZBCalendarMonth *lastMonthModel = [[LZBCalendarMonth alloc]initWithDate:previousMonthDate];
        
    self.calendarHeaderView.dateStr = [NSString stringWithFormat:@"%ld年%ld月",monthModel.year,monthModel.month];
    
    NSInteger firstWeekday = monthModel.firstWeekday;
    
    NSInteger totalDays = monthModel.totalDays;

    for (int i = 0; i <42; i++) {
        
        LZBCalendarDayModel *model =[[LZBCalendarDayModel alloc]init];
        
        //配置外面属性
        [self configDayModel:model];
        
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        model.month = monthModel.month;
        model.year = monthModel.year;
        
        //上个月的日期
        if (i < firstWeekday) {
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            
            model.day = i -firstWeekday +1;
            model.isCurrentMonth = YES;
            
            //标识是今天
            if ((monthModel.month == [[NSDate date] dateMonth]) && (monthModel.year == [[NSDate date] dateYear])) {
                if (i == [[NSDate date] dateDay] + firstWeekday - 1) {
    
                    model.isToday = YES;
                }
            }
        }
         //下月的日期
        if (i >= (firstWeekday + monthModel.totalDays)) {
            
            model.day = i -firstWeekday - monthModel.totalDays +1;
            model.isNextMonth = YES;
            
        }
        [self.monthdataA addObject:model];
        
    }
    
    
    [self.monthdataA enumerateObjectsUsingBlock:^(LZBCalendarDayModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ((obj.year == self.selectModel.year) && (obj.month == self.selectModel.month) && (obj.day == self.selectModel.day)) {
            obj.isSelected = YES;
        }
    }];
    [self.collectionView reloadData];
    
}

-(void)configDayModel:(LZBCalendarDayModel *)model{
    
    //配置外面属性
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.currentMonthTitleColor = self.currentMonthTitleColor;
    
    model.lastMonthTitleColor = self.lastMonthTitleColor;
    
    model.nextMonthTitleColor = self.nextMonthTitleColor;
    
    model.selectBackColor = self.selectBackColor;
    
    model.isHaveAnimation = self.isHaveAnimation;
    
    model.todayTitleColor = self.todayTitleColor;
    
    model.isShowLastAndNextDate = self.isShowLastAndNextDate;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.monthdataA.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    LXCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell =[[LXCalenderCell alloc]init];
        
    }
    cell.model = self.monthdataA[indexPath.row];

    cell.backgroundColor =[UIColor whiteColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    LZBCalendarDayModel *model = self.monthdataA[indexPath.row];
    model.isSelected = YES;
    
    //选中的day
    self.selectModel = model;
    [self.monthdataA enumerateObjectsUsingBlock:^(LZBCalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != model) {
            obj.isSelected = NO;
        }
    }];
    
//    if (self.selectBlock) {
//        self.selectBlock(model.year, model.month, model.day);
//    }
    [collectionView reloadData];
    
}

#pragma mark - headerView
- (LZBCalendarHeaderView *)setupCalendarHeaderViewWithFrame:(CGRect)frame{
    
    LZBCalendarHeaderView *headerView = [[LZBCalendarHeaderView alloc] initWithFrame:frame];
    headerView.backgroundColor = KMAINFFFF;
    return headerView;
}

#pragma mark - bottomView
- (UIView *)setupCalendarBottonViewWithFrame:(CGRect)frame{
    
    UIView *weekView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat cancelWith = (frame.size.width - 34*2 - 15)/2;
    CGFloat cancelHeight = frame.size.height *0.6;
    _cancleButton = [[UIButton alloc] init];
    _cancleButton.size = CGSizeMake(cancelWith, cancelHeight);
    _cancleButton.centerX = 34 + cancelWith/2;
    _cancleButton.centerY =weekView.height/2;
//    _cancleButton.origin = CGPointMake(34 + cancelWith/2, weekView.height/2);
    [_cancleButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_quxiao_normal") forState:UIControlStateNormal];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:KMAIN00A2 forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [weekView addSubview:self.cancleButton];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(34 + cancelWith + 15, _cancleButton.top, _cancleButton.width,_cancleButton.height)];
    [_confirmButton setBackgroundImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_queren_normal") forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:15];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [weekView addSubview:self.confirmButton];
    
    return weekView;
}

- (void)confirmButtonClick{
    
    LZBCalendarDayModel *model = self.selectModel;
    if (self.selectBlock) {
        self.selectBlock(model.year, model.month, model.day);
    }
    [self dismiss];
    
}
#pragma mark - 星期View
- (LZBCalendarWeekView *)setupWeekHeadViewWithFrame:(CGRect)frame {
    
    LZBCalendarWeekView *weekView = [[LZBCalendarWeekView alloc] initWithFrame:frame];
    weekView.weekTitles = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekView;
}

#pragma mark - CollectionView
- (UICollectionView *)setupCollectionViewWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
    //325*403
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    flow.sectionInset =UIEdgeInsetsMake(0 , 0, 0, 0);
    
    flow.itemSize = CGSizeMake(frame.size.width/7, frame.size.width/7);
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.weekHeaderView.bottom, frame.size.width, 6 *frame.size.width/7) collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
//    _collectionView.scrollsToTop = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"LXCalenderCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    return self.collectionView;
}

-(NSMutableArray *)monthdataA{
    if (!_monthdataA) {
        _monthdataA =[NSMutableArray array];
    }
    return _monthdataA;
}

/*
 * 当前月的title颜色
 */
-(void)setCurrentMonthTitleColor:(UIColor *)currentMonthTitleColor{
    _currentMonthTitleColor = currentMonthTitleColor;
}
/*
 * 上月的title颜色
 */
-(void)setLastMonthTitleColor:(UIColor *)lastMonthTitleColor{
    _lastMonthTitleColor = lastMonthTitleColor;
}
/*
 * 下月的title颜色
 */
-(void)setNextMonthTitleColor:(UIColor *)nextMonthTitleColor{
    _nextMonthTitleColor = nextMonthTitleColor;
}

/*
 * 选中的背景颜色
 */
-(void)setSelectBackColor:(UIColor *)selectBackColor{
    _selectBackColor = selectBackColor;
}

/*
 * 选中的是否动画效果
 */

-(void)setIsHaveAnimation:(BOOL)isHaveAnimation{
    
    _isHaveAnimation  = isHaveAnimation;
}

/*
 * 是否禁止手势滚动
 */
-(void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}

/*
 * 是否显示上月，下月的按钮
 */

-(void)setIsShowLastAndNextBtn:(BOOL)isShowLastAndNextBtn{
    _isShowLastAndNextBtn  = isShowLastAndNextBtn;
    self.calendarHeaderView.isShowLeftAndRightBtn = isShowLastAndNextBtn;
}


/*
 * 是否显示上月，下月的的数据
 */
-(void)setIsShowLastAndNextDate:(BOOL)isShowLastAndNextDate{
    _isShowLastAndNextDate =  isShowLastAndNextDate;
}
/*
 * 今日的title颜色
 */

-(void)setTodayTitleColor:(UIColor *)todayTitleColor{
    _todayTitleColor = todayTitleColor;
}


@end
