//
//  NotifyListEntry.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifyListEntry : NSObject

///测试字段
@property (nonatomic, assign) NSInteger imageNums;
///MARK:- 自定义字段
//高度缓存
@property (nonatomic, assign) CGFloat cellHeight;
//是否选中状态 默认false 非选中状态
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
