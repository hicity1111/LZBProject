//
//  NSObject+charValid.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (charValid)

- (BOOL)isChar0to9:(char)c;

- (BOOL)isCharatoz:(char)c;

- (BOOL)isCharAtoZ:(char)c;

- (BOOL)isNumberChar:(char)c;

- (BOOL)isLowerChar:(char)c;

- (BOOL)isUpperChar:(char)c;

- (BOOL)isAlphabetChar:(char)c;

- (BOOL)isAlphaNumChar:(char)c;

@end

NS_ASSUME_NONNULL_END
