//
//  NotificaitonIconItem.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificaitonIconItem.h"

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


///MARK: - Private Methods
- (void)mt_loadUI {
    [self addSubview:self.timeLab];
    [self addSubview:self.onlyIconLab];
}


- (void)mt_loadFrame {
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.onlyIconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(72, 23));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.onlyIconLab setRoundedCorners:LYZRectCornerTopLeft|LYZRectCornerBottomRight  withRadius:8.0];
    });
}


///MARK:- Getter and Setter
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = KMAINFONT14;
        _timeLab.textColor = kMAIN9999;
        _timeLab.text = @"10/17 23:27";
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


@end
