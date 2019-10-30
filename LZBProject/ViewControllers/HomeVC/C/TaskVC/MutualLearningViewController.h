//
//  MutualLearningViewController.h
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController.h"
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MutualLearningViewController : LZBBaseViewController

@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);

@property (nonatomic, strong) JXPagerView *pagingView;


@property (nonatomic, strong) NSArray *titles;

- (void)loadDataForFirst;
@end

NS_ASSUME_NONNULL_END
