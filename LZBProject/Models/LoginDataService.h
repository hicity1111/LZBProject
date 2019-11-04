//
//  LoginDataService.h
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"
#import "LZBAPIResponseBaseModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginDataService : LZBServiceBase

+ (LoginDataService *)shareData;


- (void)loginWithUsername:(NSString *)username
password:(NSString *)password
 success:(void (^)(UserModel *user))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
