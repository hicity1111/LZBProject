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

@interface PendingTasksViewController : UITableViewController <JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) LZBBaseNavigationController *naviController;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);

- (void)loadDataForFirst;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

@end


NS_ASSUME_NONNULL_END
