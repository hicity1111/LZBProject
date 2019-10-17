//
//  LZBCalendarCollectionViewCell.h
//  LZBProject
//
//  Created by hicity on 2019/10/17.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *todayCircle; //!< 表示'今天'

@property (nonatomic, strong) UILabel *todayLabel; //!< 表示日期（几号）

@property (nonatomic, assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
