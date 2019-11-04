//
//  LZBServiceBase.m
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"

@implementation LZBServiceBase


- (BOOL)lzbManager:(id)hepler response:(id)response{
    NSDictionary *result = response;
    
    if ([result[@"flag"] intValue] == kErrorFlagSuccess) {
        return YES;
    }else{
        return NO;
    }
}

- (NSDictionary *)necessaryParamsDictionary:(NSDictionary *)param{
    
    NSMutableDictionary *deviceParam = [NSMutableDictionary dictionaryWithDictionary:param];

    //暂时不知道是否可行
    deviceParam[@"deviceId"] = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    deviceParam[@"token"] = [Utils loadUserToken];
    //版本号
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    deviceParam[@"ver"] = appVersion;
    
    return deviceParam;
}

- (void)lzbManager:(id)helper response:(id)response error:(NSError *)error{
    if (error && response == nil) {
        NSHTTPURLResponse *response = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
        XLDLog(@"response == %@",response);
    }else if (error){
        switch (error.code) {
            case kErrorFlagShiBai:
                XLDLog(@"请求失败");
                break;

            case kErrorFlagSuccess:
                XLDLog(@"请求成功");
                break;
            case kErrorFlagQiangZhiShenJi:
                XLDLog(@"非强制审计");
                break;
                
            case kErrorFlagFeiQiangZhiShenJi:
                XLDLog(@"非强制升级");
                break;
                
            case kErrorFlagInvalidToken:
                XLDLog(@"token失效");
                break;
                
            default:
                break;
        }
    }
}

- (LZBNetManager *)netManager{
    if (!_netManager) {
        _netManager = [LZBNetManager sharedLZBNetManager];
        _netManager.delegate = self;
    }
    return _netManager;
}
@end
