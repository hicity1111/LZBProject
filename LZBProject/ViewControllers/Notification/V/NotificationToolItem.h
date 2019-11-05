//
//  NotificationToolItem.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NotifyListEntry;
@interface NotificationToolItem : UIView

///数据模型
@property (nonatomic, strong) NotifyListEntry *model;


@end

NS_ASSUME_NONNULL_END
