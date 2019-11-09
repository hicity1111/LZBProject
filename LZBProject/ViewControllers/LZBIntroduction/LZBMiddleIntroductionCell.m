//
//  LZBMiddleIntroductionCell.m
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBMiddleIntroductionCell.h"

@implementation LZBMiddleIntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (IS_IPHONE) {
        _leftTopWidth.constant = 193*kWidthScale;
        
        _topWidth.constant = 265*kWidthScale;
        
        _middleWidth.constant = 337*kWidthScale;
        
        _bottomWidth.constant = 326*kWidthScale;
        
        _rightBottomWidth.constant = 260*kWidthScale;

        _topPadding.constant = 35*kHeightScale;
        
        _middlePadding.constant = 61*kHeightScale;
        
        _bottomPadding.constant = 22*kHeightScale;
    }

    
//    _leftPadding.constant = 30*kWidthScale;
    // Initialization code
}

@end
