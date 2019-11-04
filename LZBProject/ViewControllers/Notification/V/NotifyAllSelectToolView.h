//
//  NotifyAllSelectToolView.h
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifyAllSelectToolView : UIView

///全选回调
@property (nonatomic, copy) void(^allSelectedCallBack)(BOOL isSelected);
///删除回调
@property (nonatomic, copy) void(^deleteEventCallBack)(void);

///重置状态
- (void)resetData;

///更新删除num
- (void)updateDelNums:(NSInteger)nums;

@end

NS_ASSUME_NONNULL_END
