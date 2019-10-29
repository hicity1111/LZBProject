//
//  LZBBaseViewController+NavigationBar.h
//  LZBProject
//
//  Created by hicity on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZBBaseViewController (NavigationBar)

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;
- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action;
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;
- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;

- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction;
- (void)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction;
- (void)addRightFourBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction fourthImage:(UIImage *)fourthImage fourthAction:(SEL)fourthAction;
-(void)addNavigationBarTitleView:(NSString *)title;
-(void)addNavigationBarBtnTitleView:(NSString *)title action:(SEL)action;
- (void)addNavigationBarTitleView:(NSString *)title andDetailTitle:(NSString *)detailTitle;

@end

NS_ASSUME_NONNULL_END
