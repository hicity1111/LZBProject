//
//  LZBTypeConvertHelper.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBTypeConvertHelper : NSObject

/// json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/// 字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
