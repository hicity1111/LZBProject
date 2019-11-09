//
//  HomeDataService.m
//  LZBProject
//
//  Created by hicity on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeDataService.h"

@implementation HomeDataService

+ (HomeDataService *)shareDate{
    static HomeDataService *dataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataService = [[HomeDataService alloc] init];
    });
    return dataService;
}

- (void)loadRequestDic:(NSDictionary *)resultDic success:(void (^)(NSArray *))success failure:(void (^)(NSError * _Nonnull))failure{
    
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    entity.urlString = HomeWork_full;
    entity.parameters = [self necessaryParamsDictionary:resultDic];
    [self.netManager lzb_request_postWithEntity:entity successBlock:^(LZBAPIResponseBaseModel *model) {
        
        if (success) {
            
            NSArray *resultModelArr = [HomeModel mj_objectArrayWithKeyValuesArray:model.infos];
            success(resultModelArr);
        }
        
    } failureBlock:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}

@end
