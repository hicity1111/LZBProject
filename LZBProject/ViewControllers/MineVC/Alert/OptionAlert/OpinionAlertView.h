//
//  OpinionAlertView.h
//  LZBProject
//
//  Created by hicity on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBottonView.h"
#import "XSDTextView.h"


NS_ASSUME_NONNULL_BEGIN

@interface OpinionAlertView : UIView

@property (nonatomic, strong) CustomBottonView *customBottonView;

@property (nonatomic, strong) UILabel *optionTitle;

@property (nonatomic, strong) XSDTextView *textView;

@property (nonatomic, strong) UIButton *sendBUutton;

- (void)showAlert;

@end

NS_ASSUME_NONNULL_END
