//
//  LZBTypeConvertHelper.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBTypeConvertHelper.h"

@implementation LZBTypeConvertHelper


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
/// json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/// 字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic {

    NSError *parseError = nil;
    // NSJSONWritingPrettyPrinted  是有换位符的。
    // 如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end
