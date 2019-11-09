//
//  NSObject+charValid.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NSObject+charValid.h"


@implementation NSObject (charValid)

- (BOOL)isChar0to9:(char)c {
    return (c >= 48 && c <= 57);
}

- (BOOL)isCharatoz:(char)c {
    return (c >= 97 && c <= 122);
}

- (BOOL)isCharAtoZ:(char)c {
    return (c >= 65 && c <= 90);
}

- (BOOL)isNumberChar:(char)c {
    return [self isChar0to9:c];
}

- (BOOL)isLowerChar:(char)c {
    return [self isCharatoz:c];
}

- (BOOL)isUpperChar:(char)c {
    return [self isCharAtoZ:c];
}

- (BOOL)isAlphabetChar:(char)c {
    return ([self isLowerChar:c] || [self isUpperChar:c]);
}

- (BOOL)isAlphaNumChar:(char)c {
    return ([self isAlphabetChar:c] || [self isNumberChar:c]);
}

@end
