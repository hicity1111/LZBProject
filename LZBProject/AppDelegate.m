//
//  AppDelegate.m
//  LZBProject
//
//  Created by hicity on 2019/10/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LZBBaseTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (kSysVersion < 13.0) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = UIColor.whiteColor;
        [self.window makeKeyAndVisible];
        
        [self addKeyboardManager];
        [self entryDoor];
    }
    
    return YES;
}

#pragma mark - KeyboardManager
- (void)addKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.toolbarTintColor = [UIColor redColor];
    //是否显示工具条
    manager.enableAutoToolbar = YES;
    [manager setToolbarManageBehaviour:IQAutoToolbarByPosition];
}

#pragma mark - 界面入口
- (void)entryDoor {
    BOOL isLogin = NO;
    
    if (isLogin) {
        [self entryMainVC];
    } else {
        [self entryLoginVC];
    }
}

- (void)entryMainVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LZBBaseTabBarController *view = [storyboard instantiateViewControllerWithIdentifier:@"LZBBaseTabBarController"];
    self.window.rootViewController = view;
}

- (void)entryLoginVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    self.window.rootViewController = [storyboard instantiateInitialViewController];
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    }
    return [[UISceneConfiguration alloc] init];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Notifications

//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    if (@available(iOS 13.0, *)) {
//        if (![deviceToken isKindOfClass:[NSData class]])
//            return;
//        
//        const unsigned *tokenBytes = [deviceToken bytes];
//        NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
//                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
//                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
//                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
//        NSLog(@"deviceToken : %@", hexToken);
//    } else {
//        NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<> -"]];
//        NSLog(@"deviceToken = %@", token);
//    }
//}
//
//// 注册远程通知失败后，会调用这个方法
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"注册远程通知失败----%@", error.localizedDescription);
//}
//
///**
// 当接收到远程通知（实现了这个方法，则上面的方法不再执行）
// 前台（会调用）
// 从后台进入到前台（会调用）
// 完全退出再进入APP （也会调用这个方法）
// 
// 如果要实现：只要接收到通知，不管当前应用在前台、后台、还是锁屏，都执行这个方法
//    > 必须勾选后台模式 Remote Notification
//    > 告诉系统是否有新的内容更新（执行完成代码块）
//    > 设置发送通知的格式 {"content-available" : "随便传"} （在 aps 键里面设置）
// */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    NSLog(@"收到远程通知2----%@", userInfo);
//
//    // 调用系统回调代码块的作用
//    //  > 系统会估量app消耗的电量，并根据传递的 `UIBackgroundFetchResult` 参数记录新数据是否可用
//    //  > 调用完成的处理代码时，应用的界面缩略图会更新
//    completionHandler(UIBackgroundFetchResultNewData);
//}


@end
