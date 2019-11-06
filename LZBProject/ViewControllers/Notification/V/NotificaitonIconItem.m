//
//  NotificaitonIconItem.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificaitonIconItem.h"
#import "NotifyListEntry.h"
#import "NSDate+MTExtension.h"
#import "NSString+LZBMap.h"


@interface NotificaitonIconItem()
///时间组件
@property (nonatomic, strong) UILabel *timeLab;
///左侧标签  左上角设置圆角
@property (nonatomic, strong) UILabel *leftIconLab;
///中间标签  没有圆角
@property (nonatomic, strong) UILabel *middleIconLab;
///右侧标签
@property (nonatomic, strong) UILabel *rightIconLab;
///只有一个标签  左上角 或者 右下角 圆角
@property (nonatomic, strong) UILabel *onlyIconLab;

@end

@implementation NotificaitonIconItem

///MARK:- 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mt_loadUI];
        [self mt_loadFrame];
    }
    return self;
}


///MARK:- 赋值
- (void)setModel:(NotifyListEntry *)model {
    _model = model;
    self.timeLab.text = [NSDate mt_timeStamp:IFISNIL(model.noticeSendtime) formate:@"MM/dd HH:mm"];
    
    MJWeakSelf
    if ([IFISNIL(model.subjectAbbreviation) length] > 0) {
        self.leftIconLab.text = [NSString mt_abbreviationMap:IFISNIL(model.subjectAbbreviation)];
        [self.leftIconLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(47);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.leftIconLab setRoundedCorners:LYZRectCornerTopLeft withRadius:8.0];
            [weakSelf.onlyIconLab setRoundedCorners:LYZRectCornerBottomRight  withRadius:8.0];
        });
        
    } else {
        self.leftIconLab.text = @"";
        [self.leftIconLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.onlyIconLab setRoundedCorners:LYZRectCornerTopLeft|LYZRectCornerBottomRight  withRadius:8.0];
         });
    }
    
    
    if (model.noticeType == 1) {
        self.onlyIconLab.text = @"系统消息";
        self.onlyIconLab.backgroundColor = [UIColor colorWithRed:133/255.0 green:139/255.0 blue:212/255.0 alpha:0.34];
        self.onlyIconLab.textColor = [UIColor colorWithRed:99/255.0 green:102/255.0 blue:149/255.0 alpha:1.0];
    } else if (model.noticeType == 4) {
        self.onlyIconLab.text = @"班级通知";
        self.onlyIconLab.backgroundColor = [UIColor colorWithRed:250/255.0 green:234/255.0 blue:219/255.0 alpha:0.6];
        self.onlyIconLab.textColor = [UIColor colorWithRed:30/255.0 green:162/255.0 blue:106/255.0 alpha:1.0];
    } else if (model.noticeType == 9 || model.noticeType == 10) {
        self.onlyIconLab.text = @"重批申请";
        self.onlyIconLab.backgroundColor = [UIColor colorWithRed:250/255.0 green:234/255.0 blue:219/255.0 alpha:0.6];
        self.onlyIconLab.textColor = [UIColor colorWithRed:30/255.0 green:162/255.0 blue:106/255.0 alpha:1.0];
    } else {
        self.onlyIconLab.text = @"";
        self.onlyIconLab.backgroundColor = [UIColor colorWithRed:133/255.0 green:139/255.0 blue:212/255.0 alpha:0.34];
        self.onlyIconLab.textColor = [UIColor colorWithRed:99/255.0 green:102/255.0 blue:149/255.0 alpha:1.0];
    }
    
 
  

}


///MARK: - Private Methods
- (void)mt_loadUI {
    [self addSubview:self.timeLab];
    [self addSubview:self.onlyIconLab];
    [self addSubview:self.leftIconLab];
}


- (void)mt_loadFrame {
    MJWeakSelf
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.leftIconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(0, 23));
    }];
    
    [self.onlyIconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(weakSelf.leftIconLab.mas_right);
        make.size.mas_equalTo(CGSizeMake(73, 23));
    }];
    
  

}


///MARK:- Getter and Setter
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = KMAINFONT14;
        _timeLab.textColor = kMAIN9999;
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

- (UILabel *)onlyIconLab {
    if (!_onlyIconLab) {
        _onlyIconLab = [UILabel new];
        _onlyIconLab.textAlignment = NSTextAlignmentCenter;
        _onlyIconLab.text = @"系统消息";
        _onlyIconLab.backgroundColor = [UIColor colorWithRed:133/255.0 green:139/255.0 blue:212/255.0 alpha:1.0];
        _onlyIconLab.font = KMAINFONT14;
        _onlyIconLab.textColor = [UIColor colorWithRed:99/255.0 green:102/255.0 blue:149/255.0 alpha:1.0];
    }
    return _onlyIconLab;
}

- (UILabel *)leftIconLab {
    if (!_leftIconLab) {
         _leftIconLab = [UILabel new];
         _leftIconLab.textAlignment = NSTextAlignmentCenter;
         _leftIconLab.text = @"";
         _leftIconLab.backgroundColor = [UIColor colorWithRed:178/255.0 green:227/255.0 blue:226/255.0 alpha:0.6];
         _leftIconLab.font = KMAINFONT14;
         _leftIconLab.textColor = [UIColor colorWithRed:0/255.0 green:161/255.0 blue:159/255.0 alpha:1.0];
    }
    return _leftIconLab;
}


@end
