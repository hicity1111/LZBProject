//
//  HomeWorkNotStartCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeWorkNotStartCell.h"
#import "NSString+LZBMap.h"
#import "OYCountDownManager.h"
#import "LZBSubjectLabelColorModel.h"

@interface HomeWorkNotStartCell ()

/// 中间容器
@property (weak, nonatomic) IBOutlet UIView *containerView;

/// 学科
@property (weak, nonatomic) IBOutlet UILabel *subjectLb;
/// 题型
@property (weak, nonatomic) IBOutlet UILabel *questionTypeLb;
/// 是否互批（如果是，下两个属性 hidden=NO，否则为YES）
@property (weak, nonatomic) IBOutlet UILabel *hupiLb;
@property (weak, nonatomic) IBOutlet UILabel *tagSepLine;

/// 作业名字
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
/// 题数
@property (weak, nonatomic) IBOutlet UILabel *countLb;
/// 提示文字
@property (weak, nonatomic) IBOutlet UILabel *promptLb;
/// 剩余时间
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLb;
/// 图片标识
@property (weak, nonatomic) IBOutlet UIImageView *cellFlagImgV;
/// 蒙层
@property (weak, nonatomic) IBOutlet UIView *coverV;


@end

@implementation HomeWorkNotStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 圆角
    self.containerView.layer.cornerRadius = 8.f;
    self.coverV.layer.cornerRadius = 8.f;
    
    // 阴影
    self.containerView.layer.shadowColor = kMAIN7F7F.CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.containerView.layer.shadowOpacity = 1;
    self.containerView.layer.shadowRadius = 8;
    
    [self.leftTimeLb setCornerRadiusAuto];
    
    [self.subjectLb setRoundedCorners:LYZRectCornerTopLeft
                           withRadius:8.f];
    self.subjectLb.clipsToBounds = YES;
}

- (void)setModel:(HomeModel *)model{
    _model = model;
    
    NSString *subjectText = [NSString mt_abbreviationMap:IFISNIL(model.subjectAbbreviation)];
    LZBSubjectLabelColorModel *slcModel = [LZBSubjectLabelColorModel getModelWithSubjectName:subjectText];
    _subjectLb.text = subjectText;
    _subjectLb.textColor = slcModel.textColor;
    _subjectLb.backgroundColor = slcModel.backgroundColor;
    
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
        _questionTypeLb.clipsToBounds = YES;
    } else {//
        _hupiLb.hidden = NO;
        _tagSepLine.hidden = NO;
        _cellFlagImgV.hidden = NO;
        
        [_questionTypeLb noCornerRadius];
        [_hupiLb setRoundedCorners:LYZRectCornerBottomRight
                        withRadius:8.f];
        _hupiLb.clipsToBounds = YES;
    }
    _titleLb.text = _model.homeworkName;
    
    NSNumber *homeworkStarttime = model.homeworkStarttime;
    NSTimeInterval timeInterval=[homeworkStarttime doubleValue];
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString *homeworkEndtime = [self UTCStringFromUTCDate:UTCDate];
    
    _timeLb.text = [NSString stringWithFormat:@"开始时间%@",homeworkEndtime];//截止时间
    _countLb.text = [NSString stringWithFormat:@"题数%@",model.questionNumber];
    _promptLb.text = @"距离开始时间";
    
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeZone *current = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [current secondsFromGMTForDate:currentDate];
    NSDate *currentResult = [currentDate dateByAddingTimeInterval:interval];

    //截止时间
    NSTimeInterval utcInterval = [current secondsFromGMTForDate:UTCDate];
    NSDate *utcResult = [UTCDate dateByAddingTimeInterval:utcInterval];

    NSTimeInterval endTimeInterval = [utcResult timeIntervalSinceDate:currentResult];
    NSInteger _timeCountDown = endTimeInterval;

    NSTimeInterval value =  _timeCountDown;
    int day = (int)value / (24 *3600);
    int house = (int)value / 3600%3600;
    int minute = (int)value /60%60;
    self.leftTimeLb.text = [NSString stringWithFormat:@"%02d天%02d小时%02d分", day, house, minute];
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
