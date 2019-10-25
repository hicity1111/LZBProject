//
//  Utils.m
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "Utils.h"


@implementation Utils

+ (instancetype)sharedInstance{
    static Utils *instance;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[Utils alloc] init];
    });
    return instance;
}


+ (void)saveUserToken:(NSString *)token{
    if (token) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:KACCESS_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

+(NSString*)loadUserToken
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KACCESS_TOKEN]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:KACCESS_TOKEN];
    }else{
        return nil;
    }
}



@end
