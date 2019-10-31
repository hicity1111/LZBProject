//
//  LYZSandBoxPath.m
//  Format
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 lyz. All rights reserved.
//

#import "LYZSandBoxPath.h"

@implementation LYZSandBoxPath

/** 沙盒主目录 */
+ (NSString *)path4Home {
    return NSHomeDirectory();
}

/** 获得 Documents 目录 （app根目录） */
+ (NSString *)path4Doucments {
    
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

/** 获得 Library 目录 */
+ (NSString *)path4Library {
    
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
}

/** 获得 Tmp 目录 */
// 程序退出后，系统会自动清理文件夹中的缓存
+ (NSString *)path4Tmp {
    
    return NSTemporaryDirectory();
}

/** 获得 Caches 目录（Library目录下） */
// 清理缓存需要用到的目录
+ (NSString *)path4LibraryCaches {
    
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}


#pragma mark - 获取设备的总容量和可用容量
+ (CGFloat)totalDiskSpace {
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory()
                                                                                         error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] doubleValue] / 1024.f / 1024.f;
}

+ (CGFloat)freeDiskSpace {
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory()
                                                                                        error:nil ];
    return [[fattributes objectForKey:NSFileSystemFreeSize] doubleValue] / 1024.f / 1024.f;
}



@end
