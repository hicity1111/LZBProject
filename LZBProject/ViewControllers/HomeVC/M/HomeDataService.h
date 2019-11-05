//
//  HomeDataService.h
//  LZBProject
//
//  Created by hicity on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDataService : LZBServiceBase

+ (HomeDataService *)shareDate;

/// 学生作业列表

- (void)loadRequestDic:(NSDictionary *)resultDic success:(void (^)(NSArray *modelArr))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
