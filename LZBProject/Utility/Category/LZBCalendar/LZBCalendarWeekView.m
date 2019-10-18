//
//  LZBCalendarWeekView.m
//  LZBProject
//
//  Created by hicity on 2019/10/18.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendarWeekView.h"

@implementation LZBCalendarWeekView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setWeekTitles:(NSArray *)weekTitles{
    
    _weekTitles = weekTitles;
    CGFloat height = self.height;
    CGFloat width = self.width / weekTitles.count;
    
    [weekTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(idx * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekTitles[idx];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weekTitles[idx];
        label.textColor = KMAIN5868;
        label.font = [UIFont lzb_fontForPingFangSC_MediumFontOfSize:11];
        [self addSubview:label];
    }];    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
