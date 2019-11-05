//
//  CTB_SubjectDataService.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "CTB_SubjectDataService.h"

@implementation CTB_SubjectDataService

+ (CTB_SubjectDataService *)sharedService{
    static CTB_SubjectDataService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CTB_SubjectDataService alloc] init];
    });
    return service;
}

- (void)requestDataWithSuccessBlock:(void (^)(LZBAPIResponseBaseModel * _Nonnull))success failureBlock:(void (^)(NSError * _Nonnull))failure {
    UserModel *uModel = [UserModel findUserInfoResult];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:[self necessaryParamsDictionary:@{@"studentInfoId": uModel.studentInfoId}]];
    [param removeObjectForKey:@"deviceUUID"];
    
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    entity.urlString = CTBSSubject_full;
    entity.parameters = param;
    
    [self.netManager lzb_request_postWithEntity:entity successBlock:^(LZBAPIResponseBaseModel *model) {
        
        !success ?: success(model);
    } failureBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        !failure ?: failure(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
//    [self.netManager lzb_request_getWithEntity:entity successBlock:^(LZBAPIResponseBaseModel *model) {
//        CTB_SubjectModel *sModel = [CTB_SubjectModel mj_objectWithKeyValues:model.infos];
//        success(sModel);
//    } failureBlock:^(NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
}



@end
