//
//  MutualLearningViewController.h
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBBaseViewController.h"
#import "JXPagerView.h"
#import "HomeDataService.h"


@interface MutualLearningViewController : LZBBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);

@property (nonatomic, strong) JXPagerView *pagingView;

@property (nonatomic, strong) NSArray *titles;

/// 任务链表数据
@property (nonatomic, strong) NSMutableArray *resultTaskArr;

@property (nonatomic, strong) HomeDataService *dataService;


- (void)loadDataForFirst;
@end

