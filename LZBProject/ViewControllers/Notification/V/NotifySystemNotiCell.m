//
//  NotifySystemNotiCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifySystemNotiCell.h"

@interface NotifySystemNotiCell ()



@end

@implementation NotifySystemNotiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = TABLECELL_HIGHLIGHTED_COLOR;
    } else {
        self.backgroundColor = WHITECOLOR;
    }
}

#pragma mark - Custom Method


@end
