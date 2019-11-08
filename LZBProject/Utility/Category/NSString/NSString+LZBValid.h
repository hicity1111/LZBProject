//
//  NSString+LZBValid.h
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LZBValid)

/// 有效的手机号码
- (BOOL)mh_isValidMobile;

/// 有效的密码（8-16位 数字+字母组合）
- (BOOL)lzb_isValidPassword;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 
 @discussion 可用于判断用户名或者密码是否为空
 */
- (BOOL)isNotEmpty;

/// 是否是nil/null
/// @param inputString 输入string
+ (BOOL)lzb_checkStringIsEmpty:(NSString *)inputString;


/// MD5加密
/// @param inputString  输入字符串
+ (NSString *)lzb_MD5:(NSString *) inputString;

/*
 * 功能 : 获取UTC时间
 * return : 返回UTC时间的字符串
 */
+ (NSString *)lzb_getDateUTCTime;

/// 判断字母数字组合
/// @param patternStr 输入字符串
+(BOOL)detectionIsPasswordQualified:(NSString *)patternStr;

@end

NS_ASSUME_NONNULL_END
