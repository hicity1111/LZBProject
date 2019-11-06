//
//  HomeWorkNotStartCell.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeWorkNotStartCell.h"

@interface HomeWorkNotStartCell ()

/// 中间容器
@property (weak, nonatomic) IBOutlet UIView *containerView;

/// 学科
@property (weak, nonatomic) IBOutlet UILabel *subjectLb;
/// 题型
@property (weak, nonatomic) IBOutlet UILabel *questionTypeLb;
/// 是否互批（如果是，下两个属性 hidden=NO，否则为YES）
@property (weak, nonatomic) IBOutlet UILabel *hupiLb;
@property (weak, nonatomic) IBOutlet UILabel *tagSepLine;

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
/// 图片标识
@property (weak, nonatomic) IBOutlet UIImageView *cellFlagImgV;


@end

@implementation HomeWorkNotStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HomeModel *)model{
    _model = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
