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
        SETUSER_OBJ(KACCESS_TOKEN, token);
        [SDUserDefaults synchronize];
    }

}

+ (NSString *)loadUserToken {
    if (GETUSER_OBJ(KACCESS_TOKEN)) {
        return GETUSER_OBJ(KACCESS_TOKEN);
    }
    return nil;
}



@end
