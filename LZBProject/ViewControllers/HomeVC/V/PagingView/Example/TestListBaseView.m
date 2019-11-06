//
//  TestListBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TestListBaseView.h"
#import "HomeWorkAlreadyStartCell.h"
#import "HomeWorkNotStartCell.h"
#import "NSDate+MTExtension.h"
#import "OYCountDownManager.h"


@interface TestListBaseView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@end

@implementation TestListBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"home_botton_bg")];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 140;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeWorkAlreadyStartCell" bundle:nil] forCellReuseIdentifier:@"HomeWorkAlreadyStartCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"HomeWorkNotStartCell" bundle:nil] forCellReuseIdentifier:@"HomeWorkNotStartCell"];
        [self addSubview:self.tableView];
        
//        MJWeakSelf
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        }];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 启动倒计时管理
    [kCountDownManager start];

    self.tableView.frame = self.bounds;
    
    LZBEmptyView *emptyView = [LZBEmptyView emptyViewWithImage:IMAGE_NAMED(@"pic_default_wrong") titleStr:@"还没有作业哦~" detailStr:@""];
    self.tableView.lzbemptyView = emptyView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeWorkAlreadyStartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeWorkAlreadyStartCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    HomeWorkNotStartCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"HomeWorkNotStartCell" forIndexPath:indexPath];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.backgroundColor = [UIColor clearColor];
    
    HomeModel *model = self.dataSource[indexPath.row];

    NSNumber *homeworkStarttime = model.homeworkStarttime;
    NSTimeInterval timeInterval=[homeworkStarttime doubleValue];
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];

    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeZone *current = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [current secondsFromGMTForDate:currentDate];
    NSDate *currentResult = [currentDate dateByAddingTimeInterval:interval];
    
    //截止时间
    NSTimeInterval utcInterval = [current secondsFromGMTForDate:UTCDate];
    NSDate *utcResult = [UTCDate dateByAddingTimeInterval:utcInterval];
    NSInteger times = [utcResult mt_minutesAfterDate:currentResult];

    if ([model.taskType intValue] == 1) {//任务

        if (times <= 0) {//作业开始
            cell.model = model;
//            if (times > 90) {//作业未开始
//                return cell1;
//            }else{//作业开始
                return cell;
//            }
        }else{//作业超时
            cell1.model = model;
            return cell1;
        }
    }else{//资源
        XLDLog(@"这个是资源");
        cell.resourcesModel = model;
        return cell;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}


#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self;
}

@end
