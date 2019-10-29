//
//  LZBBaseViewController+NavigationBar.m
//  LZBProject
//
//  Created by hicity on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController+NavigationBar.h"

@implementation LZBBaseViewController (NavigationBar)

- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    [firstButton setImage:image forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * kScreenWidth / 375.0, 0, 0)];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    firstButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action
{
    UIButton *leftbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    [leftbBarButton setTitleColor:KMAINFFFF forState:(UIControlStateNormal)];
    leftbBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    leftbBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 * kScreenWidth/375.0, 0, 0)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbBarButton];
}

- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action
{
    
    UIButton *rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    [rightbBarButton setTitleColor:KMAINFFFF forState:(UIControlStateNormal)];
    rightbBarButton.titleLabel.font = LZBFont(14, NO);
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    rightbBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5 * kScreenWidth/375.0)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbBarButton];
}

- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(40, 0, 40, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 8 * kScreenWidth/375.0)];
    [view addSubview:firstButton];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(0, 0, 40, 44);
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 15 * kScreenWidth/375.0)];
    [view addSubview:secondButton];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(80, 0, 40, 44);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 8 * kScreenWidth/375.0)];
    [view addSubview:firstButton];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(44, 0, 40, 44);
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 5 * kScreenWidth/375.0)];
    [view addSubview:secondButton];
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(0, 0, 40, 44);
    [thirdButton setImage:thirdImage forState:UIControlStateNormal];
    [thirdButton addTarget:self action:thirdAction forControlEvents:UIControlEventTouchUpInside];
    [thirdButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, - 5 * kScreenWidth/375.0)];
    [view addSubview:thirdButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (void)addRightFourBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction fourthImage:(UIImage *)fourthImage fourthAction:(SEL)fourthAction{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 145, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(110, 6, 30, 30);
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8 * kScreenWidth/375.0, 0, 0)];
    [view addSubview:firstButton];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(80, 6, 30, 30);
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8 * kScreenWidth/375.0, 0, 0)];
    [view addSubview:secondButton];
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(50, 6, 30, 30);
    [thirdButton setImage:thirdImage forState:UIControlStateNormal];
    thirdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [thirdButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8 * kScreenWidth/375.0, 0, 0)];
    [thirdButton addTarget:self action:thirdAction forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:thirdButton];
    
    UIButton *fourthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fourthButton.frame = CGRectMake(15, 6, 30, 30);
    [fourthButton setImage:fourthImage forState:UIControlStateNormal];
    [fourthButton addTarget:self action:fourthAction forControlEvents:UIControlEventTouchUpInside];
    fourthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [fourthButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8 * kScreenWidth/375.0, 0, 0)];
    [view addSubview:fourthButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}
-(void)addNavigationBarTitleView:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = KMAINFFFF;
    titlelabel.text = title;
    titlelabel.font = KMAINFONT16;
//    [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17*2/scaleFix750_1334];
    self.navigationItem.titleView = titlelabel;
}

-(void)addNavigationBarBtnTitleView:(NSString *)title action:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:IMAGE_NAMED(@"btn_triangle") forState:UIControlStateNormal];
//    btn.imageMode = CHImageModeRight;
    btn.titleLabel.font = KMAINFONT16;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    
}


- (void)addNavigationBarTitleView:(NSString *)title andDetailTitle:(NSString *)detailTitle{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 16)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = KMAINFFFF;
    titlelabel.text = title;
    titlelabel.font = [UIFont systemFontOfSize:15];
    [titleView addSubview:titlelabel];
    
    UILabel *detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 150, 14)];
    detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    detailTitleLabel.textColor = KMAINFFFF;
    detailTitleLabel.text = detailTitle;
    detailTitleLabel.font = [UIFont systemFontOfSize:12];
    [titleView addSubview:detailTitleLabel];
    
    self.navigationItem.titleView = titleView;
}
@end
