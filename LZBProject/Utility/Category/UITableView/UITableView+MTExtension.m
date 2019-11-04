//
//  UITableView+MTExtension.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UITableView+MTExtension.h"


@implementation UITableView (MTExtension)

/**  注册 UITableViewCell */
- (void)mt_registerCell:(Class)cellClass {
    
    NSAssert(cellClass != nil, @"cellClass 不能为 nil");
    
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

@end
