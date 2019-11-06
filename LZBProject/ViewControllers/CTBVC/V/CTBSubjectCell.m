//
//  CTBSubjectCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "CTBSubjectCell.h"

@interface CTBSubjectCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CTBSubjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subject_nameLb.textColor = KMAIN5868;
    self.subject_descLb.textColor = kMAIN7777;
    
    // 圆角
    self.containerView.layer.cornerRadius = 8.f;
    
    // 阴影
    self.containerView.layer.shadowColor = kMAIN7F7F.CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.containerView.layer.shadowOpacity = 1;
    self.containerView.layer.shadowRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.containerView.backgroundColor = UIColor.lightGrayColor;
    } else {
        self.containerView.backgroundColor = WHITECOLOR;
    }
}

@end
