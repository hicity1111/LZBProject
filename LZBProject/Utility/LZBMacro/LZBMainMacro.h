//
//  LZBMainMacro.h
//  LZBProject
//
//  Created by hicity on 2019/10/11.
//  Copyright © 2019 hicity. All rights reserved.
//

#ifndef LZBMainMacro_h
#define LZBMainMacro_h


#define isLandscape ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft \
|| [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)

#define isIOS8_or_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kScreen_Bounds (isIOS8_or_Later ? [UIScreen mainScreen].bounds : (isLandscape ? CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) : [UIScreen mainScreen].bounds))


/*** 判断当前设备类型 */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)


// 系统UI相关
#define kTopBarHeight ((iPhoneX || iPhoneXSMax || iPhoneXR) ? 88.0f : 64.0f)
#define kTabBarHeight ((iPhoneX || iPhoneXSMax || iPhoneXR) ? 83.0f : 49.0f)

//状态栏的高度
#define StateBar_Height ((iPhoneX || iPhoneXSMax || iPhoneXR) ? 44.0f : 20.0f)

//NavigationBar的高度
#define NavBar_Height 44


#define kScreenHeight (isIOS8_or_Later ? [UIScreen mainScreen].bounds.size.height : (isLandscape ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height))

#define kScreenWidth (isIOS8_or_Later ? [UIScreen mainScreen].bounds.size.width : (isLandscape ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width))


// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define XLDLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define XLDLog(...)
#endif

#endif /* LZBMainMacro_h */
