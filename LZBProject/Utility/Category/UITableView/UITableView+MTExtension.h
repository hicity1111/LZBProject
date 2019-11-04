//
//  UITableView+MTExtension.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MTExtension)

/**注册 UITableViewCell */
- (void)mt_registerCell:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
