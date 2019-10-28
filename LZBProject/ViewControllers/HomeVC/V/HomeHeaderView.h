//
//  HomeHeaderView.h
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeHeaderDelegate <NSObject>

- (void)messageAct;
@end

@interface HomeHeaderView : UIView

@property (nonatomic, weak) id<HomeHeaderDelegate> delegate;

/// 标题文字
@property (nonatomic, strong) NSString *titleString;

/// 标题图片
@property (nonatomic, strong) UIImage *titleImage;

/// 消息button
@property (nonatomic, strong) JMButton *messageButton;

/// login
@property (nonatomic, strong) UIImageView *imageView;



/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

- (void)showNumberBadgeValue:(NSString *)badgeValue;

- (void)removeBadgValue;


@end

NS_ASSUME_NONNULL_END
