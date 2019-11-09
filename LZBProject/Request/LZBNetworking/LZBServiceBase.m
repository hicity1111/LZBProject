//
//  LZBServiceBase.m
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"
#import "AppDelegate.h"
#import "LYZCurrentVCHelper.h"

@implementation LZBServiceBase


- (BOOL)lzbManager:(id)hepler response:(id)response  entity:(LZBDataEntity *)entity{
    NSDictionary *result = response;
    
    if ([result[@"StatusCode"] integerValue] == 200) {
        return YES;
    } else if ([result[@"flag"] intValue] == kErrorFlagSuccess) {
        return YES;
    }else{
        return NO;
    }
}

- (NSDictionary *)necessaryParamsDictionary:(NSDictionary *)param{
    
    NSMutableDictionary *deviceParam = [NSMutableDictionary dictionaryWithDictionary:param];

//    deviceParam[@"deviceUUID"] = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    deviceParam[@"token"] = [Utils loadUserToken];
    //版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    deviceParam[@"appVersion"] = appVersion;
    deviceParam[@"appVersionCode"] = @"1";
    
    deviceParam[@"appChannelId"] = @"studentIosPhone";
    
    return deviceParam;
}

- (void)lzbManager:(id)helper response:(id)response error:(NSError *)error{
    if (error && response == nil) {
        NSHTTPURLResponse *response = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
        XLDLog(@"response == %@",response);
    }else if (error){
        switch (error.code) {
            case kErrorFlagShiBai:
                [[LYZCurrentVCHelper getCurrentVC] showError:response[@"message"]];
                XLDLog(@"请求失败");
                break;

            case kErrorFlagSuccess:
                XLDLog(@"请求成功");
                break;
            case kErrorFlagQiangZhiShengJi:
                XLDLog(@"强制升级");
                break;
                
            case kErrorFlagFeiQiangZhiShengJi:
                XLDLog(@"非强制升级");
                break;
                
            case kErrorFlagInvalidToken:{
                
                XLDLog(@"token失效");
                SETUSER_BOOL(IS_USER_LOGIN, NO);
                SDUserDefaultsSync;
                AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appd entryDoor];
            }
                break;
                
            default:
                break;
        }
    }
}

- (id)lzbManagerModel:(id)hepler response:(id)response entity:(nonnull LZBDataEntity *)entity{
    
    NSDictionary *resultDic = (NSDictionary *)response;
    Class cls;
    if ([IFISNIL(entity.responseClassName) length] > 0) {
        cls = NSClassFromString(IFISNIL(entity.responseClassName));
    } else {
        cls = [LZBAPIResponseBaseModel class];
    }
    id model = [cls mj_objectWithKeyValues:resultDic];
    return model;
}



- (LZBNetManager *)netManager{
    if (!_netManager) {
        _netManager = [LZBNetManager sharedLZBNetManager];
        _netManager.delegate = self;
    }
    return _netManager;
}

@end
