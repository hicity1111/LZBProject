//
//  UIFont+LZBExtension.h
//  LZBProject
//
//  Created by hicity on 2019/10/11.
//  Copyright © 2019 hicity. All rights reserved.
//
/**
*  Mike_He 但是苹方字体 iOS9.0+出现  需要做适配
*  这个分类主要用来 字体...
(
"PingFangSC-Ultralight",
"PingFangSC-Regular",
"PingFangSC-Semibold",
"PingFangSC-Thin",
"PingFangSC-Light",
"PingFangSC-Medium"
)
*/


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

//ios 版本
#define LZB_IOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

//设置系统的字体大小（YES：粗体 NO：常规

#define LZBFont(__size__,__bold__)((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))

//极细体
#define LZBThinFont(__size__)       ((LZB_IOSVersion<9.0)?LZBFont(__size__,YES):[UIFont lzb_fontForPingFangSC_UltralightFontOfSize:__size__])

/// 细体
#define LZBLightFont(__size__)      ((LZB_IOSVersion<9.0)?LZBFont(__size__ , YES):[UIFont lzb_fontForPingFangSC_LightFontOfSize:__size__])

// 中等
#define LZBMediumFont(__size__)     ((LZB_IOSVersion<9.0)?LZBFont(__size__ , YES):[UIFont lzb_fontForPingFangSC_MediumFontOfSize:__size__])

// 常规
#define LZBRegularFont(__size__)    ((LZB_IOSVersion<9.0)?LZBFont(__size__ , NO):[UIFont lzb_fontForPingFangSC_RegularFontOfSize:__size__])

/** 中粗体 */
#define LZBSemiboldFont(__size__)   ((LZB_IOSVersion<9.0)?LZBFont(__size__ , YES):[UIFont lzb_fontForPingFangSC_SemiboldFontOfSize:__size__])

@interface UIFont (LZBExtension)

/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize;

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize;

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
