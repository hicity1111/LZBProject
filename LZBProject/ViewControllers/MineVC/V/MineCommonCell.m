//
//  MineCommonCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "MineCommonCell.h"

@interface MineCommonCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftLb;

@end

@implementation MineCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
    
    if (self.cellIndex == 0) {
        [self setRoundedCorners: LYZRectCornerTop
        withRadius: 15.f];
    } else {
        [self noCornerRadius];
    }
}

- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
        
    switch (cellIndex) {
        case 0: {
            self.leftLb.text = @"手机号";
            self.rightLb.text = @"未绑定";
            break;
        }
        case 1: {
            self.leftLb.text = @"清除缓存";
            self.rightLb.text = @"0M";
            break;
        }
        case 2: {
            self.leftLb.text = @"用户协议";
            self.rightLb.text = @"";
            break;
        }
        case 3: {
            self.leftLb.text = @"版本号";
            self.rightLb.text = @"v1.0.0";
            break;
        }
        case 4: {
            self.leftLb.text = @"客服电话";
            self.rightLb.text = @"400-016-2123";
            break;
        }
        default:
            break;
    }
}

@end
