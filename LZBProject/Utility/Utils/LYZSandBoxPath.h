//
//  LYZSandBoxPath.h
//  Format
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYZSandBoxPath : NSObject

/**获得根目录*/
+ (NSString *)path4Home;

/**获得path4Doucments目录*/
+ (NSString *)path4Doucments;

/**获得Library目录*/
+ (NSString *)path4Library;

/**获得Tmp目录*/
+ (NSString *)path4Tmp;

/**获得Library目录下的Caches目录*/
+ (NSString *)path4LibraryCaches;

#pragma mark - 获取设备的总容量和可用容量
/// 获取设备总容量
+ (CGFloat)totalDiskSpace;
/// 获取设备剩余容量
+ (CGFloat)freeDiskSpace;

@end
