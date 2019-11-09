//
//  LZBMainMacro.h
//  LZBProject
//
//  Created by hicity on 2019/10/11.
//  Copyright © 2019 hicity. All rights reserved.
//

#ifndef LZBMainMacro_h
#define LZBMainMacro_h


#define kSysVersion [UIDevice currentDevice].systemVersion.floatValue
#define isIOS8_or_Later (kSysVersion >= 8.0)


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
#define kStatusBar_Height ((iPhoneX || iPhoneXSMax || iPhoneXR) ? 44.0f : 20.0f)
//底部安全高度
#define kBottomSafeSpace ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 34 : 0)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

/// 判断字符串是否为空
#define IFISNIL(v)                                 (v = (v != nil) ? v : @"")

//NavigationBar的高度
#define kNavBar_Height 44

#define kScreenBounds [UIScreen mainScreen].bounds

#define kScreenWidth  kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height

#define kWidthScale  (kScreenWidth / 375.f)
#define kHeightScale (kScreenHeight / 667.f)

#define kAnimationDuration  0.25

//手势宏定义
#define LZBTAPGES(tapName, tapAct) UIGestureRecognizer *tapName = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
    #define XLDLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
    #define XLDLog(...)
#endif

#ifndef IMAGE_NAMED
    #define IMAGE_NAMED(__imageName__)\
    [UIImage imageNamed:__imageName__]
#endif

#ifndef SYSTEM_FONT
    #define SYSTEM_FONT(__fontsize__)\
    [UIFont lzb_fontForPingFangSC_RegularFontOfSize:__fontsize__]
#endif

#ifndef BOLD_FONT
    #define BOLD_FONT(__fontsize__)\
    [UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:__fontsize__]
#endif


#define LZBWeak __weak __typeof(self) weakSelf = self

#endif /* LZBMainMacro_h */

