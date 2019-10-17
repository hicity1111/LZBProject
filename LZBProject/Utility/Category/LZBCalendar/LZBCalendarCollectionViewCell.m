//
//  LZBCalendarCollectionViewCell.m
//  LZBProject
//
//  Created by hicity on 2019/10/17.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendarCollectionViewCell.h"

@implementation LZBCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.todayCircle];
        [self addSubview:self.todayLabel];
        
    }
    return self;
}

- (UIView *)todayCircle{
    
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.8 * self.bounds.size.height, 0.8 * self.bounds.size.height)];
        _todayCircle.center = CGPointMake(0.5 * self.bounds.size.width, 0.5 * self.bounds.size.height);
        _todayCircle.layer.cornerRadius = 0.5 * _todayCircle.frame.size.width;
    }
    return _todayCircle;
    
}

- (UILabel *)todayLabel{
    if (_todayLabel == nil) {
        _todayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont lzb_fontForPingFangSC_RegularFontOfSize:11.0];
        _todayLabel.backgroundColor = [UIColor clearColor];
    }
    return _todayLabel;
}

- (void)setIsSelect:(BOOL)isSelect{
    [super setSelected:isSelect];
    if (isSelect) {
        _todayCircle.backgroundColor = KMAINFFA0;
    }else{
        _todayCircle.backgroundColor = KMAINFFFF;
    }
}
@end
