//
//  LZBMiddleIntroductionCell.h
//  LZBProject
//
//  Created by hicity on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBMiddleIntroductionCell : UICollectionViewCell
/// 顶部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTopHeight;
/// 顶部宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTopWidth;

/// 上面图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWidth;

/// 中间图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleWidth;

/// 底部图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomWidth;
//底部边框图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBottomWidth;

//上面图片间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topPadding;

//中间图片距离顶部按钮间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middlePadding;

/// 最下面间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomPadding;

@end

NS_ASSUME_NONNULL_END
