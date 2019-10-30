//
//  MineLogoutCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "MineLogoutCell.h"

@implementation MineLogoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = UIColor.lightGrayColor;
    } else {
        self.backgroundColor = WHITECOLOR;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self adjustMyFram];
}

- (void)adjustMyFram {
    CGFloat leftMargin = 15.f;
    self.frame = CGRectMake(leftMargin, self.top, kScreenWidth - 2 * leftMargin, self.height);
    
    [self setRoundedCorners: LYZRectCornerBottom
                 withRadius: 15.f];
}

@end
