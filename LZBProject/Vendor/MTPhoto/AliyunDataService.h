//
//  AliyunDataService.h
//  LZBProject
//
//  Created by liyan on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"

@interface AliyunModel : NSObject

/*鉴权id*/
@property (nonatomic, copy) NSString *AccessKeyId;

/*鉴权密钥*/
@property (nonatomic, copy) NSString *AccessKeySecret;

/*鉴权失效时间 */
@property (nonatomic, copy) NSString *Expiration;

/*鉴权令牌*/
@property (nonatomic, copy) NSString *SecurityToken;

/*鉴权code 200 成功*/
@property (nonatomic, copy) NSString *StatusCode;

@end


@interface AliyunDataService : LZBServiceBase

///单例对象
+ (AliyunDataService *)shareData;

///服务鉴权
- (void)obtainOssAuthorizationInfoWithStudentID:(NSString *)studentId
                                        success:(void (^)(AliyunModel *baseM))success
                                        failure:(void (^)(NSError *error))failure;

///更新本地服务器 用户头像url
- (void)updateUserHeadUrl:(NSString *)headUrl
            studentInfoId:(NSString *)studentInfoId
                  success:(void (^)(LZBAPIResponseBaseModel *baseM))success
                  failure:(void (^)(NSError *error))failure;

@end

