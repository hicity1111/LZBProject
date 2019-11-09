//
//  LZBIntroductionCell.m
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBIntroductionCell.h"

@implementation LZBIntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (IS_IPHONE) {
        _leftTopWidth.constant = 193*kWidthScale;
        
        _topWidth.constant = 265*kWidthScale;
        
        _middleWidth.constant = 271*kWidthScale;
        
        _bottomWidth.constant = 261.5*kWidthScale;
        
        _rightBottomWidth.constant = 260*kWidthScale;

        _topPadding.constant = 34*kHeightScale;
        
        _middlePadding.constant = 30.5*kHeightScale;
        
        _leftPadding.constant = 30*kWidthScale;
    }

}

@end
