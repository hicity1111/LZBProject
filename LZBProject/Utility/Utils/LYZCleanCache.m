//
//  LYZCleanCache.m
//  FirstExercise
//
//  Created by qianfeng on 15/12/11.
//  Copyright © 2015年 刘义增. All rights reserved.
//

#import "LYZCleanCache.h"

@implementation LYZCleanCache

+ (instancetype)sharedCleanManager {
    static LYZCleanCache *clean = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clean = [[LYZCleanCache alloc] init];
    });
    return clean;
}

// 计算单个文件大小 (单位：Byte)
- (long long)fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少 M
- (float)folderSizeAtPath:(NSString*)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    
    // 文件夹不存在
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    // 文件夹存在
    long long folderSize = 0;
    // for-in 遍历
    NSArray *subFiles = [manager subpathsAtPath:folderPath];
    for (NSString *fileName in subFiles) {
        NSString *absolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:absolutePath];
    }
    return folderSize / (1024 * 1024.f);
}

// 清理文件目录
- (void)cleanFoldersWithPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

- (void)tokenAnimationWithView:(UIView *)view
                       message:(NSString *)msg {
    // 动画 显示一个Label，再消失
    CGFloat lb_h = 20;
    CGFloat lb_w = 80;
    /// 距离底部距离
    CGFloat lb_margin = 100;
    UILabel *token = [[UILabel alloc] initWithFrame:CGRectZero];
    token.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.7];
    
    token.text = msg;
    token.textColor = [UIColor whiteColor];
    token.textAlignment = NSTextAlignmentCenter;
    token.font = [UIFont boldSystemFontOfSize:15.f];
    
    CGSize fitSize = [token sizeThatFits:CGSizeMake(100, lb_h)];
    lb_w = fitSize.width + 20;
    CGRect rect = CGRectMake((kScreenWidth - lb_w) / 2, kScreenHeight - lb_margin - lb_h, lb_w, lb_h);
    token.frame = rect;
    
    [view addSubview:token];
    
    token.alpha = 0.f;
    [UIView animateWithDuration:1.2 animations:^{
        token.alpha = 1.f;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.2 animations:^{
            token.alpha = 0;
        } completion:^(BOOL finished) {
            [token removeFromSuperview];
        }];
    }];
    
}

@end
