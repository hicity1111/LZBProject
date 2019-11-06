//
//  HomeWorkAlreadyStartCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeWorkAlreadyStartCell.h"
#import "GGProgressView.h"
#import "NSString+LZBMap.h"
#import "OYCountDownManager.h"
#import "UILabel+AttributedString.h"

@interface HomeWorkAlreadyStartCell (){
    NSInteger   _timeCountDown;
    CGFloat     _hw_progress;
}

/// 容器
@property (weak, nonatomic) IBOutlet UIView     *containerView;

/// 学科
@property (weak, nonatomic) IBOutlet UILabel    *subjectLb;
/// 题型
@property (weak, nonatomic) IBOutlet UILabel    *questionTypeLb;
/// 是否互批（如果是，下两个属性 hidden=NO，否则为YES）
@property (weak, nonatomic) IBOutlet UILabel    *hupiLb;
@property (weak, nonatomic) IBOutlet UILabel    *tagSepLine;

/// 图片标识
@property (weak, nonatomic) IBOutlet UIImageView *cellFlagImgV;
/// 作业名字
@property (weak, nonatomic) IBOutlet UILabel    *titleLb;
/// 时间
@property (weak, nonatomic) IBOutlet UILabel    *timeLb;
/// 题数
@property (weak, nonatomic) IBOutlet UILabel    *countLb;
/// 提示文字
@property (weak, nonatomic) IBOutlet UILabel    *promptLb;
/// 剩余时间
@property (weak, nonatomic) IBOutlet UILabel    *leftTimeLb;
/// 点我开始、点我继续、点我查看、去互批
@property (weak, nonatomic) IBOutlet UIButton   *actionButton;

/// 作业来源
@property (weak, nonatomic) IBOutlet UILabel    *homeworkSourceLb;
/// 进度父View
@property (weak, nonatomic) IBOutlet UIView     *progressView;

@property (weak, nonatomic) IBOutlet UILabel    *progressUpper;
@property (weak, nonatomic) IBOutlet UILabel    *progressLower;
@property (weak, nonatomic) IBOutlet UILabel    *progressDescLb;
@property (weak, nonatomic) IBOutlet UIView     *proView;

@property (nonatomic, strong) GGProgressView *ggprogressView;




@end

@implementation HomeWorkAlreadyStartCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    
    // 圆角
    self.containerView.layer.cornerRadius = 8.f;
    // 阴影
    self.containerView.layer.shadowColor = kMAIN7F7F.CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.containerView.layer.shadowOpacity = 1;
    self.containerView.layer.shadowRadius = 8;
    
    _ggprogressView = [[GGProgressView alloc] initWithFrame:self.proView.bounds progressViewStyle:GGProgressViewStyleAllFillet];
    _ggprogressView.layer.borderWidth = 0.5f;
    _ggprogressView.layer.borderColor = kMAIN00B5.CGColor;
    _ggprogressView.trackTintColor = KMAINFFFF;
    _ggprogressView.progressTintColor = kMAIN00B5;
    [self.proView addSubview:self.ggprogressView];
    
    [self.subjectLb setRoundedCorners:LYZRectCornerTopLeft
                           withRadius:8.f];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.actionButton.layer.cornerRadius = self.actionButton.height / 2.f;
    self.ggprogressView.frame = self.proView.bounds;
    self.ggprogressView.progress = _hw_progress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HomeModel *)model{
    _model = model;
    NSString *subjectText = [NSString mt_abbreviationMap:IFISNIL(model.subjectAbbreviation)];
    _subjectLb.text = subjectText;
    
    if ([subjectText isEqualToString:@"语文"]) {
        _subjectLb.textColor = kMAIN00A1;
        _subjectLb.backgroundColor = KMAINB2E3;
    }
    else if ([subjectText isEqualToString:@"数学"]) {
        _subjectLb.textColor = kMAIN4D93;
        _subjectLb.backgroundColor = [UIColor colorWithHex:@"#4D93FD" alpha:0.34];
    }
    else if ([subjectText isEqualToString:@"英语"]) {
        _subjectLb.textColor = kMAINAA6F;
        _subjectLb.backgroundColor = kMAINE4D1;
    }
    else if ([subjectText isEqualToString:@"物理"]) {
//        _subjectLb.textColor = kMAIN00A1;
//        _subjectLb.backgroundColor = KMAINB2E3;
    }
    else if ([subjectText isEqualToString:@"化学"]) {
//        _subjectLb.textColor = kMAIN00A1;
//        _subjectLb.backgroundColor = KMAINB2E3;
    }
    else if ([subjectText isEqualToString:@"生物"]) {
//        _subjectLb.textColor = kMAIN00A1;
//        _subjectLb.backgroundColor = KMAINB2E3;
    }
    
    
   NSInteger homeworkType = [model.homeworkType intValue];
   NSInteger homeworkIshp = model.homeworkIshp;
   if (homeworkType == 1) {//普通作业
       _questionTypeLb.text = @"普通";
   } else if (homeworkType == 2){
       _questionTypeLb.text = @"错题";
   } else if (homeworkType == 3){
       _questionTypeLb.text = @"听说";
   } else if (homeworkType == 4){
       _questionTypeLb.text = @"单词";
   } else if (homeworkType == 5){
       _questionTypeLb.text = @"阅读";
   } else if (homeworkType == 6){
       _questionTypeLb.text = @"作文";
   }
   if (homeworkIshp == 2) {//不是是互批
       _hupiLb.hidden = YES;
       _tagSepLine.hidden = YES;
       _cellFlagImgV.hidden = YES;
       
       [_questionTypeLb setRoundedCorners:LYZRectCornerBottomRight
                               withRadius:8.f];
       
   } else {//
       _hupiLb.hidden = NO;
       _tagSepLine.hidden = NO;
       _cellFlagImgV.hidden = NO;
       
       [_questionTypeLb noCornerRadius];
       [_hupiLb setRoundedCorners:LYZRectCornerBottomRight
                       withRadius:8.f];
   }
   _titleLb.text = _model.homeworkName;
   
   NSNumber *homeworkStarttime = model.homeworkEndtime;
   NSTimeInterval timeInterval=[homeworkStarttime doubleValue];
   NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
   NSString *homeworkEndtime = [self UTCStringFromUTCDate:UTCDate];
   
   _timeLb.text = [NSString stringWithFormat:@"截止时间%@",homeworkEndtime];//截止时间
   _countLb.text = [NSString stringWithFormat:@"题数%@",model.questionNumber];
   _promptLb.text = @"提交作业倒计时";
    
    NSInteger studentDoneQuestionNum = [_model.studentDoneQuestionNum intValue];
    
    NSInteger questionNumber = [_model.questionNumber intValue];
    
    if ([_model.studentDoneQuestionNum intValue] == 0) {
        [self.actionButton setTitle:@"点我开始" forState:UIControlStateNormal];
    }else{
        [self.actionButton setTitle:@"点我继续" forState:UIControlStateNormal];
    }
    _hw_progress = [_model.studentDoneQuestionNum floatValue]/[_model.questionNumber floatValue];
    
    _progressDescLb.text = [NSString stringWithFormat:@"%ld/%ld",studentDoneQuestionNum,questionNumber];
    
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeZone *current = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [current secondsFromGMTForDate:currentDate];
    NSDate *currentResult = [currentDate dateByAddingTimeInterval:interval];

    //截止时间
    
    NSTimeInterval utcInterval = [current secondsFromGMTForDate:UTCDate];
    NSDate *utcResult = [UTCDate dateByAddingTimeInterval:utcInterval];

    NSTimeInterval endTimeInterval = [utcResult timeIntervalSinceDate:currentResult];
    _timeCountDown = endTimeInterval;
    
    if (endTimeInterval < 5400) {//1.5小时
        _cellFlagImgV.hidden = NO;
        _cellFlagImgV.image = IMAGE_NAMED(@"pic_hp_tag_jijiangjiezhi");
        [self countDownNotification];
        if (endTimeInterval<0) {
            _cellFlagImgV.hidden = YES;
            self.leftTimeLb.text = @"作业超时";
        }
        _needCountDown = YES;
    }else{
        _needCountDown = NO;
        
        NSTimeInterval value =  _timeCountDown;
        // 天
        int day = (int)value / (24 *3600);
        // 小时
        int house = (int)value / 3600%3600;
        // 分
        int minute = (int)value /60%60;
        
        self.leftTimeLb.text = [NSString stringWithFormat:@"%02zd天%02zd小时%02zd分", day, house, minute];
    }
}

- (void)setResourcesModel:(HomeModel *)resourcesModel{
    _resourcesModel = resourcesModel;
    
    _subjectLb.text = [NSString mt_abbreviationMap:IFISNIL(_resourcesModel.subjectAbbreviation)];
      NSInteger homeworkType = _resourcesModel.resourceType;
      NSInteger homeworkIshp = _resourcesModel.homeworkIshp;
      if (homeworkType == 1) {//普通作业
          _questionTypeLb.text = @"视频";
      }else if (homeworkType == 2){
          _questionTypeLb.text = @"音频";
      }else if (homeworkType == 3){
          _questionTypeLb.text = @"图片";
      }
      _hupiLb.hidden = YES;
      _tagSepLine.hidden = YES;
      _cellFlagImgV.hidden = YES;

      _titleLb.text = _resourcesModel.resourceName;
    
    NSNumber *homeworkStarttime = _resourcesModel.createTime;
    NSTimeInterval timeInterval=[homeworkStarttime doubleValue];
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString *homeworkEndtime = [self UTCStringFromUTCDate:UTCDate];
    
    _timeLb.text = [NSString stringWithFormat:@"分享时间%@",homeworkEndtime];//截止时间
    _countLb.hidden = YES;
    _promptLb.hidden = YES;
    _leftTimeLb.hidden = YES;
    _homeworkSourceLb.hidden = NO;
    _homeworkSourceLb.textColor = kMAIN9696;
    _homeworkSourceLb.text = [NSString stringWithFormat:@"来自%@的分享",_resourcesModel.teacherName];
    [_homeworkSourceLb set_TextColor:KMAIN5868 range:NSMakeRange(2, _resourcesModel.teacherName.length)];
    _progressView.hidden = YES;
    
    [self.actionButton setTitle:@"点我查看" forState:UIControlStateNormal];
    
}

-(NSString *)UTCStringFromUTCDate:(NSDate *)UTCDate{
    
     NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
     [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSTimeZone *tz = [NSTimeZone systemTimeZone];
//     NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
     [dataFormatter setTimeZone:tz];
     NSString *UTCString = [dataFormatter stringFromDate:UTCDate];
     return UTCString;

 }

#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    if (!_needCountDown) {
        return;
    }
    
    /// 计算倒计时
    NSInteger countDown = _timeCountDown - kCountDownManager.timeInterval;
    
//    [self.model.count integerValue] - kCountDownManager.timeInterval;
    if (countDown < 0) return;
    
    NSTimeInterval value =  countDown;
    // 天
    int day = (int)value / (24 *3600);
    // 小时
    int house = (int)value / 3600%3600;
    // 分
    int minute = (int)value /60%60;
    self.leftTimeLb.text = [NSString stringWithFormat:@"%02zd天%02zd小时%02zd分", day, house, minute];
    /// 当倒计时到了进行回调
    if (countDown == 0) {
        self.leftTimeLb.text = @"没有完成作业哦";
        if (self.countDownZero) {
            self.countDownZero();
        }
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
