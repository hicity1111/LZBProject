//
//  AliyunOSSUpload.m
//  LZBProject
//
//  Created by liyan on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "AliyunOSSUpload.h"
#import "NSDate+MTExtension.h"

@interface AliyunOSSUpload()

///客户端上传组件
@property (nonatomic, strong) OSSClient *client;

@end

@implementation AliyunOSSUpload


+ (instancetype)sharedManager {
    static AliyunOSSUpload *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AliyunOSSUpload alloc] init];
    });
    
    return _manager;
}


/// 创建上传组件
/// @param accessKeyId accessKeyId
/// @param secretKeyId secretKeyId
/// @param securityToken securityToken
- (OSSClient *)generateWithAccessKeyId:(NSString *)accessKeyId
                       secretKeyId:(NSString *)secretKeyId
                     securityToken:(NSString *)securityToken {
  ///移动端建议使用STS方式初始化OSSClient。可以通过sample中STS使用说明了解更多(https://github.com/aliyun/aliyun-oss-ios-sdk/tree/master/DemoByOC)
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKeyId secretKeyId:secretKeyId securityToken:securityToken];

    _client = [[OSSClient alloc] initWithEndpoint:OSS_ENDPOINT credentialProvider:credential];
                         return _client;
}


/*
 oss 路径
img/head/年月日/id+时间戳.jpg   头像路径
img/homework/学科编码（shuxue）/年月日/uuid.jpg
 */
- (void)uploadImageData:(NSData *)imageData
         resultCallBack:(void(^)(NSString *imageUrl))result {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = OSS_IMAGE_BUCKET;
    NSString *objectKey = [self generateObjectKey];
    NSLog(@"objectKey == %@", objectKey);
    put.objectKey = objectKey;
    put.uploadingData = imageData; // 直接上传NSData
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [_client putObject:put];
    MJWeakSelf
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
//            //签名私有资源指定有效时长的访问URL
//            OSSTask * task = [weakSelf.client presignConstrainURLWithBucketName:OSS_IMAGE_BUCKET
//                                                         withObjectKey:objectKey
//                                                withExpirationInterval: 30 * 60];
            
            OSSTask *task = [weakSelf.client presignPublicURLWithBucketName:OSS_IMAGE_BUCKET
                                            withObjectKey:objectKey];
            NSLog(@"result == %@", task.result);
            !result ?: result(task.result);
            
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    // 可以等待任务完成
    // [putTask waitUntilFinished];
}


- (NSString *)generateObjectKey {
    NSString *header = HEAD_URL;
    NSString *uuid = [self createCUID];
    NSString *dateString = [[NSDate date] mt_stringWithFormate:@"yyyy/MM/dd"];
    NSString *timeStamp = [[NSDate date] mt_timeStamp];
    return [NSString stringWithFormat:@"%@%@/%@/%@.jpg", header, dateString,uuid,timeStamp];
}

- (NSString *)createCUID{
    NSString *result = @"";
    CFUUIDRef  uuid;
    CFStringRef uuidStr;
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    result = [NSString stringWithFormat:@"%@", uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return result;
}




@end
