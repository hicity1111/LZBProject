//
//  LoginDataService.m
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginDataService.h"
#import "LZBNetworkURL.h"
#import "LZBNetManager.h"

@implementation LoginDataService

+ (LoginDataService *)shareData{
    
    static LoginDataService *dataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataService = [[LoginDataService alloc] init];
    });
    return dataService;
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(void (^)(UserModel * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    LZBDataEntity *entity = [[LZBDataEntity alloc] init];
    entity.urlString = LoginUrl_full;
    entity.parameters = @{@"userName": username, @"password": password, @"appChannelId": @"studentApp"};
    self.responseClassName = NSStringFromClass([UserModel class]);
    //传入必要的参数
//    entity.parameters = [self necessaryParamsDictionary:@{@"userName": username, @"password": password, @"appChannelId": @"studentApp"}];
    [self.netManager lzb_request_postWithEntity:entity successBlock:^(UserModel *model) {
        if (success) {
            success(model.infos);
        }
    } failureBlock:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
    
}




@end
