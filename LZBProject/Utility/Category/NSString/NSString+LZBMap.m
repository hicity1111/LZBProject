//
//  NSString+LZBMap.m
//  LZBProject
//
//  Created by liyan on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NSString+LZBMap.h"


@implementation NSString (LZBMap)

+ (NSString *)mt_abbreviationMap:(NSString *)fromString {
    if ([IFISNIL(fromString) length] <= 0) return @"";
    NSDictionary *dict = @{@"yingyu": @"英语",
                           @"shuxue": @"数学",
                           @"yuwen": @"语文",
                           @"dili": @"地理",
                           @"huaxue": @"化学",
                           @"lishi": @"历史",
                           @"shengwu": @"生物",
                           @"wuli": @"物理",
                           @"zhengzhi": @"政治",
    };
    
    if ([dict.allKeys containsObject:IFISNIL(fromString)]) {
        return dict[fromString];
    }
    return @"";
}


@end
