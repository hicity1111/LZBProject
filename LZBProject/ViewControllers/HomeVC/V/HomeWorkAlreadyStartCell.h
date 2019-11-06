//
//  HomeWorkAlreadyStartCell.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeWorkAlreadyStartCell : UITableViewCell

/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;

/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();
@property (nonatomic, strong) HomeModel *model;

@property (nonatomic, strong) HomeModel *resourcesModel;
@end

NS_ASSUME_NONNULL_END
