//
//  LZBBaseViewController.h
//  LZBProject
//
//  Created by hicity on 2019/10/18.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "ViewController.h"
#import "LZBNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZBBaseViewController : UIViewController

@property (nonatomic, strong) LZBNavigationBar *navView;


///  子类调用改方法 默认
/// @param str title 字符串 navView.hidden = NO
- (void)mt_showNavigationTitle:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
