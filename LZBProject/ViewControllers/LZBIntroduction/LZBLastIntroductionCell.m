//
//  LZBLastIntroductionCell.m
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBLastIntroductionCell.h"

@implementation LZBLastIntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (IS_IPHONE) {
        
        _leftTopWidth.constant = 193*kWidthScale;
        
        _topWidth.constant = 265*kWidthScale;
        
        _middleWidth.constant = 225.5*kWidthScale;
        
        _bottomWidth.constant = 326*kWidthScale;
        
        _rightBottomWidth.constant = 260*kWidthScale;

        _topPadding.constant = 35*kHeightScale;
        
        _middlePadding.constant = 16.5*kHeightScale;
        
        _leftPadding.constant = 30*kWidthScale;
        
        _buttonWidth.constant = 150*kWidthScale;
        
        _startButton.layer.cornerRadius = 20*kWidthScale;

    }

    [_startButton setTitle:@"开始使用" forState:UIControlStateNormal];
    [_startButton setBackgroundColor:kMAIN0098];
    _startButton.titleLabel.font  = LZBMediumFont(18);
    [_startButton setTitleColor:KMAINFFFF forState:UIControlStateNormal];
//    _startButton.layer.borderWidth = 1.5;
//    _startButton.layer.borderColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
    
    self.startButton.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
    self.startButton.layer.shadowOffset = CGSizeMake(0, 1);
    self.startButton.layer.shadowOpacity = 1.0;
    self.startButton.layer.shadowRadius = 20*kWidthScale;
}
- (IBAction)startAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickEnter)]) {
        [self.delegate didClickEnter];
    }
}

@end
