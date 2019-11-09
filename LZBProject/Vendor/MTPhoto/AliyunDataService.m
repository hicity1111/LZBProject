//
//  AliyunDataService.m
//  LZBProject
//
//  Created by liyan on 2019/11/8.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "AliyunDataService.h"

@implementation AliyunModel

@end

@implementation AliyunDataService

+ (AliyunDataService *)shareData{
    static AliyunDataService *dataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataService = [[AliyunDataService alloc] init];
    });
    return dataService;
}



///服务鉴权
- (void)obtainOssAuthorizationInfoWithStudentID:(NSString *)studentId
                                        success:(void (^)(AliyunModel *baseM))success
                                        failure:(void (^)(NSError *error))failure; {
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    entity.responseClassName = NSStringFromClass([AliyunModel class]);
    entity.urlString = BASEURL(@"/api/system/getOssAuthorizationInfoForStudent");
    NSDictionary *paramsDict = @{ @"studentName": IFISNIL(studentId) };
    //传入必要的参数
    entity.parameters = [self necessaryParamsDictionary:paramsDict];
        
    [self.netManager lzb_request_getWithEntity:entity successBlock:^(id  _Nonnull reponse) {
        !success ?: success(reponse);
    } failureBlock:^(NSError * _Nonnull error) {
        !failure ?: failure(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {}];
}


///更新本地服务器 用户头像url
- (void)updateUserHeadUrl:(NSString *)headUrl
            studentInfoId:(NSString *)studentInfoId
                  success:(void (^)(LZBAPIResponseBaseModel *baseM))success
                  failure:(void (^)(NSError *error))failure {
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    entity.urlString = BASEURL(@"/api/student/updateHeadPice");
    NSDictionary *paramsDict = @{ @"studentInfoId": IFISNIL(studentInfoId),
                                  @"imagePath": IFISNIL(headUrl)
    };
    //传入必要的参数
    entity.parameters = [self necessaryParamsDictionary:paramsDict];
    
    [self.netManager lzb_request_postWithEntity:entity successBlock:^(LZBAPIResponseBaseModel *reponse) {
        !success ?: success(reponse);
    } failureBlock:^(NSError * _Nonnull error) {
        !failure ?: failure(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


@end
