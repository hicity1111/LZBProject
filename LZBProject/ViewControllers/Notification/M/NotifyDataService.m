//
//  NotifyDataService.m
//  LZBProject
//
//  Created by liyan on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotifyDataService.h"
#import "LZBNetworkURL.h"


@implementation NotifyDataService

+ (NotifyDataService *)shareData{
    static NotifyDataService *dataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataService = [[NotifyDataService alloc] init];
    });
    return dataService;
}



/// 获取学生消息列表
- (void)obtainMessageList:(NSString *)noticeType
studentInfoId:(NSString *)studentInfoId
      success:(void (^)(LZBAPIResponseBaseModel *baseM))success
      failure:(void (^)(NSError *error))failure {
    
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
//    entity.urlString = NotifyListAPI_full;
    entity.urlString = @"http://192.168.7.157:8082/studentApi/student/notice/getList";
    NSDictionary *paramsDict = @{@"currentPage": @(1),
                                 @"pageSize": @(12),
                                 @"studentInfoId": studentInfoId
    };
    //传入必要的参数
    entity.parameters = [self necessaryParamsDictionary:paramsDict];
    
    [self.netManager lzb_request_getWithEntity:entity successBlock:^(id  _Nonnull reponse) {
        !success ?: success(reponse);
    } failureBlock:^(NSError * _Nonnull error) {
        !failure ?: failure(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {}];
  
}

- (void)loadMoreMessageList:(NSString *)studentInfoId
                       page:(NSInteger)page
                    success:(void (^)(LZBAPIResponseBaseModel *baseM))success
                    failure:(void (^)(NSError *error))failure {
        LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    //    entity.urlString = NotifyListAPI_full;
        entity.urlString = @"http://192.168.7.157:8082/studentApi/student/notice/getList";
        NSDictionary *paramsDict = @{@"currentPage": @(page),
                                     @"pageSize": @(12),
                                     @"studentInfoId": studentInfoId
        };
        //传入必要的参数
        entity.parameters = [self necessaryParamsDictionary:paramsDict];
        
        [self.netManager lzb_request_getWithEntity:entity successBlock:^(id  _Nonnull reponse) {
            !success ?: success(reponse);
        } failureBlock:^(NSError * _Nonnull error) {
            !failure ?: failure(error);
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {}];
}


///获取未读消息数
- (void)loadUnreadMessageCountSuccess:(void (^)(LZBAPIResponseBaseModel *baseM))success         failure:(void (^)(NSError *error))failure {
        LZBDataEntity *entity = [[LZBDataEntity alloc] init];
        UserModel *infoM = [UserModel findUserInfoResult];
        entity.urlString = @"http://192.168.7.157:8082//studentApi/student/notice/notReadCount";
        NSDictionary *paramsDict = @{ @"studentInfoId": [NSString stringWithFormat:@"%@", infoM.studentInfoId] };
        //传入必要的参数
        entity.parameters = [self necessaryParamsDictionary:paramsDict];
        [self.netManager lzb_request_getWithEntity:entity successBlock:^(id  _Nonnull reponse) {
            !success ?: success(reponse);
        } failureBlock:^(NSError * _Nonnull error) {
            !failure ?: failure(error);
        } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {}];
}


@end
