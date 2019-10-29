//
//  HomeWorkAlreadyStartCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeWorkAlreadyStartCell.h"

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




@end

@implementation HomeWorkAlreadyStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
