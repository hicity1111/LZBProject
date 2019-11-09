//
//  AppDelegate+APNS.h
//  LZBProject
//
//  Created by liyan on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//


#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (APNS)

/**
 注册远程通知

 @param application application
 @param launchOptions launchOptions
 */
- (void)mt_registerApnsApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
