//
//  LZBServiceBase.h
//  LZBProject
//
//  Created by hicity on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZBNetManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    
    kErrorFlagShiBai                = 0,//失败
    kErrorFlagSuccess               = 1,//成功
    kErrorFlagQiangZhiShengJi       = 2,//强制升级
    kErrorFlagFeiQiangZhiShengJi    = 3,//非强制升级
    kErrorFlagInvalidToken          = 4,//token失效
    
} ErrorFlag;

@interface LZBServiceBase : NSObject <LZBNetManagerDelegate>

@property (nonatomic, strong) LZBNetManager *netManager;

- (NSDictionary *)necessaryParamsDictionary:(NSDictionary *)param;


@end

NS_ASSUME_NONNULL_END
