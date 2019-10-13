//
//  UIFont+LZBExtension.m
//  LZBProject
//
//  Created by hicity on 2019/10/11.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UIFont+LZBExtension.h"

 
/**
 *  极细体
 */
static NSString *const MHPingFangSC_Ultralight = @"PingFangSC-Ultralight";
/**
 *  常规体
 */
static NSString *const MHPingFangSC_Regular = @"PingFangSC-Regular";
/**
 *  中粗体
 */
static NSString *const MHPingFangSC_Semibold = @"PingFangSC-Semibold";
/**
 *  纤细体
 */
static NSString *const MHPingFangSC_Thin = @"PingFangSC-Thin";
/**
 *  细体
 */
static NSString *const MHPingFangSC_Light = @"PingFangSC-Light";
/**
 *  中黑体
 */
static NSString *const MHPingFangSC_Medium = @"PingFangSC-Medium";


@implementation UIFont (LZBExtension)


/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Ultralight size:fontSize];
}

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Regular size:fontSize];
}

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Semibold size:fontSize];
}

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Thin size:fontSize];
}

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Light size:fontSize];
}

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) lzb_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:MHPingFangSC_Medium size:fontSize];
}


@end
