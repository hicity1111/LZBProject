//
//  AppDelegate+APNS.m
//  LZBProject
//
//  Created by liyan on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "AppDelegate+APNS.h"


#ifdef DEBUG
    #define ApsForProduction 0
#else
    #define ApsForProduction 1
#endif

@interface AppDelegate() <JPUSHRegisterDelegate>

@end

@implementation AppDelegate (APNS)


/**
 注册远程通知

 @param application application
 @param launchOptions launchOptions
 */
- (void)mt_registerApnsApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"e4d262464c299739bc3cec82"
                          channel:@"App Store"
                 apsForProduction:ApsForProduction
            advertisingIdentifier:nil];
    
}










@end
