//
//  CTBSubjectCell.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTBSubjectCell : UITableViewCell

/// 科目图片
@property (weak, nonatomic) IBOutlet UIImageView *subject_imgV;

/// 科目名称
@property (weak, nonatomic) IBOutlet UILabel *subject_nameLb;

/// 描述
@property (weak, nonatomic) IBOutlet UILabel *subject_descLb;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

NS_ASSUME_NONNULL_END
