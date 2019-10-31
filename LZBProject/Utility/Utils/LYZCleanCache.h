//
//  LYZCleanCache.h
//  FirstExercise
//
//  Created by qianfeng on 15/12/11.
//  Copyright © 2015年 刘义增. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYZCleanCache : NSObject



+ (instancetype)sharedCleanManager;

/**
 * @brief 计算单个文件的大小 (单位：Byte)
 *
 * @param filePath 要计算大小的文件路径
 *
 * @return long long 返回文件夹大小(Byte)
 */
- (long long)fileSizeAtPath:(NSString*)filePath;


/** 
 * @brief 计算文件夹的大小 (单位：MB)
 *
 * @param folderPath 要计算大小的文件夹路径
 *
 * @return float 返回文件夹大小(MB)
 */
- (float)folderSizeAtPath:(NSString*)folderPath;


/**
 * @brief 清理文件夹
 *
 * @param path 要清理的文件夹路径
 */
- (void)cleanFoldersWithPath:(NSString *)path;


/**
 * @brief 通知用户文件清理完成
 *
 * @param view 要显示的token所在View
 *
 * @param msg 通知用户的信息内容
 */
- (void)tokenAnimationWithView:(UIView *)view message:(NSString *)msg;



@end
