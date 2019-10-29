//
//  PendingTasksViewController.h
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController.h"
#import "LZBBaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PendingTasksViewController : LZBBaseViewController

@property (nonatomic, strong) LZBBaseNavigationController *naviController;

@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);

- (void)loadDataForFirst;

@end

NS_ASSUME_NONNULL_END
