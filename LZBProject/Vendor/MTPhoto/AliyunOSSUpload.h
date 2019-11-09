//
//  AliyunOSSUpload.h
//  LZBProject
//
//  Created by liyan on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *OSS_ENDPOINT = @"http://oss-cn-beijing.aliyuncs.com";

/**
 oss 图片上传Bucket
 开发临时  lochi-new
 准生产 lochi-plan
 测试 lochi-sit
 生产 lochi
 */
static NSString *OSS_IMAGE_BUCKET = @"lochi-sit";

///头像图片object key 前缀
static NSString *HEAD_URL = @"img/head/";

///作业图片object key 前缀
static NSString *HOMEWORK_URL = @"img/homework/";

///作业图片 object key 前缀
static NSString *HOMEWORK_URL_COMPOSITION = @"img/homework/composition";

///作业音频 object key 前缀
static NSString *HOMEWORK_AUDIO_URL = @"audio/homework/";


@interface AliyunOSSUpload : NSObject


+ (instancetype)sharedManager;



/// 创建上传组件
/// @param accessKeyId accessKeyId
/// @param secretKeyId secretKeyId
/// @param securityToken securityToken
- (OSSClient *)generateWithAccessKeyId:(NSString *)accessKeyId
                       secretKeyId:(NSString *)secretKeyId
                     securityToken:(NSString *)securityToken;




- (void)uploadImageData:(NSData *)imageData
         resultCallBack:(void(^)(NSString *imageUrl))result;

@end

NS_ASSUME_NONNULL_END
