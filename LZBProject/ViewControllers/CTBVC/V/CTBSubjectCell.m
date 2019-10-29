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
    // Initialization code
    
    self.backgroundColor = kMAINF1F5;
    self.subject_nameLb.textColor = KMAIN5868;
    self.subject_descLb.textColor = KMAIN7777;
    
    self.containerView.layer.cornerRadius = 8.f;
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
