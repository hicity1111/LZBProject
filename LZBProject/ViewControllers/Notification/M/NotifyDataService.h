//
//  NotifyDataService.h
//  LZBProject
//
//  Created by liyan on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotifyDataService : LZBServiceBase

///单例对象
+ (NotifyDataService *)shareData;


/// 获取学生消息列表
/// @param noticeType 消息类型    非必传，只有点击重批申请时传入值：9，10(逗号分隔)普通消息不传
/// @param studentInfoId 学生id
- (void)obtainMessageList:(NSString *)noticeType
            studentInfoId:(NSString *)studentInfoId
                  success:(void (^)(LZBAPIResponseBaseModel *baseM))success
                  failure:(void (^)(NSError *error))failure;



@end

NS_ASSUME_NONNULL_END
