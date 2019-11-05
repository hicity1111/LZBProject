//
//  HomeWorkAlreadyStartCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeWorkAlreadyStartCell.h"
#import "GGProgressView.h"

@interface HomeWorkAlreadyStartCell ()

/// 容器
@property (weak, nonatomic) IBOutlet UIView *containerView;

/// 学科
@property (weak, nonatomic) IBOutlet UILabel *subjectLb;
/// 题型
@property (weak, nonatomic) IBOutlet UILabel *questionTypeLb;
/// 是否互批（如果是，下两个属性 hidden=NO，否则为YES）
@property (weak, nonatomic) IBOutlet UILabel *hupiLb;
@property (weak, nonatomic) IBOutlet UILabel *tagSepLine;

/// 图片标识
@property (weak, nonatomic) IBOutlet UIImageView *cellFlagImgV;
/// 作业名字
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
/// 题数
@property (weak, nonatomic) IBOutlet UILabel *countLb;
/// 提示文字
@property (weak, nonatomic) IBOutlet UILabel *promptLb;
/// 剩余时间
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLb;
/// 点我开始、点我继续、点我查看、去互批
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

/// 作业来源
@property (weak, nonatomic) IBOutlet UILabel *homeworkSourceLb;
/// 进度父View
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UILabel *progressUpper;
@property (weak, nonatomic) IBOutlet UILabel *progressLower;
@property (weak, nonatomic) IBOutlet UILabel *progressDescLb;
@property (weak, nonatomic) IBOutlet UIView *proView;

@property (nonatomic, strong) GGProgressView *ggprogressView;




@end

@implementation HomeWorkAlreadyStartCell

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.ggprogressView.frame.size = self.proView.frame.size;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    _ggprogressView = [[GGProgressView alloc] initWithFrame:self.proView.bounds progressViewStyle:GGProgressViewStyleAllFillet];
    _ggprogressView.layer.borderWidth = 0.5f;
    _ggprogressView.layer.borderColor = kMAIN00B5.CGColor;
    _ggprogressView.progress = 0.8;
    _ggprogressView.trackTintColor = KMAINFFFF;
    _ggprogressView.progressTintColor = kMAIN00B5;
    [self.proView addSubview:self.ggprogressView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HomeModel *)model{
    _model = model;
    
}
@end
