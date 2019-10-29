//
//  JXCategoryIndicatorSpringBackgroundView.m
//  LZBProject
//
//  Created by hicity on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "JXCategoryIndicatorSpringBackgroundView.h"

@implementation JXCategoryIndicatorSpringBackgroundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorHeight = 20;
        self.scrollAnimationDuration = 0.5;
        self.indicatorColor = kMAIN00B5;
        self.indicatorWidthIncrement  = 20;
    }
    return self;
}

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    
    CGFloat width = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat height = [self indicatorHeightValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - width)/2;
    CGFloat y = (model.selectedCellFrame.size.height - height)/2;
    CGRect toFrame = CGRectMake(x, y, width, height);

    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = toFrame;
        } completion:nil];
    }else {
        self.frame = toFrame;
    }
}

@end
