//
//  Utils.m
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "Utils.h"


@implementation Utils

+ (instancetype)sharedInstance {
    static Utils *instance;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[Utils alloc] init];
    });
    return instance;
}


+ (void)saveUserToken:(NSString *)token {
    if (token) {
        SETUSER_OBJ(ACCESS_TOKEN, token);
        [SDUserDefaults synchronize];
    }

}

+ (NSString *)loadUserToken {
    if (GETUSER_OBJ(ACCESS_TOKEN)) {
        return GETUSER_OBJ(ACCESS_TOKEN);
    }
    return nil;
}


+ (void)saveUserInfo:(NSDictionary *)userInfoDic{
    if (userInfoDic) {
        SETUSER_OBJ(USER_INFO, userInfoDic);
        [SDUserDefaults synchronize];
    }
}

+ (NSDictionary *)loadUserInfo{
    if (GETUSER_OBJ(USER_INFO)) {
        return GETUSER_OBJ(USER_INFO);
    }
    return nil;
}


@end
