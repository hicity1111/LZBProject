//
//  LZBUtilsMacro.h
//  LZBProject
//
//  Created by hicity on 2019/10/25.
//  Copyright © 2019 hicity. All rights reserved.
//

#ifndef LZBUtilsMacro_h
#define LZBUtilsMacro_h


#pragma mark - 方法类

#define SDUserDefaults [NSUserDefaults standardUserDefaults]

#define GETUSER_VALUE(key)              [SDUserDefaults valueForKey:key];
#define GETUSER_OBJ(key)                [SDUserDefaults objectForKey:key];
#define GETUSER_BOOL(key)               [SDUserDefaults boolForKey:key];
#define GETUSER_INT(key)                [SDUserDefaults integerForKey:key];
#define GETUSER_DOUBLE(key)             [SDUserDefaults doubleForKey:key];
#define GETUSER_STRING(key)             [SDUserDefaults stringForKey:key];
#define GETUSER_ARRAY(key)              [SDUserDefaults arrayForKey:key];
#define GETUSER_DICT(key)               [SDUserDefaults dictionaryForKey:key];
#define GETUSER_DATA(key)               [SDUserDefaults dataForKey:key];
#define GETUSER_URL(key)                [SDUserDefaults URLForKey:key];


#define SETUSER_VALUE(key, value)     [SDUserDefaults setValue:value forKey:key]
#define SETUSER_OBJ(key, value)       [SDUserDefaults setObject:value forKey:key]
#define SETUSER_BOOL(key, value)      [SDUserDefaults setBool:value forKey:key]
#define SETUSER_INT(key, value)       [SDUserDefaults setInteger:value forKey:key]
#define SETUSER_DOUBLE(key, value)    [SDUserDefaults setDouble:value forKey:key]
#define SETUSER_URL(key, value)       [SDUserDefaults setURL:value forKey:key]





#pragma mark - 字符串

/// 网络请求 token
#define KACCESS_TOKEN       @"usertoken"

/// 是否同意 用户须知 key
#define AGREEUSERNOTICE     @"agreeUserNotice"

#endif /* LZBUtilsMacro_h */
