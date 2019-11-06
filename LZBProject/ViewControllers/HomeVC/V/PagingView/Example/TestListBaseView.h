//
//  TestListBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

/**！定义刷新block*/
typedef void(^ refreshBlock)(void);

@interface TestListBaseView : UIView <JXPagerViewListViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;





@end
