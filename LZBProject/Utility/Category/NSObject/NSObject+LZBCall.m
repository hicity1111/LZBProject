//
//  NSObject+LZBCall.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NSObject+LZBCall.h"

@implementation NSObject (LZBCall)

- (void)callWithPhoneNumber:(NSString *)pnum
          completionHandler:(void (^)(BOOL success))complition {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", pnum];
    NSURL *url = [NSURL URLWithString:str];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:url options:@{} completionHandler:complition];
}

@end
