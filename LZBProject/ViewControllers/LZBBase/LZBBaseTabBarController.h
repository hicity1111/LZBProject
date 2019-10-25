//
//  LZBBaseTabBarController.h
//  LZBProject
//
//  Created by hicity on 2019/10/21.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZB_TabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZBBaseTabBarController : UITabBarController

@property (nonatomic, strong) LZB_TabBar *lzbTabBar;

@end

NS_ASSUME_NONNULL_END
