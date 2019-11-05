//
//  UserModel.m
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UserModel.h"
#import "LYZSandBoxPath.h"

@implementation UserModel
MJExtensionCodingImplementation


static UserModel *manager = nil;
///单例
+ (instancetype)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserModel alloc] init];
    });
    return manager;
}

///释放单例
+ (void)deallocManager {
    manager = nil;
}



/**
 保存用户信息
 @param model 对象
 @param resBlock 保存结果
 */
+ (void)save:(id)model resBlock:(void(^)(BOOL res))resBlock {
    // 缓存路径
    NSString *filePath = [[LYZSandBoxPath path4Doucments] stringByAppendingPathComponent:@"userInfo.archiver"];
    // 归档
    BOOL saveSuccess = [NSKeyedArchiver archiveRootObject:model toFile:filePath];
    ///回调
    if (resBlock != nil)resBlock(saveSuccess);
}

/**
 查找用户信息
 */
+ (UserModel *)findUserInfoResult {
    // 缓存路径
    NSString *filePath = [[LYZSandBoxPath path4Doucments] stringByAppendingPathComponent:@"userInfo.archiver"];
    // 解档
    UserModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return userInfoModel;
}


/**
 登出后 移除用户信息
*/
+ (void)removeUserInfo {
    [UserModel save:nil resBlock:^(BOOL res) {}];
}


@end
