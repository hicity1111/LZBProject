//
//  LZBCalendarHeaderView.m
//  LZBProject
//
//  Created by hicity on 2019/10/18.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendarHeaderView.h"

@implementation LZBCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat height = frame.size.height;
        CGFloat width  = frame.size.width;
        
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, height, height)];
        [_leftButton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xianghou_normal") forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        self.yearAndMonthLabel = [[UILabel alloc] init];
        self.yearAndMonthLabel.frame = CGRectMake(_leftButton.right, 0, 100,height);
        self.yearAndMonthLabel.textColor = KMAIN00A2;
        self.yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
        self.yearAndMonthLabel.font = [UIFont lzb_fontForPingFangSC_RegularFontOfSize:13];
        self.yearAndMonthLabel.backgroundColor = KMAINFFFF;
        [self addSubview:self.yearAndMonthLabel];
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.yearAndMonthLabel.right, 0, height, height)];
        [_rightButton setImage:IMAGE_NAMED(@"tanchuang_xuangzeriqi_xiangqian_normal") forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        #pragma mark - 全部按钮
        _totalButton = [[UIButton alloc] init];
        _totalButton.size = CGSizeMake(56, 20);
        _totalButton.centerY = _rightButton.centerY;
        _totalButton.center = CGPointMake(self.width - 46, _rightButton.centerY);
        [_totalButton setTitle:@"全部" forState:UIControlStateNormal];
        [_totalButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
        _totalButton.titleLabel.font = [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:13];
        [_totalButton setBackgroundImage:IMAGE_NAMED(@"tab_homework_leixing_normal") forState:UIControlStateNormal];
        [_totalButton setBackgroundImage:IMAGE_NAMED(@"btn_zujian_zuoyeliebiao_quanbu_press") forState:UIControlStateHighlighted];
        _totalButton.adjustsImageWhenHighlighted = NO;
        [_totalButton addTarget:self action:@selector(totalAct) forControlEvents:UIControlEventTouchUpInside];
        _totalButton.centerY = _rightButton.centerY;
        [self addSubview:_totalButton];
        
        UIImageView *bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, self.bottom - 2, self.width - 18*2, 2)];
        bottomImage.image = IMAGE_NAMED(@"tanchuang_xuangzeriqi_fengexian_normal");
        [self addSubview:bottomImage];
    }
    return self;
}

- (void)setDateStr:(NSString *)dateStr{
    _dateStr = dateStr;
    self.yearAndMonthLabel.text = dateStr;
}
/// 全部按钮
- (void)totalAct{
    if (self.totalClickBlock) {
        self.totalClickBlock();
    }
}

- (void)leftBtnOnClick:(UIButton *)button{
    if (self.leftClickBlock) {
        self.leftClickBlock();
    }
}

-(void)rightBtnOnClick:(UIButton *)button{
    if (self.rightClickBlock) {
        self.rightClickBlock();
    }
}

-(void)setIsShowLeftAndRightBtn:(BOOL)isShowLeftAndRightBtn{
    _isShowLeftAndRightBtn = isShowLeftAndRightBtn;
    self.leftButton.hidden = self.rightButton.hidden = !isShowLeftAndRightBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
