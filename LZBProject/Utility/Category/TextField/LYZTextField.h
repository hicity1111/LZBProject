//
//  LYZTextField.h
//  zhixinContest
//
//  Created by zhixin on 16/6/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYZTextField : UITextField

@property (nonatomic, strong) UIView *cusLeftView;

@property (nonatomic, strong) UIView *cusRightView;

@property (nonatomic, assign) CGFloat leftMargin;

@property (nonatomic, assign) CGFloat rightMargin;

@end
