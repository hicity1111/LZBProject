//
//  NotificationListCell.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NotifyListEntry;
@interface NotificationListCell : UITableViewCell

///数据索引
@property (nonatomic, strong) NSIndexPath *index;
///数据模型
@property (nonatomic, strong) NotifyListEntry *model;
///是否开启多选状态
@property (nonatomic, assign) BOOL isMulSelectedStatus;
///选择按钮回调事件
@property (nonatomic, copy) void(^itemSelectedCallBack)(NotifyListEntry *model, NSIndexPath *index);

///计算并缓存cell高度
+ (CGFloat)computeNotifyCellHeight:(NotifyListEntry *)model;

@end

NS_ASSUME_NONNULL_END
