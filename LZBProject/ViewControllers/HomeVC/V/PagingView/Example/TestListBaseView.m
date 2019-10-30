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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.tableView.frame = self.bounds;
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
    
    if (indexPath.row%2 == 0) {
        return cell1;
    }else{
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
